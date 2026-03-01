# =============================================================================
# Multi-stage Dockerfile for LaTeX PDF Generation
# Optimized for: Seminar Angewandte Statistik 2025
# =============================================================================

# -----------------------------------------------------------------------------
# Stage 0: Build Lua 5.5.0 from the local source tree
# -----------------------------------------------------------------------------
FROM ubuntu:20.04 AS lua-builder

ARG DEBIAN_FRONTEND=noninteractive

# Install only the tools needed to compile Lua (kept in a throw-away stage)
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        build-essential \
        libreadline-dev \
    && rm -rf /var/lib/apt/lists/*

# Copy the locally-checked-in Lua source and build it
COPY lua-5.5.0/ /lua-src/
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

# Install the Lua binaries compiled from the local source (lua-builder stage)
# Runs as root before switching to the latex user
USER root
COPY --from=lua-builder /opt/lua/bin/lua  /usr/local/bin/lua
COPY --from=lua-builder /opt/lua/bin/luac /usr/local/bin/luac

# Make scripts executable
RUN chmod +x ./scripts/*.sh

# Switch to non-root user
USER latex

# Add health check to verify container is working
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
