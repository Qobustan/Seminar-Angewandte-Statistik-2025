# Dependency Graphs

Complete dependency graphs for all code files in the project, organized by
file type and subsystem. The graphs use **Mermaid** notation, which renders
natively in GitHub Markdown.

**Node shape key**

| Shape | Meaning |
|-------|---------|
| Rectangle `[ ]` | Project source file |
| Rounded rectangle `( )` | External tool / GitHub Action |
| Cylinder `[( )]` | Data file (`.bib`, config) |
| Folder `[/ /]` | Directory |

---

## 1. LaTeX Documents

Dependency trees based on `\input`, `\addbibresource`, and `\includegraphics`.
The `.latexmkrc` files in each document directory are read automatically by
`latexmk` whenever it runs there.

### 1a. Ausarbeitung (Written Report)

```mermaid
flowchart TD
    A_tex["Ausarbeitung/Ausarbeitung.tex"]
    A_header["Ausarbeitung/header.tex"]
    A_common["Ausarbeitung/header-common.tex"]
    A_article["Ausarbeitung/header-article.tex"]
    A_bib[("Ausarbeitung/Ausarbeitung.bib")]
    A_latexmkrc[("Ausarbeitung/.latexmkrc")]
    V_img[/"Vortrag/img/"/]
    latexmk("latexmk")

    A_tex -->|"\input"| A_header
    A_header -->|"\input"| A_common
    A_header -->|"\input"| A_article
    A_tex -->|"\addbibresource"| A_bib
    A_tex -->|"\includegraphics"| V_img
    latexmk -->|"reads config"| A_latexmkrc
    latexmk -->|"compiles"| A_tex
```

### 1b. Vortrag (Presentation)

```mermaid
flowchart TD
    V_tex["Vortrag/Vortrag.tex"]
    V_header["Vortrag/header.tex"]
    V_common["Vortrag/header-common.tex"]
    V_beamer["Vortrag/header-beamer.tex"]
    V_bib[("Vortrag/Vortrag.bib")]
    V_latexmkrc[("Vortrag/.latexmkrc")]
    V_img[/"Vortrag/img/"/]
    latexmk_v("latexmk")

    V_tex -->|"\input"| V_header
    V_header -->|"\input"| V_common
    V_header -->|"\input"| V_beamer
    V_tex -->|"\addbibresource"| V_bib
    V_tex -->|"\includegraphics"| V_img
    latexmk_v -->|"reads config"| V_latexmkrc
    latexmk_v -->|"compiles"| V_tex
```

### 1c. Historical / Archive LaTeX Snapshots

These are frozen snapshots kept for reference (review meetings, secondary
drafts). They are self-contained and are never rebuilt by the CI workflows.

```mermaid
flowchart TD
    subgraph sek ["Ausarbeitung/Sekundärentwurf (als Entwurf eingereicht)/"]
        sek_tex["Ausarbeitung.tex"]
        sek_hdr["header.tex"]
        sek_bib[("Ausarbeitung.bib")]
        sek_tex -->|"\input"| sek_hdr
        sek_tex -->|"\addbibresource"| sek_bib
    end

    subgraph besp_aus ["Besprechung/Material/1. Besprechung/Ausarbeitung/"]
        ba_tex["Ausarbeitung.tex"]
        ba_hdr["header.tex"]
        ba_bib[("Ausarbeitung.bib")]
        ba_tex -->|"\input"| ba_hdr
        ba_tex -->|"\addbibresource"| ba_bib
    end

    subgraph besp_vor ["Besprechung/Material/1. Besprechung/Vortrag/"]
        bv_tex["Vortrag.tex"]
        bv_hdr["header.tex"]
        bv_bib[("Vortrag.bib")]
        bv_tex -->|"\input"| bv_hdr
        bv_tex -->|"\addbibresource"| bv_bib
    end

    subgraph besp_stabil_aus ["Besprechung/Material/1. Besprechung/Stabil/Ausarbeitung/"]
        bsa_tex["Ausarbeitung.tex"]
        bsa_hdr["header.tex"]
        bsa_common["header-common.tex"]
        bsa_article["header-article.tex"]
        bsa_bib[("Ausarbeitung.bib")]
        bsa_sek["Sekundärentwurf/Ausarbeitung.tex"]
        bsa_tex -->|"\input"| bsa_hdr
        bsa_hdr -->|"\input"| bsa_common
        bsa_hdr -->|"\input"| bsa_article
        bsa_tex -->|"\addbibresource"| bsa_bib
    end

    subgraph besp_stabil_vor ["Besprechung/Material/1. Besprechung/Stabil/Vortrag/"]
        bsv_tex["Vortrag.tex"]
        bsv_hdr["header.tex"]
        bsv_common["header-common.tex"]
        bsv_beamer["header-beamer.tex"]
        bsv_bib[("Vortrag.bib")]
        bsv_tex -->|"\input"| bsv_hdr
        bsv_hdr -->|"\input"| bsv_common
        bsv_hdr -->|"\input"| bsv_beamer
        bsv_tex -->|"\addbibresource"| bsv_bib
    end
```

