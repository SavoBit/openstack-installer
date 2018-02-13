set -e
set -x

# needed to create with admin login as Ocata policies don't allow users to create ports with specific IP addresses
source /root/files/admin-openrc.sh
#source /root/files/demo-openrc.sh
export OS_PROJECT_NAME=demo

netid=`neutron net-show p2 -c 'id' --format 'value'`
net6id=`neutron net-show data6 -c 'id' --format 'value'`
nova boot --flavor m1.se \
    --image trusty \
    --nic net-id=$netid,v4-fixed-ip=10.0.2.10 \
    --nic net-id=$net6id,v6-fixed-ip=b100::10 \
    --user-data ./cloud-init.sh \
    --config-drive True \
    trusty1
