sudo scp fw.fw root@fw:/root
sudo lxc-attach --clear-env -n fw -- sudo ./root/fw.fw