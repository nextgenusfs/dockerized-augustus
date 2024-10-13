FROM bitnami/minideb:bullseye

# install dependencies
RUN install_packages build-essential wget git autoconf libboost-iostreams-dev \
    libgsl-dev libboost-all-dev libsuitesparse-dev liblpsolve55-dev \
    libsqlite3-dev libmysql++-dev samtools libhts-dev \
    zlib1g-dev libbamtools-dev samtools libhts-dev cdbfasta diamond-aligner libfile-which-perl \
    libparallel-forkmanager-perl libyaml-perl libdbd-mysql-perl python3-biopython

WORKDIR /opt

# fetch augustus
RUN mkdir -p /opt && wget -O /opt/augustus-v3.5.0.tar.gz --no-check-certificate https://github.com/Gaius-Augustus/Augustus/archive/refs/tags/v3.5.0.tar.gz && \
    tar -xzvf augustus-v3.5.0.tar.gz && rm augustus-v3.5.0.tar.gz

# build augustus
WORKDIR /opt/Augustus-3.5.0
RUN make clean && make && make install

ENV PATH="/opt/Augustus-3.5.0/bin:/opt/Augustus-3.5.0/scripts:${PATH}"

# test augustus
RUN make unit_test

SHELL ["/bin/bash", "-c"]

CMD augustus
