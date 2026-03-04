-- SPDX-License-Identifier: MIT
-- SPDX-FileCopyrightText: 2026 Yavuzâlp Dal
--
-- Bibliography (.bib) validator for this project.
-- Checks that required fields are present for each entry type,
-- detects duplicate keys, validates year format, and reports
-- all issues to stdout with file name and line number.
--
-- Usage:
--   lua scripts/check-bib.lua [FILE...]
--   lua scripts/check-bib.lua Ausarbeitung/Ausarbeitung.bib
--
-- If no files are given, defaults to Ausarbeitung/Ausarbeitung.bib.

-- Required fields per BibTeX entry type (strict subset; others allowed)
local REQUIRED_FIELDS = {
    article      = {"author", "title", "journal", "year"},
    book         = {"author", "title", "publisher", "year"},
    inbook       = {"author", "title", "chapter", "publisher", "year"},
    incollection = {"author", "title", "booktitle", "year"},
    inproceedings= {"author", "title", "booktitle", "year"},
    proceedings  = {"title", "year"},
    phdthesis    = {"author", "title", "school", "year"},
    mastersthesis= {"author", "title", "school", "year"},
    techreport   = {"author", "title", "institution", "year"},
    manual       = {"title"},
    unpublished  = {"author", "title", "note"},
    misc         = {},
    online       = {"url"},
}

local function read_file(path)
    local f = io.open(path, "r")
    if not f then return nil, "cannot open '" .. path .. "'" end
    local content = f:read("*a")
    f:close()
    return content
end

-- Parse a .bib file and return a list of entries.
-- Each entry is { type, key, fields = {field = value, ...}, line = N }
local function parse_bib(content)
    local entries = {}

    -- Build a newline-offset table once so line_at() is O(log n).
    local newlines = {}
    for nl_pos in content:gmatch("()\n") do
        newlines[#newlines + 1] = nl_pos
    end

    -- Return the 1-based line number for a given byte offset.
    local function line_at(offset)
        local lo, hi = 1, #newlines
        while lo <= hi do
            local mid = math.floor((lo + hi) / 2)
            if newlines[mid] < offset then
                lo = mid + 1
            else
                hi = mid - 1
            end
        end
        return lo   -- number of newlines before offset + 1
    end

    -- Iterate over @TYPE{KEY, ...} blocks
    for entry_type, rest_start in content:gmatch("@(%a+)%s*[{(]()") do
        local etype = entry_type:lower()
        if etype ~= "comment" and etype ~= "preamble" and etype ~= "string" then
            -- Find matching closing brace by counting depth
            local depth = 1
            local i = rest_start
            local entry_body = {}
            while i <= #content and depth > 0 do
                local ch = content:sub(i, i)
                if ch == "{" then
                    depth = depth + 1
                elseif ch == "}" then
                    depth = depth - 1
                    if depth == 0 then break end
                end
                table.insert(entry_body, ch)
                i = i + 1
            end
            local body = table.concat(entry_body)

            -- Extract key (first token before the first comma)
            local key = body:match("^%s*([^,%s]+)")
            if key then
                -- Extract single-word / quoted fields
                local fields = {}
                for fname, fval in body:gmatch(",?%s*(%a[%a%d_%-]*)%s*=%s*[{\"']?([^,}\"']+)[,}\"']?") do
                    fields[fname:lower()] = fval:match("^%s*(.-)%s*$")
                end
                -- Also detect multi-word braced fields not yet captured
                for fname in body:gmatch(",?%s*(%a[%a%d_%-]*)%s*=%s*{") do
                    if not fields[fname:lower()] then
                        fields[fname:lower()] = "(present)"
                    end
                end
                table.insert(entries, {
                    type   = etype,
                    key    = key,
                    fields = fields,
                    line   = line_at(rest_start),
                })
            end
        end
    end
    return entries
end

local function check_entries(entries, path)
    local errors = 0
    local warnings = 0

    -- Duplicate-key detection
    local seen_keys = {}
    for _, entry in ipairs(entries) do
        local lkey = entry.key:lower()
        if seen_keys[lkey] then
            io.write(string.format("[ERROR] %s:%d @%s{%s}: duplicate key (first seen at line %d)\n",
                path, entry.line, entry.type, entry.key, seen_keys[lkey]))
            errors = errors + 1
        else
            seen_keys[lkey] = entry.line
        end
    end

    for _, entry in ipairs(entries) do
        local loc = string.format("%s:%d @%s{%s}", path, entry.line, entry.type, entry.key)
        local required = REQUIRED_FIELDS[entry.type]

        -- Unknown entry type
        if required == nil then
            io.write(string.format("[WARN]  %s: unknown entry type\n", loc))
            warnings = warnings + 1
        else
            -- Missing required fields
            for _, field in ipairs(required) do
                if not entry.fields[field] then
                    io.write(string.format("[ERROR] %s: missing required field '%s'\n", loc, field))
                    errors = errors + 1
                end
            end
        end

        -- Missing year (not required for misc/online but still useful to flag)
        if entry.type ~= "misc" and entry.type ~= "online" and not entry.fields["year"] then
            io.write(string.format("[WARN]  %s: missing 'year' field\n", loc))
            warnings = warnings + 1
        end

        -- Year must be a 4-digit number when present
        local yr = entry.fields["year"]
        if yr and not yr:match("^%d%d%d%d$") then
            io.write(string.format("[WARN]  %s: 'year' value '%s' is not a 4-digit number\n", loc, yr))
            warnings = warnings + 1
        end

        -- URL field should look like a URL for @online entries
        if entry.type == "online" then
            local url = entry.fields["url"]
            if url and not url:match("^https?://") and not url:match("^ftp://") then
                io.write(string.format("[WARN]  %s: 'url' value does not look like a URL: %s\n", loc, url))
                warnings = warnings + 1
            end
        end
    end
    return errors, warnings
end

-- Determine files to process
local files = {}
if #arg > 0 then
    for _, f in ipairs(arg) do
        table.insert(files, f)
    end
else
    table.insert(files, "Ausarbeitung/Ausarbeitung.bib")
end

local total_entries  = 0
local total_errors   = 0
local total_warnings = 0
local any_file_error = false

for _, path in ipairs(files) do
    local content, err = read_file(path)
    if content then
        local entries = parse_bib(content)
        local errors, warnings = check_entries(entries, path)
        total_entries  = total_entries  + #entries
        total_errors   = total_errors   + errors
        total_warnings = total_warnings + warnings
        io.write(string.format("%-50s  %3d entries, %2d errors, %2d warnings\n",
            path, #entries, errors, warnings))
    else
        io.stderr:write("Error: " .. err .. "\n")
        any_file_error = true
    end
end

if #files > 1 then
    io.write(string.rep("-", 65) .. "\n")
    io.write(string.format("%-50s  %3d entries, %2d errors, %2d warnings\n",
        "Total", total_entries, total_errors, total_warnings))
end

if total_errors > 0 or any_file_error then
    os.exit(1)
else
    os.exit(0)
end
