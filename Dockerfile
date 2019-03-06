FROM openjdk:11-jre
MAINTAINER Michał Papierski <michal@papierski.net>

ENV LIBREOFFICE_VERSION="6.2.1.2"

RUN apt-get update && \
    apt-get install -y \
        wget \
        locales \
        libxinerama1 \
        libdbus-glib-1-2 \
        libcairo2 \
        libcups2 \
        libsm6 \
        fonts-opensymbol \
        hyphen-en-us \
        hyphen-pl \
        fonts-dejavu \
        fonts-dejavu-core \
        fonts-dejavu-extra \
        fonts-droid-fallback \
        fonts-dustin \
        fonts-f500 \
        fonts-fanwood \
        fonts-freefont-ttf \
        fonts-liberation \
        fonts-lmodern \
        fonts-lyx \
        fonts-sil-gentium \
        fonts-texgyre \
        fonts-tlwg-purisa && \
    apt autoremove -y && \
    rm -rf /var/lib/apt/lists/*

RUN ver="$(echo -n $LIBREOFFICE_VERSION | cut -d'.' -f1-3)" && \
# Download libre itself
    wget http://download.documentfoundation.org/libreoffice/stable/${ver}/deb/x86_64/LibreOffice_${ver}_Linux_x86-64_deb.tar.gz && \
    tar -vxf LibreOffice_${ver}_Linux_x86-64_deb.tar.gz && \
    rm LibreOffice_${ver}_Linux_x86-64_deb.tar.gz && \
    cd LibreOffice_${LIBREOFFICE_VERSION}_Linux_x86-64_deb/DEBS/ && \
    dpkg -i *.deb && \
    cd ../../ && \
    rm -rf LibreOffice_${LIBREOFFICE_VERSION}_Linux_x86-64_deb/ && \
# Download language packs
    wget http://download.documentfoundation.org/libreoffice/stable/${ver}/deb/x86_64/LibreOffice_${ver}_Linux_x86-64_deb_langpack_pl.tar.gz && \
    tar -vxf LibreOffice_${ver}_Linux_x86-64_deb_langpack_pl.tar.gz && \
    rm LibreOffice_${ver}_Linux_x86-64_deb_langpack_pl.tar.gz && \
    cd LibreOffice_${LIBREOFFICE_VERSION}_Linux_x86-64_deb_langpack_pl/DEBS && \
    dpkg -i *.deb && \
    cd ../../ && \
    rm -rf LibreOffice_${LIBREOFFICE_VERSION}_Linux_x86-64_deb_langpack_pl && \
# Install proper locale
    sed -i 's/# pl_PL.UTF-8 UTF-8/pl_PL.UTF-8 UTF-8/' /etc/locale.gen && \
    dpkg-reconfigure --frontend=noninteractive locales && \
    update-locale LANG=pl_PL.UTF-8 && \
# Just for convenience so the entrypoint would be simplier
    ln -s /opt/libreoffice$(echo -n $LIBREOFFICE_VERSION | cut -d'.' -f1-2) /opt/libreoffice

ENV LANG="pl_PL.UTF-8"
ENV LC_ALL="pl_PL.UTF-8"
ENV LANGUAGE="pl_PL.UTF-8"

ADD entrypoint.sh /

RUN adduser --disabled-password --gecos "" --shell=/bin/bash libreoffice
USER libreoffice

ENTRYPOINT ["/entrypoint.sh"]
