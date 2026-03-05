#!/bin/bash
set -e

echo "Running extreme tuning for Solana RPC Node..."

# Kernel tuning for heavy network I/O
cat <<EOF > /etc/sysctl.d/20-solana.conf
# Increase max buffer sizes
net.core.rmem_max=134217728
net.core.rmem_default=134217728
net.core.wmem_max=134217728
net.core.wmem_default=134217728

# Decrease swap usage
vm.swappiness=1

# Unlimitted file descriptors
fs.nr_open=20000000
EOF

sysctl -p /etc/sysctl.d/20-solana.conf

# Install dependencies if not present
if ! command -v docker &> /dev/null; then
    echo "Installing Docker..."
    apt-get update && apt-get install -y docker.io docker-compose
fi

echo "System Tuned. Don't forget to mount your NVMe drives to /mnt/ledger and /mnt/accounts!"
