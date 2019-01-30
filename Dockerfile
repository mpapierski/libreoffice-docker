FROM openjdk:11-jre
MAINTAINER Michał Papierski <michal@papierski.net>

ENV LIBREOFFICE_VERSION="6.1.4"
RUN apt-get update && \
    apt-get install -y \
        wget \
        libxinerama1 \
        libdbus-glib-1-2 \
        libcairo2 \
        libcups2 \
        libsm6
RUN wget http://download.documentfoundation.org/libreoffice/stable/${LIBREOFFICE_VERSION}/deb/x86_64/LibreOffice_${LIBREOFFICE_VERSION}_Linux_x86-64_deb.tar.gz
RUN tar -vxf LibreOffice_${LIBREOFFICE_VERSION}_Linux_x86-64_deb.tar.gz && \
    rm LibreOffice_${LIBREOFFICE_VERSION}_Linux_x86-64_deb.tar.gz && \
    cd LibreOffice_6.1.4.2_Linux_x86-64_deb/DEBS/ && \
    dpkg -i *.deb && \
    cd .. && \
    rm -rf LibreOffice_${LIBREOFFICE_VERSION}_Linux_x86-64_deb/

