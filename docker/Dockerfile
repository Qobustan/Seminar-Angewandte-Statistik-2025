# Use Ubuntu 20.04
FROM ubuntu:20.04

# Set non-interactive mode
ENV DEBIAN_FRONTEND=noninteractive

# Set the timezone
RUN ln -fs /usr/share/zoneinfo/Europe/Berlin /etc/localtime

# Update apt repositories and install the necessary packages
RUN apt-get update && apt-get upgrade -y && apt-get install -y \
        texlive \
        texlive-base \
        texlive-lang-german \
        texlive-latex-extra \
        texlive-bibtex-extra \
        biber \
        lmodern \
        git \
        curl \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Clone the repository
RUN git clone https://github.com/Qobustan/Seminar-Angewandte-Statistik-2025.git /app || echo "Repository not accessible"

# Set the working directory
WORKDIR /app

# Make scripts executable
RUN chmod +x /app/scripts/*.sh 2>/dev/null || true

# Set the entry point
ENTRYPOINT ["/bin/bash", "/app/scripts/generatePdf.sh"]
