FROM ubuntu:16.04
LABEL maintainer="peterliuall <peterliuforever@gmail.com>"

ENV DEBIAN_FRONTEND noninteractive

ENV TZ Asia/Shanghai

# RUN echo 'nameserver 114.114.114.114' > /etc/resolv.conf

# RUN sed -i s@/archive.ubuntu.com/@/mirrors.aliyun.com/@g /etc/apt/sources.list
# 添加源
# COPY ./sources.list /etc/apt/

WORKDIR /work
COPY gdb-10.2.tar.gz .
COPY Python-3.9.12.tgz .

RUN dpkg --add-architecture i386 && \
    apt-get -y update && \
    apt install -y wget \
    openssl \
    locales \
    texinfo \
    gcc \
    git \
    expat \
    python3-dev \
    libc6:i386 \
    libc6-dbg:i386 \
    libc6-dbg \
    libmpfr-dev libmpfr-doc libmpfr4 libmpfr4-dbg \
    lib32stdc++6 \
    g++-multilib \
    cmake \
    vim \
    wget \
    net-tools \
    iputils-ping \
    libffi-dev \
    libssl-dev \
    zlib1g-dev  \
    libssl-dev libncurses5-dev libsqlite3-dev libreadline-dev libtk8.5 libgdm-dev libdb4o-cil-dev libpcap-dev \
    libbz2-dev \
    build-essential \
    ruby \
    ruby-dev \
    tmux \
    strace \
    ltrace \
    sudo \
    nasm --fix-missing

RUN tar -zxvf Python-3.9.12.tgz && \
    cd Python-3.9.12/ && \
    ./configure --prefix=/usr/local/python3 --enable-optimizations && \
    make && make install && \
    ln -snf /usr/local/python3/bin/python3.9 /usr/bin/python && \
    ln -snf /usr/local/python3/bin/python3.9 /usr/bin/python3 && \
    ln -snf /usr/local/python3/bin/pip3.9 /usr/bin/pip && \
    ln -snf /usr/local/python3/bin/pip3.9 /usr/bin/pip3 && \
    ln -snf /usr/local/python3/bin/python3.9 /usr/local/bin/py && \
    echo "export PATH=$PATH:/usr/local/python3/bin" >> /etc/bash.bashrc

RUN ls /usr/bin/ && \
    python3 -V && \
    locale-gen en_US.UTF-8  && \
    echo 'LANG="en_US.UTF-8"\nLANGUAGE="en_US.UTF-8:"' >  /etc/default/locale && \
    echo 'export LANG="en_US.UTF-8"\nexport LANGUAGE="en_US.UTF-8:"' >>  /etc/bash.bashrc && \
    /bin/bash -c "source /etc/bash.bashrc"

RUN cd /work && \
    tar -zxvf gdb-10.2.tar.gz && \
    cd gdb-10.2/ && \
    mkdir build && \
    cd build && \
    ../configure --with-python=`which python3` --enable-targets=all && \
    make && make install && \
    cd /work

