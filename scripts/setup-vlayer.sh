#!/bin/bash

# Exit on any error
set -e

# File to store API token and private key
ENV_FILE="$HOME/Vlayer/.env"

# Function to load API token and private key from the .env file
load_env() {
    if [ -f "$ENV_FILE" ]; then
        source "$ENV_FILE"
    else
        echo "Error: $ENV_FILE not found. Please create it with VLAYER_API_TOKEN, EXAMPLES_TEST_PRIVATE_KEY, CHAIN_NAME, and JSON_RPC_URL."
        exit 1
    fi
}

# Function to determine project details based on script name
get_project_details() {
    case "$(basename "$0")" in
        setup-email-proof.sh)
            echo "my-email-proof simple-email-proof 'Email Proof'"
            ;;
        setup-teleport.sh)
            echo "my-simple-teleport simple-teleport 'Teleport'"
            ;;
        setup-time-travel.sh)
            echo "my-simple-time-travel simple-time-travel 'Time Travel'"
            ;;
        setup-web-proof.sh)
            echo "my-simple-web-proof simple-web-proof 'Web Proof'"
            ;;
        *)
            echo "Error: Unknown script name. Use one of: setup-email-proof.sh, setup-teleport.sh, setup-time-travel.sh, setup-web-proof.sh"
            exit 1
            ;;
    esac
}

# Get project details
read -r PROJECT_DIR TEMPLATE PROJECT_NAME <<< $(get_project_details)

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

echo "Setting up vLayer project: $PROJECT_NAME..."

# Create directory and navigate
mkdir -p "$PROJECT_DIR"
cd "$PROJECT_DIR"

# Initialize vLayer project (skip if already initialized)
if [ ! -f "foundry.toml" ]; then
    echo "Initializing vLayer project with template $TEMPLATE..."
    vlayer init --template "$TEMPLATE"
else
    echo "vLayer project already initialized in $PROJECT_DIR."
fi

# Build the project
echo "Building project..."
forge build

# Navigate to vlayer directory
cd vlayer

# Install Bun dependencies
echo "Installing Bun dependencies..."
bun install

# Load API token and private key from .env file
load_env

# Verify that required variables are set
if [ -z "$VLAYER_API_TOKEN" ] || [ -z "$EXAMPLES_TEST_PRIVATE_KEY" ] || [ -z "$CHAIN_NAME" ] || [ -z "$JSON_RPC_URL" ]; then
    echo "Error: One or more required variables (VLAYER_API_TOKEN, EXAMPLES_TEST_PRIVATE_KEY, CHAIN_NAME, JSON_RPC_URL) are not set in $ENV_FILE."
    exit 1
fi

# Create .env.testnet.local file with inputs
echo "Creating environment file..."
cat > .env.testnet.local << EOL
VLAYER_API_TOKEN=$VLAYER_API_TOKEN
EXAMPLES_TEST_PRIVATE_KEY=$EXAMPLES_TEST_PRIVATE_KEY
CHAIN_NAME=$CHAIN_NAME
JSON_RPC_URL=$JSON_RPC_URL
EOL

echo "Environment file created at .env.testnet.local"

# Run the prove command
echo "Running prove:testnet..."
bun run prove:testnet

echo "✅ Setup complete for $PROJECT_NAME!"
