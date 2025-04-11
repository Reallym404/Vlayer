# Vlayer
vlayer provides tools and infrastructure that give smart contracts super powers like time travel to past blocks, teleport to different chains, access to real data from the web, and email.


## Installation
# The easiest way to install vlayer is by using vlayerup, the vlayer toolchain installer.


## Now Visit here: https://dashboard.vlayer.xyz/
- Connect Wallet or Gmail
- Go to Account Bind your Airdrop Wallet (EVM)

First get faucet :  Op Sepolia Faucet:
-   🔗  https://www.alchemy.com/faucets/ethereum-sepolia
-   🔗   https://testnet.brid.gg/op-sepolia

## Use Codespace to deploy https://github.com/codespaces
- Click blank template 

## 1. Steps to Upgrade from 20.04 to 24.04
```bash
sudo apt update && sudo apt upgrade -y
sudo apt dist-upgrade -y
sudo apt install update-manager-core
sudo do-release-upgrade -d
lsb_release -a
```
- Output: Description: Ubuntu 24.04.2 LTS

## 2. Clone repo
```bash
git clone https://github.com/Gmhax/Vlayer.git 
cd Vlayer
git add scripts/setup-vlayer.sh
```

## 3. Create the .env
```bash
nano ~/Vlayer/.env
```
-Paste: 
```bash
VLAYER_API_TOKEN=YOUR_VLAYER_API_TOKEN
EXAMPLES_TEST_PRIVATE_KEY=0xYOUR-PRIVATE-KEY
CHAIN_NAME=optimismSepolia
JSON_RPC_URL=https://sepolia.optimism.io
```
<pre> 
- Steps to get your API token:

- Go to https://dashboard.vlayer.xyz/

- Click "Create new JWT token"

- Paste your Twitter profile URL

- Copy your API token and save it somewhere safe 
 </pre>

- Secure the .env File
```bash
chmod 600 ~/Vlayer/.env
echo ".env" >> ~/Vlayer/.gitignore
```


## 4. Script Executable
```bash
chmod +x ~/Vlayer/scripts/setup-vlayer.sh
```

## 5. Create the Symbolic 
```bash
ln -s setup-vlayer.sh ~/Vlayer/scripts/setup-email-proof.sh
ln -s setup-vlayer.sh ~/Vlayer/scripts/setup-teleport.sh
ln -s setup-vlayer.sh ~/Vlayer/scripts/setup-time-travel.sh
ln -s setup-vlayer.sh ~/Vlayer/scripts/setup-web-proof.sh
```


## EXECUTE THE FEATURES

- Time travel
```bash
git add .
git commit -m "Prep: Setup complete from script"
```
```bash
setup-time-travel.sh
```

-Email proof
```bash
git add .
git commit -m "Prep: Setup complete from script"
```
```bash
setup-email-proof.sh
```

- Teleport 
```bash
git add .
git commit -m "Prep: Setup complete from script"
```
```bash
setup-teleport.sh
```
- Web proof
```bash
git add .
git commit -m "Prep: Setup complete from script"
```
```bash
setup-web-proof.sh
```



## DONE BRUUUHHH!!!!!













