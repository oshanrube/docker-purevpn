#!/bin/bash
#
# Connect to random vpn endpoint
#
# Required environment variables:
#  - purevpn_username
#  - purevpn_password

set -e

ORIG_IP=$(curl -s 'icanhazip.com')
echo "Current IP: ${ORIG_IP}"

cd /etc/openvpn

echo "${purevpn_username}\n${purevpn_password}" > /etc/openvpn/auth.txt


# get all location codes
LOCATIONS=$(ls /etc/openvpn/TCP)
ARRAY=(${LOCATIONS//:/ })
LEN=${#ARRAY[@]}

# select random one
RANDOM_LOCATION=${ARRAY[$((RANDOM % $LEN))]}

# connect
echo "Connecting to ${RANDOM_LOCATION}..."
openvpn --config "/etc/openvpn/purevpn/${RANDOM_LOCATION" --auth-user-pass /etc/openvpn/auth.txt

# fix resolve
echo "nameserver 8.8.8.8" > /etc/resolv.conf

NEW_IP=$(curl -s 'icanhazip.com')
echo "Original IP: ${ORIG_IP}"
echo "New IP (${RANDOM_LOCATION}): ${NEW_IP}"

exec "$@"