RUN apt install -y \
    ipython3 \
    gdb-multiarch \
    netcat \
    socat \
    man \
    g++ clang clang-format global cppcheck \
    net-tools \
    ssh \
    patchelf \
    gawk \
    file \
    bison \
    rpm2cpio cpio \
    zstd \
    binutils \
    qemu \
    curl \
    sudo \
    build-essential qemu gdbserver gdb-multiarch \
    tzdata --fix-missing && \
    rm -rf /var/lib/apt/list/*

RUN wget https://bootstrap.pypa.io/get-pip.py && \
    python3 get-pip.py

RUN ln -fs /usr/share/zoneinfo/$TZ /etc/localtime && \
    dpkg-reconfigure -f noninteractive tzdata

RUN version="5.7.8" && \
    wget https://github.com/radareorg/radare2/releases/download/${version}/radare2_${version}_amd64.deb && \
    dpkg -i radare2_${version}_amd64.deb && rm radare2_${version}_amd64.deb

RUN python3 -V && pip -V && \
    python3 -m pip install -U pip &&\
    python3 -m pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple && \
    python3 -m pip install --no-cache-dir \
    ropgadget \
    z3-solver \
    smmap2 \
    apscheduler \
    ropper \
    unicorn \
    keystone-engine \
    capstone \
    angr \
    pebble \
    r2pipe \
    LibcSearcher \
    lizard

RUN git clone https://github.com/IZAY01/py_main_arena_offset && \
    cd py_main_arena_offset && \
    python3 setup.py develop

RUN apt install -y gnupg gnupg2 && \
    gpg2 --keyserver keyserver.ubuntu.com --recv-keys \
     409B6B1796C275462A1703113804BB82D39DC0E3 \
     7D2BAF1CF37B13E2069D6956105BD0E739499BDB && \
    curl -sSL https://get.rvm.io -o rvm.sh && \
    cat rvm.sh | bash -s stable && \
    /bin/bash -c "source /usr/local/rvm/scripts/rvm && \
    rvm requirements && \
    apt remove -y ruby && \
    rvm install ruby && \
    rvm use 3.0 --default && \
    gem source -a https://gems.ruby-china.com"

RUN /bin/bash -c 'apt-get install rubygems -y && \
    source /usr/local/rvm/scripts/rvm && rvm use 3.0 --default && \
    gem install one_gadget seccomp-tools && \
    echo "source /usr/local/rvm/scripts/rvm" >> /etc/bash.bashrc'

WORKDIR /work
COPY pwndbg/ ./pwndbg
RUN cd pwndbg && chmod +x setup.sh && ./setup.sh

RUN git clone --depth 1 https://github.com/scwuaptx/Pwngdb.git ~/Pwngdb && \
    cd ~/Pwngdb && mv .gdbinit .gdbinit-pwngdb && \
    sed -i "s?source ~/peda/peda.py?# source ~/peda/peda.py?g" .gdbinit-pwngdb && \
    echo "source ~/Pwngdb/.gdbinit-pwngdb" >> ~/.gdbinit

RUN wget -O ~/.gdbinit-gef.py -q http://gef.blah.cat/py

# RUN git clone --depth 1 https://github.com/niklasb/libc-database.git libc-database && \
#     cd libc-database && ./get ubuntu debian || echo "/libc-database/" > ~/.libcdb_path && \
#     rm -rf /tmp/*

RUN git clone https://github.com/matrix1001/glibc-all-in-one.git ~/glibc-all-in-one

WORKDIR /security

# COPY --from=skysider/glibc_builder64:2.19 /glibc/2.19/64 /glibc/2.19/64
# COPY --from=skysider/glibc_builder32:2.19 /glibc/2.19/32 /glibc/2.19/32

# COPY --from=skysider/glibc_builder64:2.23 /glibc/2.23/64 /glibc/2.23/64
# COPY --from=skysider/glibc_builder32:2.23 /glibc/2.23/32 /glibc/2.23/32

# COPY --from=skysider/glibc_builder64:2.24 /glibc/2.24/64 /glibc/2.24/64
# COPY --from=skysider/glibc_builder32:2.24 /glibc/2.24/32 /glibc/2.24/32

# COPY --from=skysider/glibc_builder64:2.28 /glibc/2.28/64 /glibc/2.28/64
# COPY --from=skysider/glibc_builder32:2.28 /glibc/2.28/32 /glibc/2.28/32

# COPY --from=skysider/glibc_builder64:2.29 /glibc/2.29/64 /glibc/2.29/64
# COPY --from=skysider/glibc_builder32:2.29 /glibc/2.29/32 /glibc/2.29/32

# COPY --from=skysider/glibc_builder64:2.30 /glibc/2.30/64 /glibc/2.30/64
# COPY --from=skysider/glibc_builder32:2.30 /glibc/2.30/32 /glibc/2.30/32

# COPY --from=skysider/glibc_builder64:2.27 /glibc/2.27/64 /glibc/2.27/64
# COPY --from=skysider/glibc_builder32:2.27 /glibc/2.27/32 /glibc/2.27/32

COPY linux_server linux_server64  /home/kali/
COPY simple_checksec.py /usr/local/bin

RUN chmod a+x /home/kali/linux_server /home/kali/linux_server64 && \
    chmod a+x /usr/local/bin/simple_checksec.py && \
    cp /usr/local/bin/simple_checksec.py /usr/local/bin/checksec && \
    chmod a+x /usr/local/bin/checksec

ARG PWNTOOLS_VERSION

RUN python3 -V && python3 -m pip install --no-cache-dir pwntools && \
    ln -snf /usr/local/python3/bin/python3.9 /usr/bin/python

COPY ./EXP /usr/local/bin/
COPY ./prev /usr/local/bin/
COPY ./ARM /usr/local/bin/
COPY ./changelibc.sh /usr/local/bin/
COPY ./checklibc.sh /usr/local/bin/

RUN chmod a+x /usr/local/bin/EXP && \
    chmod a+x /usr/local/bin/prev && \
    chmod a+x /usr/local/bin/ARM && \
    chmod a+x /usr/local/bin/changelibc.sh && \
    chmod a+x /usr/local/bin/checklibc.sh

RUN mkdir /var/run/sshd && \
    echo "PermitRootLogin yes" >> /etc/ssh/sshd_config && \
    echo "PasswordAuthentication yes" >> /etc/ssh/sshd_config && \
    sed -ri 's/PermitRootLogin no/#PermitRootLogin no/g' /etc/ssh/sshd_config && \
    sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config

# RUN apt-get install -y lsb-release wget software-properties-common gnupg && \
#     bash -c "$(wget -O - https://apt.llvm.org/llvm.sh)"
RUN apt-get autoremove 
RUN echo "root:123456" | chpasswd
COPY entrypoint.sh /sbin
RUN chmod +x /sbin/entrypoint.sh
ENTRYPOINT [ "/sbin/entrypoint.sh" ]
