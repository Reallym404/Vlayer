# Vlayer
vlayer provides tools and infrastructure that give smart contracts super powers like time travel to past blocks, teleport to different chains, access to real data from the web, and email.


## Installation
- The easiest way to install vlayer is by using vlayerup, the vlayer toolchain installer.


## Now Visit here: https://dashboard.vlayer.xyz/
- Connect Wallet or Gmail
- Go to Account Bind your Airdrop Wallet (EVM)

First get faucet :  Op Sepolia Faucet:
   🔗  https://www.alchemy.com/faucets/ethereum-sepolia
  🔗   https://testnet.brid.gg/op-sepolia


## 1. Install dependencies
```bash
sudo apt-get update && sudo apt-get install -y git curl unzip build-essential && \
curl -L https://foundry.paradigm.xyz/ | bash && \
source ~/.bashrc && \
foundryup && \
curl -fsSL https://bun.sh/install | bash && \
source ~/.profile && \
curl -SL https://install.vlayer.xyz/ | bash && \
source ~/.bashrc && \
vlayerup
```

## 2. Fix Git Identity Issues (to avoid errors during vlayer init)
```bash
git config --global user.email "you@example.com"
git config --global user.name "Your Name"
```

## Feature:  
- Time travel
```bash
mkdir my-email-proof
cd my-email-proof
vlayer init --template simple-email-proof
forge build
cd vlayer
bun install
nano .env.testnet.local
VLAYER_API_TOKEN=YOUR_VLAYER_API_TOKEN // To get your API TOKEN go to https://dashboard.vlayer.xyz/ ▶️ Click Create new JWT token ▶️ Copy your Twitter Profile and paste ▶️ Copy your api token and save it!
EXAMPLES_TEST_PRIVATE_KEY=0xYOUR-PRIVATE-KEY  // Change YOUR_VLAYER_API_TOKEN and 0xYOUR-PRIVATE-KEY with your own
CHAIN_NAME=optimismSepolia
JSON_RPC_URL=https://sepolia.optimism.io
bun run prove:testnet
```
