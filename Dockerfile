# =============================================================================
# Multi-stage Dockerfile for LaTeX PDF Generation
# Optimized for: Seminar Angewandte Statistik 2025
#
# Build stages overview
# ---------------------
#  Stage 0 – lua-builder : Compiles Lua 5.5.0 from the repository's own
#                           lua-5.5.0/ source tree.  This is a throw-away
#                           stage: its build tools (gcc, make, …) are NOT
#                           carried over into the final image, keeping the
#                           image lean.  The only artefacts that leave this
#                           stage are the compiled lua and luac binaries,
#                           copied via COPY --from=lua-builder in Stage 2.
#
#  Stage 1 – base         : Ubuntu 20.04 with texlive-full.  Contains every
#                           LaTeX engine (pdflatex, lualatex, xelatex) and
#                           every CTAN package so that LaTeX compilation
#                           never fails due to a missing package.
#
#  Stage 2 – app          : Inherits Stage 1, adds the LaTeX source files,
#                           the Lua binaries from Stage 0, and locks down the
#                           runtime to a non-root "latex" user.
#
# Design rationale
# ----------------
# * No external Lua download at build time – the lua-5.5.0/ source tree is
#   already part of the repository, so the image is reproducible without any
#   internet access beyond the apt mirror used for texlive-full.
# * LuaLaTeX ships its own embedded Lua interpreter (luatex); the lua/luac
#   binaries installed here provide a standalone Lua runtime for shell scripts
#   and future scripting needs inside the container.
# * The multi-stage approach means the C toolchain (build-essential,
#   libreadline-dev) is absent from the final image, reducing the attack
#   surface and image size.
# =============================================================================

# -----------------------------------------------------------------------------
# Stage 0: Build Lua 5.5.0 from the local source tree
#
# Why only build-essential + libreadline-dev?
#   - build-essential provides gcc/make, the only tools needed by Lua's
#     plain Makefile-based build system.
#   - libreadline-dev enables line-editing support in the interactive Lua
#     REPL; omitting it still produces a working lua binary.
#   - All other Ubuntu packages are intentionally excluded to keep the
#     layer cache small and the build deterministic.
#
# Why INSTALL_TOP=/opt/lua?
#   - Installing to a dedicated prefix (/opt/lua) isolates the Lua artefacts
#     from the Ubuntu system paths so that the COPY --from instructions in
#     Stage 2 reference exact, predictable paths.
# -----------------------------------------------------------------------------
FROM ubuntu:20.04 AS lua-builder

ARG DEBIAN_FRONTEND=noninteractive

