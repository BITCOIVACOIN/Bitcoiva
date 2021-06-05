# Bitcoiva

Bitcoiva is the first implementation of the Bitcoiva Hub, built using the [Bitcoiva SDK](https://github.com/osiz-blockchainapp/bitcoiva-sdk).
## Mainnet Full Node Quick Start

This assumes that you're running Linux or MacOS and have installed [Go 1.14+](https://golang.org/dl/).  This guide helps you:

* build and install Bitcoiva
* allow you to name your node
* add seeds to your config file
* download genesis state
* start your node
* use bitcoivacli to check the status of your node.

Build, Install, and Name your Node:

```bash
# Clone Bitcoiva from the latest release:
git clone git@bitbucket.org:bitcoiva/bitcoiva_cosmos.git
# Enter the folder Bitcoiva was cloned into
cd bitcoiva_cosmos/Bitcoiva
# Compile and install Bitcoiva
make install
# Initialize Bitcoivad in ~/.bitcoivad and name your node
bitcoivad init yournodenamehere
```

Add Seeds:

```bash
# Edit config.toml to connect peer node
nano ~/.bitcoivad/config/config.toml
```

Scroll down to seeds in `config.toml`, and add some of these seeds as a comma-separated list under persistent_peers and seeds:

```toml
ba3bacc714817218562f743178228f23678b2873@5.83.160.108:26656
1e63e84945837b026f596ed8ae68708783d04ad4@51.75.145.123:26656

```

Start your Node, Check your Node Status:

```bash

# Start Bitcoivad
bitcoivad start
# Check your node's status with bitcoivacli
bitcoivacli status
```