---

## 2. Shell Scripts (Linux / macOS)

Call graph: which script delegates to or invokes which other script/tool.

```mermaid
flowchart LR
    subgraph bin_grp ["bin/"]
        pdf_sh["bin/pdf.sh"]
        lualatex_sh["bin/lualatex.sh"]
        docker_sh["bin/docker.sh"]
    end

    subgraph scripts_grp ["scripts/"]
        generatePdf["scripts/generatePdf.sh"]
        generatePdfLua["scripts/generatePdf-lualatex.sh"]
        abkuerzung["scripts/abkuerzung.sh"]
        del_branches_sh["scripts/delete-obsolete-branches.sh"]
    end

    subgraph task_bash_grp ["task_skripts/bash/"]
        doc_version["task_skripts/bash/doc_version.sh"]
    end

    subgraph legacy_grp ["legacy/"]
        debug_sh["legacy/debug.sh"]
        build_sh["legacy/build.sh"]
        build_seminar["legacy/build-seminar.sh"]
    end

    subgraph cleanup_grp ["cleanup/"]
        remove_junk["cleanup/Remove_Junk_Linux.sh"]
    end

    subgraph latex_docs ["LaTeX Document Roots"]
        aus_dir[/"Ausarbeitung/"/]
        vor_dir[/"Vortrag/"/]
    end

    subgraph ext_tools ["External Tools"]
        pdflatex_biber("pdflatex / biber")
        pdflatex_bibtex("pdflatex / bibtex")
        makeindex_ext("makeindex")
        gh_ext("gh CLI")
        git_ext("git")
        docker_ext("Docker daemon")
    end

    pdf_sh      -->|"exec"| generatePdf
    lualatex_sh -->|"exec"| generatePdfLua
    generatePdfLua -->|"LATEX_ENGINE=lualatex exec"| generatePdf
    generatePdf --> pdflatex_biber
    generatePdf --> aus_dir
    generatePdf --> vor_dir

    docker_sh --> docker_ext
    docker_sh -->|"volume mount"| aus_dir
    docker_sh -->|"volume mount"| vor_dir

    abkuerzung       --> makeindex_ext
    del_branches_sh  --> gh_ext
    doc_version      --> git_ext

    debug_sh -->|"calls"| build_sh
    build_sh      --> pdflatex_bibtex
    build_sh      --> aus_dir
    build_sh      --> vor_dir
    build_seminar --> pdflatex_bibtex
    build_seminar --> aus_dir
    build_seminar --> vor_dir

    remove_junk -->|"cleans aux files in"| aus_dir
    remove_junk -->|"cleans aux files in"| vor_dir
```

---

## 2b. Windows Batch Scripts

Windows counterparts to every `.sh` script above.  
The call chain mirrors section 2 exactly, using `call` instead of `exec`.