# Install only the minimal toolchain needed to compile Lua.
# build-essential: gcc, make (and the C standard library headers)
# libreadline-dev: optional but enables readline support in lua REPL
# Everything is cleaned up in the same layer to keep the layer small.
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        build-essential \
        libreadline-dev \
    && rm -rf /var/lib/apt/lists/*

# Copy the locally-checked-in Lua 5.5.0 source tree.
# Using the repository's own copy avoids any external download and pins
# the exact version used across all builds.
COPY lua-5.5.0/ /lua-src/

# Compile for Linux and install to /opt/lua.
# 'make linux' selects the Linux-specific build flags from Lua's Makefile.
# INSTALL_TOP=/opt/lua keeps the installation isolated from system paths.
RUN cd /lua-src && \
    make linux && \
    make install INSTALL_TOP=/opt/lua

# -----------------------------------------------------------------------------
# Stage 1: Base image with TeX Live installation
# -----------------------------------------------------------------------------
FROM ubuntu:20.04 AS base

# Metadata following OCI image spec
LABEL org.opencontainers.image.title="LaTeX Seminar PDF Generator"
LABEL org.opencontainers.image.description="Containerized LaTeX environment for generating seminar PDFs"
LABEL org.opencontainers.image.authors="Yavuzâlp Dal"
LABEL org.opencontainers.image.source="https://github.com/Qobustan/Seminar-Angewandte-Statistik-2025"
LABEL org.opencontainers.image.licenses="MIT"
LABEL org.opencontainers.image.version="2.0"

# Build arguments for flexibility
ARG DEBIAN_FRONTEND=noninteractive
ARG TZ=Europe/Berlin
ARG USER_ID=1000
ARG GROUP_ID=1000

# Set environment variables
ENV DEBIAN_FRONTEND=${DEBIAN_FRONTEND} \
    TZ=${TZ} \
    LANG=C.UTF-8 \
    LC_ALL=C.UTF-8

# Configure timezone (done before package installation)
RUN ln -snf /usr/share/zoneinfo/${TZ} /etc/localtime && \
    echo ${TZ} > /etc/timezone

# Install TeX Live and required packages in a single layer
# Optimized order: security updates first, then packages, cleanup last
# Using texlive-full for completeness - ensures all LaTeX packages are available.
# This includes pdflatex, lualatex, xelatex, and all other LaTeX engines.
# Note: This increases image size (~4GB) but prevents missing package errors.
# The original Dockerfile had issues with missing packages (stmaryrd, tipa, pict2e, inconsolata).
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y --no-install-recommends \
        # Complete TeX Live installation - ensures all packages and engines are available
        texlive-full \
        # Utilities for scripts
        bash \
        coreutils \
        findutils \
        # Clean up in same layer to reduce image size
    && apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# -----------------------------------------------------------------------------
# Stage 2: Application setup
#
# Inherits texlive-full from Stage 1 (base) and adds:
#   1. The compiled Lua 5.5.0 binaries from Stage 0 (lua-builder).
#   2. The LaTeX source files for Ausarbeitung and Vortrag.
#   3. The PDF-generation shell scripts.
#
# Security model
# --------------
# A dedicated non-root user ("latex") is created.  All write-sensitive
# operations (Lua binary copy, chmod) are performed as root before the
# final USER latex switch so that the running container has no write
# access to system directories.
# -----------------------------------------------------------------------------
FROM base AS app

# Re-declare build arguments for use in this stage
ARG USER_ID=1000
ARG GROUP_ID=1000

# Create non-root user for security
RUN groupadd -g ${GROUP_ID} latex && \
    useradd -m -u ${USER_ID} -g latex -s /bin/bash latex && \
    mkdir -p /app && \
    chown -R latex:latex /app

# Set working directory
WORKDIR /app

# Copy only necessary files for PDF generation (leverages .dockerignore)
# This layer will be cached unless these files change
COPY --chown=latex:latex Ausarbeitung/ ./Ausarbeitung/
COPY --chown=latex:latex Vortrag/ ./Vortrag/
COPY --chown=latex:latex scripts/*.sh ./scripts/

# Install the Lua binaries built in Stage 0 (lua-builder).
#
# Why COPY --from=lua-builder instead of apt-get install lua?
#   - The repository already contains the Lua 5.5.0 source tree (lua-5.5.0/).
#     Compiling from that source guarantees the exact same version is used
#     everywhere and avoids any external download at image build time.
#   - The OS package (lua5.x from Ubuntu apt) would be a different version
#     and would introduce an additional external dependency.
#
# Why USER root here?
#   - COPY --from cannot target /usr/local/bin as a non-root user because
#     that path is owned by root.  We switch back to USER latex immediately
#     after the copy + chmod to maintain least-privilege for the runtime.
USER root
COPY --from=lua-builder /opt/lua/bin/lua  /usr/local/bin/lua
COPY --from=lua-builder /opt/lua/bin/luac /usr/local/bin/luac

# Make scripts executable
RUN chmod +x ./scripts/*.sh

# Switch to non-root user
USER latex

# Add health check to verify container is working.
# The check confirms:
#   - The generation script exists
#   - pdflatex (texlive-full) is on PATH
#   - lualatex (texlive-full) is on PATH
#   - lua (compiled from local source, Stage 0) is on PATH
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
    CMD [ -f "/app/scripts/generatePdf.sh" ] && command -v pdflatex > /dev/null && command -v lualatex > /dev/null && command -v lua > /dev/null && echo "OK" || exit 1

# Set the entrypoint and default command
# ENTRYPOINT provides the base command, CMD provides default arguments
ENTRYPOINT ["/bin/bash", "/app/scripts/generatePdf.sh"]
CMD []

# Expose metadata about expected volumes
VOLUME ["/app/Ausarbeitung", "/app/Vortrag"]

# =============================================================================
# Usage Examples:
# 
# Build:
#   docker build -t latex-seminar:latest .
#   docker build --build-arg USER_ID=$(id -u) --build-arg GROUP_ID=$(id -g) -t latex-seminar:latest .
#
# Run (using current directory with default pdflatex):
#   docker run --rm -v $(pwd):/app latex-seminar:latest
#
# Run with LuaLaTeX:
#   docker run --rm -e LATEX_ENGINE=lualatex -v $(pwd):/app latex-seminar:latest
#
# Run with custom user ID (avoids permission issues):
#   docker run --rm --user $(id -u):$(id -g) -v $(pwd):/app latex-seminar:latest
#
# Interactive shell for debugging:
#   docker run --rm -it -v $(pwd):/app --entrypoint /bin/bash latex-seminar:latest
#
# =============================================================================
