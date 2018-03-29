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

5. Enter the following command to start the setup:

```
bash <(curl -s https://raw.githubusercontent.com/nanotools/easy-nano-node/master/install.sh)
```