```mermaid
flowchart LR
    subgraph bin_bat ["bin/  (Windows)"]
        pdf_bat["bin/pdf.bat"]
        lualatex_bat["bin/lualatex.bat"]
        docker_bat["bin/docker.bat"]
    end

    subgraph scripts_bat ["scripts/  (Windows)"]
        generatePdf_bat["scripts/generatePdf.bat"]
        generatePdfLua_bat["scripts/generatePdf-lualatex.bat"]
        abkuerzung_bat["scripts/abkuerzung.bat\n(placeholder — not yet configured)"]
    end

    subgraph task_bat ["task_skripts/bash/  (Windows)"]
        doc_version_bat["task_skripts/bash/doc_version.bat"]
    end

    subgraph cleanup_bat ["cleanup/  (Windows)"]
        remove_junk_bat["cleanup/Remove_Junk_Windows.bat"]
    end

    subgraph latex_docs_bat ["LaTeX Document Roots"]
        aus_dir_bat[/"Ausarbeitung/"/]
        vor_dir_bat[/"Vortrag/"/]
    end

    subgraph ext_tools_bat ["External Tools"]
        pdflatex_biber_bat("pdflatex / biber")
        git_bat("git")
        docker_bat_ext("Docker daemon")
    end

    pdf_bat      -->|"call"| generatePdf_bat
    lualatex_bat -->|"call"| generatePdfLua_bat
    generatePdfLua_bat -->|"LATEX_ENGINE=lualatex call"| generatePdf_bat
    generatePdf_bat --> pdflatex_biber_bat
    generatePdf_bat --> aus_dir_bat
    generatePdf_bat --> vor_dir_bat

    docker_bat --> docker_bat_ext
    docker_bat -->|"volume mount"| aus_dir_bat
    docker_bat -->|"volume mount"| vor_dir_bat

    doc_version_bat --> git_bat

    remove_junk_bat -->|"cleans aux files in"| aus_dir_bat
    remove_junk_bat -->|"cleans aux files in"| vor_dir_bat
```

---

## 3. Lua Scripts

File inputs each Lua script reads at runtime.

```mermaid
flowchart LR
    check_bib["scripts/check-bib.lua"]
    word_count["scripts/word-count.lua"]

    aus_bib[("Ausarbeitung/Ausarbeitung.bib")]
    aus_tex["Ausarbeitung/Ausarbeitung.tex"]
    vor_tex["Vortrag/Vortrag.tex"]
    lua_stdlib("Lua stdlib: io, os, math, table")

    check_bib -->|"reads"| aus_bib
    check_bib --> lua_stdlib

    word_count -->|"reads"| aus_tex
    word_count -->|"reads"| vor_tex
    word_count --> lua_stdlib
```

---

## 4. Python Scripts

Module import dependencies for the Python scripts.

```mermaid
flowchart LR
    del_py["scripts/delete-obsolete-branches.py"]

    subgraph stdlib ["Python Standard Library"]
        os_mod("os")
        sys_mod("sys")
        time_mod("time")
        typing_mod("typing")
    end

    subgraph third_party ["Third-Party Library"]
        pygithub("PyGithub\n(pip install PyGithub)")
    end

    github_api("GitHub REST API")

    del_py --> os_mod
    del_py --> sys_mod
    del_py --> time_mod
    del_py --> typing_mod
    del_py --> pygithub
    pygithub -->|"HTTPS"| github_api
```

---

## 5. Perl Scripts

Each script in `task_skripts/perl/` is a thin wrapper that invokes an
external TeX-distribution tool. Shared Perl module imports are shown once
in the shared node.

