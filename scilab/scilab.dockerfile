FROM debian:bullseye

ARG VERSION
ENV SCILAB_VERSION=${VERSION:-2023.0.0}

SHELL ["/bin/bash", "-c"]

RUN apt update

RUN apt install -y build-essential gfortran libx11-dev libxft-dev libxtst-dev tar curl unzip wget mesa-utils \
    libxml2-dev libpcre3-dev libcurl4-openssl-dev libblas-dev libblas3 libatlas-base-dev libatlas3-base \
    liblapack-dev liblapack3 libarpack2 libarpack2-dev openjdk-11-jdk libflexdock-java libjogl2-java \
    libjrosetta-java libcommons-logging-java javahelp2 libjlatexmath-java \
    libjgraphx-java fop libjeuclid-core-java libbatik-java libxmlgraphics-commons-java \
    tcl-dev tk-dev ocaml-nox javahelp2 libsaxon-java docbook docbook-xsl docbook-utils docbook-xml docbook-dsssl \
    gettext pvm-dev libxml2-utils fftw3 fftw3-dev libmatio-dev libsuitesparse-dev

ADD https://www.scilab.org/download/$SCILAB_VERSION/scilab-$SCILAB_VERSION.bin.x86_64-linux-gnu.tar.xz /opt/
RUN cd /opt/ && tar -xf scilab-$SCILAB_VERSION.bin.x86_64-linux-gnu.tar.xz

# House cleaning
RUN apt-get -y autoremove \
	&& apt-get clean autoclean \
	&& rm -rf /var/lib/apt/lists/{apt,dpkg,cache,log} /tmp/* /var/tmp/* /opt/scilab-$SCILAB_VERSION.bin.x86_64-linux-gnu.tar.xz

RUN mkdir /opt/scilab

STOPSIGNAL SIGQUIT

ENTRYPOINT /opt/scilab-$SCILAB_VERSION/bin/scilab
CMD ["/opt/scilab/"]
