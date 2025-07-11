FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# Set locale and encoding for Unicode support
ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8
ENV PYTHONIOENCODING=utf-8

ENV JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64
ENV PATH=$PATH:$JAVA_HOME/bin

RUN apt-get update && apt-get install -y \
    wget \
    curl \
    git \
    vim \
    nano \
    tmux \
    htop \
    tree \
    unzip \
    zip \
    build-essential \
    cmake \
    pkg-config \
    libssl-dev \
    libffi-dev \
    python3 \
    python3-pip \
    python3-dev \
    python3-venv \
    openjdk-11-jdk \
    openjdk-11-jre \
    && rm -rf /var/lib/apt/lists/*

RUN apt-get update && apt-get install -y \
    gdb \
    binwalk \
    hexedit \
    xxd \
    strace \
    ltrace \
    netcat \
    nmap \
    tcpdump \
    socat \
    net-tools \
    iputils-ping \
    telnet \
    openssh-client \
    file \
    binutils \
    && rm -rf /var/lib/apt/lists/*

# Install radare2 - try package manager first, then from source if needed
RUN apt-get update && apt-get install -y radare2 && rm -rf /var/lib/apt/lists/* || \
    (git clone https://github.com/radareorg/radare2.git /tmp/radare2 && \
    cd /tmp/radare2 && \
    ./configure --prefix=/usr/local && \
    make -j$(nproc) && \
    make install && \
    rm -rf /tmp/radare2 && \
    ldconfig)

RUN wget -O ~/.gdbinit-gef.py -q https://gef.blah.cat/py && \
    echo 'source ~/.gdbinit-gef.py' >> /root/.gdbinit

RUN pip3 install --no-cache-dir \
    pwntools \
    ropgadget \
    capstone \
    keystone-engine \
    unicorn \
    angr \
    z3-solver \
    requests \
    beautifulsoup4 \
    lxml \
    pycryptodome \
    cryptography \
    pefile \
    pyelftools \
    lief \
    frida-tools

RUN apt-get update && apt-get install -y \
    yara \
    foremost \
    scalpel \
    testdisk \
    autopsy \
    sleuthkit \
    && rm -rf /var/lib/apt/lists/*

RUN pip3 install --no-cache-dir \
    volatility3 \
    yara-python \
    pefile \
    capstone \
    keystone-engine \
    unicorn \
    angr \
    z3-solver \
    requests \
    beautifulsoup4 \
    lxml \
    pycryptodome \
    cryptography \
    pefile \
    pyelftools \
    lief \
    frida-tools \
    ropgadget \
    pwntools

# Note: Ghidra and Cutter require manual installation from their respective repositories

WORKDIR /workspace

COPY . /workspace/

# Note: GEF is configured above via .gdbinit

RUN echo '#!/bin/bash\n\
echo "=== CLI Security Analysis Environment ==="\n\
echo "Available CLI tools:"\n\
echo "- gef: gdb (with GEF loaded)"\n\
echo "- pwntools: python3 -c \"import pwn; print(\"pwntools available\")\""\n\
echo "- radare2: r2"\n\
echo "- binwalk: binwalk"\n\
echo "- hexedit: hexedit"\n\
echo "- xxd: xxd"\n\
echo "- strace: strace"\n\
echo "- ltrace: ltrace"\n\
echo "- nmap: nmap"\n\
echo "- tcpdump: tcpdump"\n\
echo "- volatility3: volatility3"\n\
echo "- yara: yara"\n\
echo "- objdump: objdump"\n\
echo "- readelf: readelf"\n\
echo "- strings: strings"\n\
echo "- file: file"\n\
echo "- ldd: ldd"\n\
echo "- nm: nm"\n\
echo ""\n\
echo "Your project files are in /workspace"\n\
echo "Start with: cd /workspace"\n\
echo ""\n\
exec "$@"' > /usr/local/bin/startup.sh && \
chmod +x /usr/local/bin/startup.sh

CMD ["/usr/local/bin/startup.sh", "/bin/bash"] 