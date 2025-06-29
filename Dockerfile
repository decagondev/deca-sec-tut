FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

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

# Install radare2 from git
RUN git clone https://github.com/radareorg/radare2.git /tmp/radare2 && \
    cd /tmp/radare2 && \
    sys/install.sh && \
    rm -rf /tmp/radare2

RUN git clone https://github.com/pwndbg/pwndbg.git /opt/pwndbg && \
    cd /opt/pwndbg && \
    ./setup.sh

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
    elftools \
    lief \
    frida-tools

RUN apt-get update && apt-get install -y \
    volatility3 \
    volatility3-plugins \
    yara \
    yara-python \
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
    elftools \
    lief \
    frida-tools \
    ropgadget \
    pwntools

RUN apt-get update && apt-get install -y \
    ghidra-headless \
    cutter-headless \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /workspace

COPY . /workspace/

RUN echo "source /opt/pwndbg/gdbinit.py" >> /root/.gdbinit

RUN echo '#!/bin/bash\n\
echo "=== CLI Security Analysis Environment ==="\n\
echo "Available CLI tools:"\n\
echo "- pwndbg: gdb (with pwndbg loaded)"\n\
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
echo "- ghidra-headless: ghidra-headless"\n\
echo ""\n\
echo "Your project files are in /workspace"\n\
echo "Start with: cd /workspace"\n\
echo ""\n\
exec "$@"' > /usr/local/bin/startup.sh && \
chmod +x /usr/local/bin/startup.sh

CMD ["/usr/local/bin/startup.sh", "/bin/bash"] 