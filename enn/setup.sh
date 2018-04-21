#!/bin/bash

# goto script dir
cd "$(dirname "$0")"

echo "== Updating Docker images"
sudo docker pull nanocurrency/nano
sudo docker pull nanotools/nanonodemonitor

echo "== Starting Docker containers"
sudo docker-compose up -d

echo "== Take a deep breath..."
# we need this as the node is crashing if we go on too fast
sleep 5s

# this is the old config
if [ -f /opt/nanoNodeMonitor/modules/config.php ]; then

  echo "== Old monitor config found, replacing..."
  cp /opt/nanoNodeMonitor/modules/config.php ~/nanoNodeMonitor/config.php

  echo "== Removing old monitor"
  rm -r /opt/nanoNodeMonitor

  # this also means we already inited
  touch /opt/easy-nano-node/init

fi

# check if init already done
if [ -f /opt/easy-nano-node/init ]; then

  echo "== Initialization already done, skipping ..."

else

  echo "== Creating wallet"
  wallet=$(docker exec enn_nanonode_1 /usr/bin/rai_node --wallet_create)

  echo "== Creating account"
  account=$(docker exec enn_nanonode_1 /usr/bin/rai_node --account_create --wallet=$wallet | cut -d ' ' -f2)

  echo "== Modifying the monitor config"

  # uncomment account
  sed -i -e 's#// $nanoNodeAccount#$nanoNodeAccount#g' ~/nanoNodeMonitor/config.php

  # replace account
  sed -i -e "s/xrb_1f56swb9qtpy3yoxiscq9799nerek153w43yjc9atoaeg3e91cc9zfr89ehj/$account/g" ~/nanoNodeMonitor/config.php

  # uncomment ip
  sed -i -e 's#// $nanoNodeRPCIP#$nanoNodeRPCIP#g' ~/nanoNodeMonitor/config.php

  # replace ip
  sed -i -e 's#\[::1\]#enn_nanonode_1#g' ~/nanoNodeMonitor/config.php

  echo "== Disabling RPC logging"
  sed -i -e 's#"log_rpc": "true"#"log_rpc": "false"#g' ~/RaiBlocks/config.json

  echo "== Opening Nano Node Port"
  sudo ufw allow 7075
  
  echo "== Denying RPC Port"
  sudo ufw deny 7076

  echo "== Restarting Nano node container"
  sudo docker restart enn_nanonode_1

  echo "== Just some final magic..."
  # restart because we changed the config.json
  # and the node might be unresponsive at first
  sleep 5s

  echo ""

  echo -e "=== \e[31mYOUR WALLET SEED\e[39m ==="
  echo "Please write down your wallet seed to a piece of paper and store it safely!"
  docker exec enn_nanonode_1 /usr/bin/rai_node --wallet_decrypt_unsafe --wallet=$wallet | grep "Seed: "
  echo -e "=== \e[31mYOUR WALLET SEED\e[39m ==="

  # we're done, save for later
  touch /opt/easy-nano-node/init

fi

# get that nasty IP
serverip=$(ip route get 8.8.8.8 | awk '{ print $NF; exit }')

echo ""
echo "All done! *yay*"
echo "View your Nano Node Monitor at http://$serverip"
echo ""
echo "Have a look at the FAQ: https://nanotools.github.io/easy-nano-node/faq.html"
echo ""
