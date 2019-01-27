
sudo lxc-attach --clear-env -n nas1 -- gluster peer probe 20.2.4.22

sudo lxc-attach --clear-env -n nas1 -- gluster peer probe 20.2.4.23

sudo lxc-attach --clear-env -n nas1 -- gluster peer status

sudo lxc-attach --clear-env -n nas1 -- gluster volume create nas replica 3 nas1:/nas nas2:/nas nas3:/nas force

sudo lxc-attach --clear-env -n nas1 -- gluster volume start nas

sudo lxc-attach --clear-env -n nas1 -- gluster volume info

sudo lxc-attach --clear-env -n nas1 -- gluster volume set nas network.ping-timeout 5

sudo lxc-attach --clear-env -n s1 -- mkdir /mnt/nas
sudo lxc-attach --clear-env -n s1 -- mount -t glusterfs 20.2.4.21:/nas /mnt/nas

sudo lxc-attach --clear-env -n s2 -- mkdir /mnt/nas
sudo lxc-attach --clear-env -n s2 -- mount -t glusterfs 20.2.4.21:/nas /mnt/nas

sudo lxc-attach --clear-env -n s3 -- mkdir /mnt/nas
sudo lxc-attach --clear-env -n s3 -- mount -t glusterfs 20.2.4.21:/nas /mnt/nas
