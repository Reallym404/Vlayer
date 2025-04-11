#!/bin/bash

# Exit on any error
set -e

echo "🔧 Installing dependencies..."

# Core system deps
sudo apt-get update && sudo apt-get install -y git curl unzip build-essential

# Install Foundry
if ! command -v forge &> /dev/null; then
    curl -L https://foundry.paradigm.xyz/ | bash
    source ~/.bashrc
    foundryup
else
    echo "Foundry already installed."
fi

# Install Bun
if ! command -v bun &> /dev/null; then
    curl -fsSL https://bun.sh/install | bash
    source ~/.profile
else
    echo "Bun already installed."
fi

# Install vLayer CLI
if ! command -v vlayer &> /dev/null; then
    curl -SL https://install.vlayer.xyz/ | bash
    source ~/.bashrc
    vlayerup
else
    echo "vLayer CLI already installed."
fi

echo "✅ Dependencies installed."

# Function to set up a vLayer project
setup_vlayer_project() {
    local project_dir="$1"
    local template="$2"
    local project_name="$3"

    echo "Setting up vLayer project: $project_name..."

    # Create directory and navigate
    mkdir -p "$project_dir"
    cd "$project_dir"

    # Initialize vLayer project (skip if already initialized)
    if [ ! -f "foundry.toml" ]; then
        echo "Initializing vLayer project with template $template..."
        vlayer init --template "$template"
    else
        echo "vLayer project already initialized in $project_dir."
    fi

    # Build the project
    echo "Building project..."
    forge build

    # Navigate to vlayer directory
    cd vlayer

    # Install Bun dependencies
    echo "Installing Bun dependencies..."
    bun install

    # Prompt for API token and private key (only once, but we'll write to each project's .env)
    if [ -z "$VLAYER_API_TOKEN" ]; then
        echo "Please enter your vLayer API Token (get it from https://dashboard.vlayer.xyz/):"
        read -r VLAYER_API_TOKEN
        echo
    fi

    if [ -z "$EXAMPLES_TEST_PRIVATE_KEY" ]; then
        echo "Please enter your private key (starting with 0x):"
        read -r EXAMPLES_TEST_PRIVATE_KEY
        echo
    fi

    # Create .env.testnet.local file with inputs
    echo "Creating environment file..."
    cat > .env.testnet.local << EOL
VLAYER_API_TOKEN=$VLAYER_API_TOKEN
EXAMPLES_TEST_PRIVATE_KEY=$EXAMPLES_TEST_PRIVATE_KEY
CHAIN_NAME=optimismSepolia
JSON_RPC_URL=https://sepolia.optimism.io
EOL

    echo "Environment file created at .env.testnet.local"

    # Run the prove command
    echo "Running prove:testnet..."
    bun run prove:testnet

    echo "✅ Setup complete for $project_name!"

    # Navigate back to the root directory
    cd ../..
}

# Set up all four projects
setup_vlayer_project "my-email-proof" "simple-email-proof" "Email Proof"
setup_vlayer_project "my-simple-teleport" "simple-teleport" "Teleport"
setup_vlayer_project "my-simple-time-travel" "simple-time-travel" "Time Travel"
setup_vlayer_project "my-simple-web-proof" "simple-web-proof" "Web Proof"

echo "✅ All vLayer projects have been set up!"
