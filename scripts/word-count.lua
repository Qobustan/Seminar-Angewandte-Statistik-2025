-- SPDX-License-Identifier: MIT
-- SPDX-FileCopyrightText: 2026 Yavuzâlp Dal
--
-- Word count tool for LaTeX documents.
-- Strips LaTeX commands and environments, then counts words.
--
-- Usage:
--   lua scripts/word-count.lua [FILE...]
--   lua scripts/word-count.lua Ausarbeitung/Ausarbeitung.tex Vortrag/Vortrag.tex
--
-- If no files are given, defaults to Ausarbeitung/Ausarbeitung.tex and
-- Vortrag/Vortrag.tex relative to the repository root.

local function read_file(path)
    local f = io.open(path, "r")
    if not f then return nil, "cannot open '" .. path .. "'" end
    local content = f:read("*a")
    f:close()
    return content
end

-- Remove LaTeX content that should not count as words
local function strip_latex(text)
    -- Remove comments (% to end of line, but not \%)
    text = text:gsub("([^\\])%%[^\n]*", "%1")
    text = text:gsub("^%%[^\n]*", "")

    -- Remove common environments whose content is not body text
    for _, env in ipairs({
        "equation", "align", "align%*", "gather", "gather%*",
        "multline", "multline%*", "eqnarray", "eqnarray%*",
        "lstlisting", "verbatim", "tikzpicture", "figure", "table",
        "tabular", "tabularx", "array", "matrix", "pmatrix",
        "bmatrix", "vmatrix",
    }) do
        text = text:gsub("\\begin%{" .. env .. "%}.-\\end%{" .. env .. "%}", " ")
    end

    -- Remove inline math $...$ and display math $$...$$
    text = text:gsub("%$%$[^$]*%$%$", " ")
    text = text:gsub("%$[^$\n]*%$", " ")

    -- Remove LaTeX commands with arguments: \cmd{...} or \cmd[...]{...}
    -- Repeat a few times to handle nested braces
    for _ = 1, 4 do
        text = text:gsub("\\%a+%*?%s*%[[^%]]*%]%s*%b{}", " ")
        text = text:gsub("\\%a+%*?%s*%b{}", " ")
    end

    -- Remove remaining LaTeX commands without arguments
    text = text:gsub("\\%a+%*?", " ")

    -- Remove leftover braces and brackets
    text = text:gsub("[{}%[%]]", " ")

    return text
end

local function count_words(text)
    local stripped = strip_latex(text)
    local n = 0
    -- Count sequences of non-whitespace characters that contain at least one letter
    for token in stripped:gmatch("%S+") do
        if token:match("%a") then
            n = n + 1
        end
    end
    return n
end

local function format_number(n)
    -- Insert thousands separators
    local s = tostring(n)
    local result = s:reverse():gsub("(%d%d%d)", "%1."):reverse()
    -- Remove leading dot if present
    if result:sub(1, 1) == "." then result = result:sub(2) end
    return result
end

-- Determine files to process
local files = {}
if #arg > 0 then
    for _, f in ipairs(arg) do
        table.insert(files, f)
    end
else
    -- Default: count words in both main documents
    table.insert(files, "Ausarbeitung/Ausarbeitung.tex")
    table.insert(files, "Vortrag/Vortrag.tex")
end

local total = 0
local any_error = false

io.write(string.format("%-50s  %10s\n", "File", "Words"))
io.write(string.rep("-", 65) .. "\n")

for _, path in ipairs(files) do
    local content, err = read_file(path)
    if content then
        local n = count_words(content)
        total = total + n
        io.write(string.format("%-50s  %10s\n", path, format_number(n)))
    else
        io.stderr:write("Warning: " .. err .. "\n")
        any_error = true
    end
end

if #files > 1 then
    io.write(string.rep("-", 65) .. "\n")
    io.write(string.format("%-50s  %10s\n", "Total", format_number(total)))
end

os.exit(any_error and 1 or 0)
