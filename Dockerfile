# Use Ubuntu 20.04 (or Ubuntu 22.04)
FROM ubuntu:20.04

# Set non-interactive mode to avoid prompts during apt-get install
RUN export DEBIAN_FRONTEND=noninteractive

# Set the timezone
RUN ln -fs /usr/share/zoneinfo/Europe/Berlin /etc/localtime

# Update apt repositories and install the necessary packages
RUN apt-get update && apt-get upgrade -y && apt-get install -y \
        texlive \
        texlive-base \
        texlive-lang-german \
        texlive-latex-extra \
        lmodern \
        git

# Clone the repository into /app
RUN git clone https://github.com/Qobustan/Seminar-Angewandte-Statistik-2025.git /app

# Set the working directory to /app/scripts
WORKDIR /app/scripts

# Expose the src directory as a volume
VOLUME /app/src

# Set the entry point to the script that generates the PDF
ENTRYPOINT ["/app/scripts/generatePdf.sh"]
