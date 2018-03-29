#!/bin/bash

# goto script dir
cd "$(dirname "$0")"

echo "== Cloning Nano Node Monitor"
git clone https://github.com/nanotools/nanoNodeMonitor.git /opt/nanoNodeMonitor

echo "== Starting Docker containers"
sudo docker-compose up -d

echo "== Creating wallet"
wallet=$(docker exec enn_nanonode_1 /usr/bin/rai_node --wallet_create)

echo "== Creating account"
account=$(docker exec enn_nanonode_1 /usr/bin/rai_node --account_create --wallet=$wallet | cut -d ' ' -f2)

echo "== Creating monitor config"
cp /opt/nanoNodeMonitor/modules/config.sample.php /opt/nanoNodeMonitor/modules/config.php

echo "== Modifying the monitor config"

# uncomment account
sed -i -e 's#// $nanoNodeAccount#$nanoNodeAccount#g' /opt/nanoNodeMonitor/modules/config.php

# replace account
sed -i -e "s/xrb_1f56swb9qtpy3yoxiscq9799nerek153w43yjc9atoaeg3e91cc9zfr89ehj/$account/g" /opt/nanoNodeMonitor/modules/config.php

# uncomment ip
sed -i -e 's#// $nanoNodeRPCIP#$nanoNodeRPCIP#g' /opt/nanoNodeMonitor/modules/config.php

# replace ip
sed -i -e 's#\[::1\]#enn_nanonode_1#g' /opt/nanoNodeMonitor/modules/config.php

echo "== Opening Nano Node Port"
sudo ufw allow 7075

echo ""

echo -e "=== \e[31mYOUR WALLET SEED\e[39m ==="
echo "Please write down your wallet seed to a piece of paper and store it safely!"
docker exec enn_nanonode_1 /usr/bin/rai_node --wallet_decrypt_unsafe --wallet=$wallet
echo -e "=== \e[31mYOUR WALLET SEED\e[39m ==="

serverip=$(ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -vE '^(192\.168|10\.|172\.1[6789]\.|172\.2[0-9]\.|172\.3[01]\.|127\.0\.0\.1)')

echo ""
echo "All done! *yay*"
echo "View your Nano Node Monitor at http://$serverip"
echo ""