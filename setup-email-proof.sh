#!/bin/bash

set -e

echo "🔧 Installing dependencies..."

sudo apt-get update && sudo apt-get install -y git curl unzip build-essential

curl -L https://foundry.paradigm.xyz/ | bash
source ~/.bashrc
foundryup

curl -fsSL https://bun.sh/install | bash
source ~/.profile

curl -SL https://install.vlayer.xyz/ | bash
source ~/.bashrc
vlayerup

echo "✅ Dependencies installed."
echo "📁 Setting up vLayer project in clean folder..."

# Create and move to clean subdirectory
mkdir -p my-email-proof
cd my-email-proof

# Initialize vLayer project
vlayer init --template simple-email-proof

# Build project
forge build

# Go to generated vlayer directory
cd vlayer
bun install

# Prompt for secrets
echo "🔐 Please enter your vLayer API Token:"
read -s VLAYER_API_TOKEN
echo

echo "🔐 Please enter your private key (starting with 0x):"
read -s EXAMPLES_TEST_PRIVATE_KEY
echo

# Create env file
cat > .env.testnet.local << EOL
VLAYER_API_TOKEN=$VLAYER_API_TOKEN
EXAMPLES_TEST_PRIVATE_KEY=$EXAMPLES_TEST_PRIVATE_KEY
CHAIN_NAME=optimismSepolia
JSON_RPC_URL=https://sepolia.optimism.io
EOL

echo "✅ Environment file created."

# Run prove
echo "🚀 Running prove:testnet..."
bun run prove:testnet

echo "🎉 Setup complete!"

# Optional git commit
git add .
git commit -m "Prep: Setup complete from script"
