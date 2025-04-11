#!/bin/bash

# Script to set up vlayer email proof project with user input for env variables and .gitignore setup

# Create directory and navigate to it
mkdir -p my-email-proof
cd my-email-proof

# Initialize vlayer project with template
vlayer init --template simple-email-proof

# Build the project
forge build

# Navigate to vlayer directory
cd vlayer

# Install dependencies
bun install

# Prompt user for VLAYER_API_TOKEN
echo "To get your API TOKEN, go to https://dashboard.vlayer.xyz/, click 'Create new JWT token', copy your Twitter Profile, and paste it."
read -p "Enter your VLAYER_API_TOKEN: " vlayer_api_token

# Prompt user for EXAMPLES_TEST_PRIVATE_KEY
read -p "Enter your EXAMPLES_TEST_PRIVATE_KEY (e.g., 0xYOUR_PRIVATE-KEY): " private_key

# Create .env.testnet.local file with user-provided values
cat << EOF > .env.testnet.local
VLAYER_API_TOKEN=$vlayer_api_token
EXAMPLES_TEST_PRIVATE_KEY=$private_key
CHAIN_NAME=optimismSepolia
JSON_RPC_URL=https://sepolia.optimism.io
EOF

# Ensure .env.testnet.local is in .gitignore
if [ -f .gitignore ]; then
    # Check if .env.testnet.local is already in .gitignore
    if ! grep -Fx ".env.testnet.local" .gitignore > /dev/null; then
        echo ".env.testnet.local" >> .gitignore
    fi
else
    # Create .gitignore with .env.testnet.local
    echo ".env.testnet.local" > .gitignore
fi

# Notify user of completion
echo "Setup complete! The .env.testnet.local file has been created in my-email-proof/vlayer/ with your provided values."
echo ".env.testnet.local has been added to .gitignore to prevent it from being committed."
echo "You can verify the contents by checking my-email-proof/vlayer/.env.testnet.local and my-email-proof/vlayer/.gitignore."
