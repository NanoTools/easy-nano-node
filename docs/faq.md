# Frequently asked questions

## Q&A

### Updating the node
Just enter the install command again:

```
bash <(curl -s https://raw.githubusercontent.com/nanotools/easy-nano-node/master/install.sh)
```

Et voilà! Have a look at the Node Monitor, you should run the newest Nano Node version.

### Node isn't synced
Let it node sync the full ledger, this can take some hours. You can always compare to the current block count [here](https://www.nanode.co/blocks).

### Account not opened
The account has no transactions in the ledger. Send some Nano to the address to open it.

### Nano isn't received
The Nano node has a configurable receive minimum which is at default 1 Nano. You can set it in the config.json (`~/RaiBlocks/config.json`). [More information at the wiki](https://github.com/nanocurrency/raiblocks/wiki/config.json).

### How do I send Nano from the node account?
The easiest way is entering the account seed into a web wallet like [NanoVault](https://nanovault.io/). You can also use the [RPC interface](https://github.com/nanocurrency/raiblocks/wiki/RPC-protocol#send).

### Node is stuck / unresponsive
Restart the Node container with `sudo docker restart enn_nanonode_1`.

### Questions not answered?
You can [open an issue here](https://github.com/NanoTools/easy-nano-node/issues) or write us at the [Nano Discord](https://chat.nano.org/), we're always helpful!

## Further reading

- [Official Wiki](https://github.com/nanocurrency/raiblocks/wiki)