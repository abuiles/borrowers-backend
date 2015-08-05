#
# Enable filesystem options
# - ACL's
# - discard flag (might make VM disks more compact)
# - /tmp on tmpfs
#
sed --in-place -e 's/\(.*swap.*sw\)/\1,discard/' /etc/fstab
sed --in-place -e 's/\(.*ext[34].*defaults\)/\1,acl,discard/' /etc/fstab

# this is not useable where /tmp may grow above 512M
#echo "tmpfs /tmp tmpfs defaults,noatime,nodev,mode=1777,size=512M 0 0" >> /etc/fstab
#rm -rf /tmp/*
#mount /tmp
