# Setup a Nano Node on Ubuntu 16.04

1. Add GPG keys
```
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
```

2. Add Docker repo
```
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
```

3. Update your APT package manager
```
sudo apt-get update
```

4. Install Docker
```
sudo apt-get install -y docker-ce
```

5. Create a directory called _nano_ and go inside it: `mkdir nano && cd nano`

6. Create a new file called _docker-compose.yml_ with the following contents:

```
version: '3'
services:
  monitor:
    image: "nanotools/nanonodemonitor"
    restart: "unless-stopped"
    ports:
     - "80:80"
    volumes:
     - "~:/opt"
  node:
    image: "nanocurrency/nano"
    restart: "unless-stopped"
    ports:
     - "7075:7075/udp"
     - "7075:7075"
     - "::1:7076:7076"
    volumes:
     - "~:/root"
```

3. Nice! Now execute `sudo docker-compose up -d` to start everything.

4. Create a new wallet by exceucting:
```
sudo docker exec nano_node_1 /usr/bin/rai_node --wallet_create
```
You should get a wallet ID which you need in the next step.

5. Change the WALLETID and creata a new account by executing:
```
sudo docker exec nano_node_1 /usr/bin/rai_node --account_create --wallet=<WALLETID>
```
You get a new Nano address starting with xrb_1234... back.

6. Get you wallet seed with:
```
sudo docker exec nano_node_1 /usr/bin/rai_node --wallet_decrypt_unsafe --wallet=<WALLETID>
```

6. Inside your home directory you will find a new directory called _nanoNodeMonitor_, edit the _config.php_: `cd ~/nanoNodeMonitor`

7. You will have to change the node IP to `nano_node_1` and the address to the address from step 5. Edit the other things as well if you want to.

8. Done! Please have a look at the [FAQ](faq.md).

## Fast Sync

If you sync from scratch it can take up to 3 days for the node to sync the ledger completely. You can download the current ledger by hand and replace it. 

1. **Make sure that you have your seed stored safely!** It will be overwritten with this process.

2. Get the direct download link from [Yandex.Disk](https://yadi.sk/d/fcZgyES73Jzj5T) or [Google Drive](https://drive.google.com/drive/folders/1sP1z9S011f1W_0nK1KJ-UCJbjaNmk8GQ)

3. SSH to your server, stop the node (`sudo docker stop nano_node_1`) and go to the `~/RaiBlocks` directory

4. Backup your old ledger file with:
```
mv data.ldb data.ldb.bak
mv data.ldb-lock data.ldb-lock.bak
```

5. Download the file with wget:
```
wget "https://DOWNLOADLINK" -O ledger.7z
```

6. Install 7zip
```
sudo apt-get install p7zip-full
```

7. Unzip it with:
```
7z x ledger.7z
```

8. Start your node again with `sudo docker start nano_node_1`

9. Restore your seed with:
```
sudo docker exec nano_node_1 /usr/bin/rai_node --wallet_create
```
Replace the wallet ID you got in the next command:
```
sudo docker exec nano_node_1 /usr/bin/rai_node --wallet_change_seed --wallet=<WALLETID> --key=<SEED>
```
And create your account address:
```
sudo docker exec nano_node_1 /usr/bin/rai_node --account_create  --wallet=<WALLETID>
```
You should see your previous address again.

10. Done!


## Support

If you find this tool useful show your support by changing your representative or donate to:

    xrb_1ninja7rh37ehfp9utkor5ixmxyg8kme8fnzc4zty145ibch8kf5jwpnzr3r

Thanks a lot!