```mermaid
flowchart LR
    subgraph perl_scripts ["task_skripts/perl/"]
        bibtex2html_pl["bibtex2html.pl"]
        detex_pl["detex.pl"]
        lacheck_pl["lacheck.pl"]
        latex2html_pl["latex2html.pl"]
        latexpand_pl["latexpand.pl"]
        latexxmkrc_pl["latexxmkrc.pl\n(latexmk config)"]
        makeglossaries_pl["makeglossaries.pl"]
        texcount_pl["texcount.pl"]
    end

    subgraph perl_stdlib ["Perl Standard Library"]
        file_basename("File::Basename")
        strict_warn("strict, warnings")
    end

    subgraph ext_tex_tools ["External Tools (TeX distribution)"]
        bibtex2html_ext("bibtex2html")
        detex_ext("detex")
        lacheck_ext("lacheck")
        latex2html_ext("latex2html")
        latexpand_ext("latexpand")
        latexmk_ext("latexmk")
        makeglossaries_ext("makeglossaries")
        texcount_ext("texcount")
    end

    bibtex2html_pl  --> file_basename & strict_warn
    bibtex2html_pl  -->|"invokes"| bibtex2html_ext

    detex_pl        --> file_basename & strict_warn
    detex_pl        -->|"invokes"| detex_ext

    lacheck_pl      --> file_basename & strict_warn
    lacheck_pl      -->|"invokes"| lacheck_ext

    latex2html_pl   --> file_basename & strict_warn
    latex2html_pl   -->|"invokes"| latex2html_ext

    latexpand_pl    --> file_basename & strict_warn
    latexpand_pl    -->|"invokes"| latexpand_ext

    latexxmkrc_pl   -->|"configures"| latexmk_ext

    makeglossaries_pl --> file_basename & strict_warn
    makeglossaries_pl -->|"invokes"| makeglossaries_ext

    texcount_pl     --> file_basename & strict_warn
    texcount_pl     -->|"invokes"| texcount_ext
```

---

## 6. GitHub Actions Workflows

Dependencies between each workflow and the repository files, scripts, and
external actions it uses. Workflows are split into groups for clarity.

### 6a. Build & Compilation Workflows

```mermaid
flowchart LR
    subgraph wf_build ["Workflows"]
        build_wf[".github/workflows/\nbuild-and-publish-pdfs.yml"]
        ci_wf[".github/workflows/\nci-smoke-tests.yml"]
        docker_wf[".github/workflows/\ndocker-image.yml"]
        format_wf[".github/workflows/\nformat.yml"]
    end

    subgraph repo_files_build ["Repository Files"]
        aus_tex_b["Ausarbeitung/Ausarbeitung.tex"]
        vor_tex_b["Vortrag/Vortrag.tex"]
        lua_src_b[/"lua-5.5.0/"/]
        dockerfile_b["Dockerfile"]
        tex_all_b["**/*.tex"]
    end

    subgraph actions_build ["GitHub Actions"]
        checkout_b("actions/checkout@v6")
        latex_action_b("xu-cheng/latex-action@v4")
        upload_b("actions/upload-artifact@v7")
    end

    build_wf --> checkout_b
    build_wf --> lua_src_b
    build_wf --> latex_action_b
    build_wf --> aus_tex_b
    build_wf --> vor_tex_b
    build_wf --> upload_b

    ci_wf --> checkout_b
    ci_wf --> latex_action_b
    ci_wf --> aus_tex_b
    ci_wf --> vor_tex_b

    docker_wf --> checkout_b
    docker_wf --> dockerfile_b

    format_wf --> checkout_b
    format_wf -->|"latexindent -w"| tex_all_b
```

### 6b. Code Quality Workflows

```mermaid
flowchart LR
    subgraph wf_quality ["Workflows"]
        bibcheck_wf[".github/workflows/\nbibcheck.yml"]
        codeql_wf[".github/workflows/\ncodeql-analysis.yml"]
        lint_wf[".github/workflows/\nlint.yml"]
        spellcheck_wf[".github/workflows/\nspellcheck.yml"]
        setup_perl_wf[".github/workflows/\nsetup_perl.yml"]
    end

    subgraph repo_files_quality ["Repository Files"]
        check_bib_lua_q["scripts/check-bib.lua"]
        aus_bib_q[("Ausarbeitung/Ausarbeitung.bib")]
        lua_src_q[/"lua-5.5.0/"/]
        tex_all_q["**/*.tex"]
        cspell_q[("cspell.json")]
        del_py_q["scripts/delete-obsolete-branches.py"]
        perl_scripts_q[/"task_skripts/perl/"/]
    end

    subgraph actions_quality ["GitHub Actions / External Tools"]
        checkout_q("actions/checkout@v6")
        setup_node_q("actions/setup-node@v6")
        upload_q("actions/upload-artifact@v7")
        codeql_init_q("github/codeql-action/init@v4")
        codeql_auto_q("github/codeql-action/autobuild@v4")
        codeql_ana_q("github/codeql-action/analyze@v4")
        sticky_q("marocchino/sticky-pull-request-comment@v3")
        chktex_q("chktex")
        cspell_q_ext("cspell (npm)")
    end

    bibcheck_wf --> checkout_q
    bibcheck_wf --> lua_src_q
    bibcheck_wf --> check_bib_lua_q
    bibcheck_wf --> aus_bib_q

    codeql_wf --> checkout_q
    codeql_wf --> del_py_q
    codeql_wf --> codeql_init_q
    codeql_wf --> codeql_auto_q
    codeql_wf --> codeql_ana_q
    codeql_wf --> upload_q

    lint_wf --> checkout_q
    lint_wf --> chktex_q
    lint_wf --> tex_all_q

    spellcheck_wf --> checkout_q
    spellcheck_wf --> setup_node_q
    spellcheck_wf --> cspell_q_ext
    spellcheck_wf --> cspell_q
    spellcheck_wf --> upload_q
    spellcheck_wf --> sticky_q

    setup_perl_wf --> checkout_q
    setup_perl_wf --> perl_scripts_q
```

