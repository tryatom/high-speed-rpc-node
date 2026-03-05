# ⚡ High-Speed Solana RPC Node

<div align="center">
  <img src="https://img.shields.io/badge/Solana-14F195?style=for-the-badge&logo=solana&logoColor=black" alt="Solana" />
  <img src="https://img.shields.io/badge/Rust-000000?style=for-the-badge&logo=rust&logoColor=white" alt="Rust" />
  <img src="https://img.shields.io/badge/Docker-2CA5E0?style=for-the-badge&logo=docker&logoColor=white" alt="Docker" />
</div>

<br>

A high-performance, enterprise-grade Solana RPC node configuration designed for maximum throughput and minimum latency. Optimized for DApps, DEXs, and programmatic trading operations requiring absolute reliability.

## 🌟 Key Features

- **Jito-Solana Integration:** Built on the highly optimized Jito-Solana client for unparalleled block propagation speeds and MEV capabilities.
- **Geyser Plugin Support:** Pre-configured architecture to support streaming account data directly via Geyser plugins for real-time analytics.
- **Aggressive Caching Layer:** Implements a custom in-memory caching tier to serve `getAccountInfo` and `getProgramAccounts` requests instantaneously.
- **Failover & Load Balancing:** Included Nginx and HAProxy configurations for deploying a resilient multi-node cluster.
- **Prometheus & Grafana Observability:** Out-of-the-box monitoring dashboards tracking hardware utilization, RPC error rates, and websocket connection stability.

## 💻 Hardware Requirements

To achieve optimal performance, we recommend deploying on bare-metal infrastructure matching or exceeding the following specifications:

- **CPU:** 32 Cores / 64 Threads (AMD EPYC or Intel Core i9/Xeon)
- **RAM:** 512GB+ ECC DDR4/DDR5
- **Storage:** 2x 2TB NVMe PCIe 4.0 SSDs in RAID 0 (for the ledger and accounts DB)
- **Network:** 10 Gbps Unmetered Dedicated Port

## 🛠 Installation & Setup

### 1. System Preparation

Ensure your Ubuntu 22.04 LTS system is fully updated and tuned for high network throughput.

```bash
git clone https://github.com/tryatom/high-speed-rpc-node.git
cd high-speed-rpc-node
chmod +x ./scripts/setup_system.sh
sudo ./scripts/setup_system.sh
```

### 2. Configure Node Parameters

Copy the example environment configuration and adjust the variables for your specific setup (Mainnet-Beta vs Devnet, snapshot URLs).

```bash
cp .env.example .env
nano .env
```

### 3. Start the Node

We utilize Docker and Docker Compose to manage the RPC service, monitoring stack, and networking layers.

```bash
docker-compose --profile rpc up -d
```

### 4. Syncing the Ledger

The node will automatically download the latest mainnet snapshot and begin catching up to the tip of the network. You can monitor the progress via the Solana CLI:

```bash
solana catchup --our-localhost
```

## 📊 Architecture

This configuration abstracts away the complexity of running a reliable RPC endpoint:

1. **HAProxy/Nginx:** Distributes incoming HTTP/WSS requests across healthy backend nodes.
2. **Solana Validator Client (RPC Mode):** The core engine syncing blocks and managing the Accounts DB.
3. **Geyser Plugin (Optional):** Emits real-time state changes to a PostgreSQL or Kafka sink.
4. **Monitoring Stack:** Prometheus scraping metrics exposed by the validator, visualized in Grafana.

## 🔒 Security Best Practices

- Ensure the RPC port (usually 8899) is **not exposed** directly to the public internet unless rate-limited and proxied via Nginx/Cloudflare.
- Restrict access to the validator's command-line interface and configuration files.
- Regularly monitor logs for anomalous request patterns indicitive of abuse or DDoS attempts.

## 🤝 Contributing

We welcome optimizations to the startup scripts, hardware tuning parameters, and monitoring dashboards.

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/Optimization`)
3. Commit your Changes (`git commit -m 'Implement Kernel Tunings'`)
4. Push to the Branch (`git push origin feature/Optimization`)
5. Open a Pull Request

## 📄 License

Distributed under the MIT License. See `LICENSE` for more information.
 
<!-- Documentation update 2 for high-speed-rpc-node -->
