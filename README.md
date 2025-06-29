# CLI Security Analysis Environment

This Docker environment provides a comprehensive set of CLI-based tools for security analysis, reverse engineering, and exploit development. All tools are command-line based, making it perfect for headless environments and automation.

## Included Tools

### Reverse Engineering
- **Radare2** - Advanced reverse engineering framework
- **Binwalk** - Firmware analysis tool
- **objdump** - Object file disassembler
- **readelf** - ELF file analyzer
- **nm** - Symbol table display
- **strings** - String extractor
- **file** - File type identifier
- **ldd** - Shared library dependencies

### Debugging & Exploitation
- **pwndbg** - Enhanced GDB for exploit development
- **pwntools** - CTF framework and exploit development library
- **ROPgadget** - ROP gadget finder
- **Capstone** - Multi-architecture disassembly framework
- **Keystone** - Multi-architecture assembler framework
- **Unicorn** - CPU emulator framework
- **Angr** - Binary analysis framework

### Network Analysis
- **tcpdump** - Command-line packet analyzer
- **nmap** - Network discovery and security auditing
- **netcat** - Networking utility
- **socat** - Multipurpose relay

### Memory Analysis
- **Volatility3** - Memory forensics framework
- **Yara** - Pattern matching tool

### File Analysis & Forensics
- **foremost** - File carving tool
- **scalpel** - File carving tool
- **testdisk** - Data recovery tool
- **autopsy** - Digital forensics platform
- **sleuthkit** - File system analysis tools

### Other Tools
- **strace/ltrace** - System call tracing
- **hexedit** - Hex editor
- **xxd** - Hex dump utility
- **Frida** - Dynamic instrumentation toolkit

## Quick Start

### Using Docker Compose (Recommended)

1. Build and start the environment:
   ```bash
   docker-compose up -d
   ```

2. Access the container:
   ```bash
   docker-compose exec sec-env bash
   ```

3. Stop the environment:
   ```bash
   docker-compose down
   ```

### Using Docker directly

1. Build the image:
   ```bash
   docker build -t security-env .
   ```

2. Run the container:
   ```bash
   docker run -it --rm -v $(pwd):/workspace security-env
   ```

## Usage Examples

### Using pwndbg
```bash
# Start GDB with pwndbg
gdb /workspace/static/example1

# Common pwndbg commands
break main
run
disassemble main
info registers
```

### Using pwntools
```python
#!/usr/bin/env python3
from pwn import *

# Example exploit script
context.arch = 'amd64'
context.os = 'linux'

# Create a process
p = process('/workspace/static/example1')

# Send payload
payload = b"A" * 64 + p64(0xdeadbeef)
p.sendline(payload)

# Get response
response = p.recvall()
print(response)
```

### Using Radare2
```bash
# Analyze a binary
r2 -A /workspace/static/example1

# Common r2 commands
aa          # Analyze all
afl         # List functions
pdf @main   # Disassemble main function
```

### Binary Analysis with Standard Tools
```bash
# Get file information
file /workspace/static/example1

# View strings
strings /workspace/static/example1

# Disassemble with objdump
objdump -d /workspace/static/example1

# View ELF headers
readelf -h /workspace/static/example1

# View symbols
nm /workspace/static/example1

# View shared library dependencies
ldd /workspace/static/example1
```

### Network Analysis
```bash
# Network scan
nmap -sS -sV localhost

# Packet capture
tcpdump -i any -w capture.pcap

# Network connection
nc -lvp 4444
```

### Memory Analysis
```bash
# Volatility3 analysis
volatility3 -f memory.dmp windows.pslist

# Yara scanning
yara rules.yar target_file
```

## Project Structure

```
/workspace/
├── src/           # Source code files
├── static/        # Compiled binaries
├── tutorial1.html # Tutorial materials
├── tutorial2.html
└── tutorial3.html
```

## Tips

1. **Persistent Workspace**: Your local files are mounted to `/workspace` in the container
2. **Tool Updates**: Tools are installed from official repositories and GitHub
3. **Custom Scripts**: Add your own scripts to the `/workspace` directory
4. **Package Management**: Use `apt-get update && apt-get install` for additional packages
5. **Python Environment**: Use `pip3 install` for additional Python packages
6. **CLI Automation**: Perfect for scripting and automation workflows

## Troubleshooting

### Common Issues

1. **Permission denied**: Check file permissions on mounted volumes
2. **Out of disk space**: Clean up Docker images and containers
3. **Network issues**: Check if ports are already in use
4. **Tool not found**: Ensure the tool is installed in the container

### Useful Commands

```bash
# Clean up Docker resources
docker system prune -a

# View container logs
docker-compose logs sec-env

# Access container as root
docker-compose exec -u root sec-env bash

# Copy files from container
docker cp security-tutorial-env:/path/to/file ./local/path

# Check available tools
which gdb r2 binwalk objdump readelf
```

## Advantages of CLI-Only Environment

1. **Lightweight**: Smaller image size, faster builds
2. **Headless**: Works in environments without GUI
3. **Automation**: Easy to script and automate
4. **Remote**: Perfect for SSH/remote access
5. **Resource Efficient**: Lower memory and CPU usage
6. **Consistent**: Same experience across all platforms

## Security Note

This environment is designed for educational and authorized security testing purposes only. Always ensure you have proper authorization before analyzing any systems or binaries that you don't own. 