### 6c. Repository Management Workflows

Includes `.github/dependabot.yml`, which is not a workflow itself but
monitors the `workflows/` directory for dependency updates.

```mermaid
flowchart LR
    subgraph wf_mgmt ["Workflows"]
        greetings_wf[".github/workflows/\ngreetings.yml"]
        label_wf[".github/workflows/\nlabel.yml"]
        publish_wiki_wf[".github/workflows/\npublish-wiki.yml"]
        stale_wf[".github/workflows/\nstale.yml"]
        summary_wf[".github/workflows/\nsummary.yml"]
        sync_labels_wf[".github/workflows/\nsync-labels.yml"]
    end

    subgraph repo_files_mgmt ["Repository Files"]
        labeler_yml_m[(".github/labeler.yml")]
        labels_yml_m[(".github/labels.yml")]
        wiki_dir_m[/"wiki/"/]
        dependabot_m[(".github/dependabot.yml")]
        workflows_dir_m[/".github/workflows/"/]
    end

    subgraph actions_mgmt ["GitHub Actions"]
        checkout_m("actions/checkout@v6")
        first_interaction_m("actions/first-interaction@v3")
        labeler_m("actions/labeler@v6")
        stale_m("actions/stale@v10")
        ai_inference_m("actions/ai-inference@v2")
        label_sync_m("EndBug/label-sync@v2")
        dependabot_svc("GitHub Dependabot service")
    end

    greetings_wf    --> first_interaction_m

    label_wf        --> checkout_m
    label_wf        --> labeler_m
    label_wf        --> labeler_yml_m

    publish_wiki_wf --> checkout_m
    publish_wiki_wf -->|"syncs"| wiki_dir_m

    stale_wf        --> stale_m

    summary_wf      --> checkout_m
    summary_wf      --> ai_inference_m

    sync_labels_wf  --> checkout_m
    sync_labels_wf  --> label_sync_m
    sync_labels_wf  --> labels_yml_m

    dependabot_m    -->|"monitors for updates"| workflows_dir_m
    dependabot_svc  -->|"reads"| dependabot_m
```

### 6d. Legacy / Archived Workflow

`legacy/github_workflow/docker-image.yml` is an archived predecessor of
`.github/workflows/docker-image.yml`. It is kept for historical reference
and is **not** executed by GitHub Actions.

```mermaid
flowchart LR
    legacy_docker["legacy/github_workflow/\ndocker-image.yml\n(archived — not executed)"]
    current_docker[".github/workflows/\ndocker-image.yml\n(active)"]
    dockerfile_d["Dockerfile"]
    buildx("docker/setup-buildx-action@v2\n(legacy only)")
    cache("actions/cache@v3\n(legacy only)")
    dockerhub("Docker Hub push\n(legacy only)")

    legacy_docker -.->|"superseded by"| current_docker
    legacy_docker --> dockerfile_d
    legacy_docker --> buildx
    legacy_docker --> cache
    legacy_docker --> dockerhub
    current_docker --> dockerfile_d
```
