#!/bin/bash -x

# Create new folder for logs
rm -rf logs/
mkdir logs

if [ -z "$DC_ID" ]; then
    echo "Datacenter is not defined!"
    exit 1
fi

if [ -z "$proviant_ip" ]; then
    echo "Proviant IP is not defined!"
    exit 1
fi

if [ -z "$proviant_port" ]; then
    echo "Proviant SSH port is not defined!"
    exit 1
fi

if [ -z "$proviant_user" ]; then
    echo "Proviant user is not defined!"
    exit 1
fi

# Get FUEL_IP, user and pass from proviant
# to add - verify SSH connection to proviant
FUEL_IP=`ssh -oConnectTimeout=5 -oStrictHostKeyChecking=no -oCheckHostIP=no -oUserKnownHostsFile=/dev/null ${proviant_user}@${proviant_ip} -p ${proviant_port} proviant-dc-details --dc $DC_ID | grep 'Master: hostname:' | awk '{print $7}' | awk -F"://" '{print $2}'`
fuel_master_user=`ssh -oConnectTimeout=5 -oStrictHostKeyChecking=no -oCheckHostIP=no -oUserKnownHostsFile=/dev/null ${proviant_user}@${proviant_ip} -p ${proviant_port} proviant-dc-details --dc $DC_ID | sed -e '1,/fuel-master-ssh-credentials/d' | head -1 | awk {'print $1'}`
fuel_master_pass=`ssh -oConnectTimeout=5 -oStrictHostKeyChecking=no -oCheckHostIP=no -oUserKnownHostsFile=/dev/null ${proviant_user}@${proviant_ip} -p ${proviant_port} proviant-dc-details --dc $DC_ID | sed -e '1,/fuel-master-ssh-credentials/d' | head -1 | awk {'print $2'} | awk -F"'" '{print $2}'`

# Gen controller node IP
#to verify - SSH connection to Fuel
ctrl_ip=`sshpass -p$fuel_master_pass ssh -oConnectTimeout=5 -oStrictHostKeyChecking=no -oCheckHostIP=no -oUserKnownHostsFile=/dev/null -oRSAAuthentication=no -oPubkeyAuthentication=no $fuel_master_user@$FUEL_IP "fuel nodes" | grep controller | awk '{print $9}'`

# Get Horizon IP
horizon_ip=`ssh -oConnectTimeout=5 -oStrictHostKeyChecking=no -oCheckHostIP=no -oUserKnownHostsFile=/dev/null ${proviant_user}@${proviant_ip} -p ${proviant_port} proviant-dc-details --dc $DC_ID | grep horizonURL | awk -F"//" '{print $2}' | awk -F "/" '{print $1}'`

# to verify - SSH connection to Horizon
# here - just copy openrc file - from ctrl to fm, from fm to host where this script runs
echo '#!/bin/sh' > openrc
echo `sshpass -p$fuel_master_pass ssh -oConnectTimeout=5 -oStrictHostKeyChecking=no -oCheckHostIP=no -oUserKnownHostsFile=/dev/null -oRSAAuthentication=no -oPubkeyAuthentication=no $fuel_master_user@$FUEL_IP ssh $ctrl_ip cat /root/openrc | grep OS_TENANT_NAME` >> openrc
echo `sshpass -p$fuel_master_pass ssh -oConnectTimeout=5 -oStrictHostKeyChecking=no -oCheckHostIP=no -oUserKnownHostsFile=/dev/null -oRSAAuthentication=no -oPubkeyAuthentication=no $fuel_master_user@$FUEL_IP ssh $ctrl_ip cat /root/openrc | grep OS_USERNAME` >> openrc
echo `sshpass -p$fuel_master_pass ssh -oConnectTimeout=5 -oStrictHostKeyChecking=no -oCheckHostIP=no -oUserKnownHostsFile=/dev/null -oRSAAuthentication=no -oPubkeyAuthentication=no $fuel_master_user@$FUEL_IP ssh $ctrl_ip cat /root/openrc | grep OS_PASSWORD` >> openrc
echo `sshpass -p$fuel_master_pass ssh -oConnectTimeout=5 -oStrictHostKeyChecking=no -oCheckHostIP=no -oUserKnownHostsFile=/dev/null -oRSAAuthentication=no -oPubkeyAuthentication=no $fuel_master_user@$FUEL_IP ssh $ctrl_ip cat /root/openrc | grep OS_AUTH_URL` >> openrc
# Get fake IP from auth_url
fake_ip=`cat openrc | grep OS_AUTH_URL | awk -F":" '{print $2}' | awk -F"//" '{print $2}'`
sed -i s/$fake_ip/$horizon_ip/g openrc

source openrc

# I'd prefer to modify Murano tests to read credentials from env vars
sed -i "s<^auth_url.*<auth_url = ${OS_AUTH_URL}<g" config.conf
sed -i "s<^user.*<user = ${OS_USERNAME}<g" config.conf
sed -i "s<^password.*<password = ${OS_PASSWORD}<g" config.conf
sed -i "s<^tenant.*<tenant = ${OS_TENANT_NAME}<g" config.conf

echo $OS_TENANT_NAME
echo $OS_USERNAME
echo $OS_PASSWORD
echo $OS_AUTH_URL

nova list

rm -rf .env
virtualenv --no-site-packages --distribute .env && source .env/bin/activate && pip install -r requirements.txt
