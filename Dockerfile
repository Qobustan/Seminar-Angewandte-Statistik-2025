# Use Ubuntu 20.04 (or Ubuntu 22.04)
FROM ubuntu:20.04

# Set non-interactive mode to avoid prompts during apt-get install
ENV DEBIAN_FRONTEND=noninteractive

# Set the timezone
RUN ln -fs /usr/share/zoneinfo/Europe/Berlin /etc/localtime

# Update apt repositories and install the necessary packages
RUN apt-get update && apt-get upgrade -y && apt-get install -y \
        texlive \
        texlive-base \
        texlive-lang-german \
        texlive-latex-extra \
        lmodern \
        git \
        curl

# Check if the repository is accessible using 'git ls-remote'
RUN echo "Checking if the repository is accessible..." && \
    git ls-remote https://github.com/Qobustan/Seminar-Angewandte-Statistik-2025.git || echo "Repository not accessible. Will attempt clone when it becomes public."

# Conditionally clone the repository (only if accessible)
RUN if git ls-remote https://github.com/Qobustan/Seminar-Angewandte-Statistik-2025.git; then \
    git clone https://github.com/Qobustan/Seminar-Angewandte-Statistik-2025.git /app; \
    else \
    echo "Repository is still private, skipping clone."; \
    fi

# Set the working directory to /app/scripts
WORKDIR /app/scripts

# Expose the src directory as a volume
VOLUME /app/src

# Set the entry point to the script that generates the PDF
ENTRYPOINT ["/bin/bash", "/app/scripts/generatePdf.sh"]
