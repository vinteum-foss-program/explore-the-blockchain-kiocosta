#!/bin/bash
# Which public key signed input 0 in this tx:
#   `e5969add849689854ac7f28e45628b89f7454b83e9699e551ce14b6f90c86163`
segwit_script=$(bitcoin-cli getrawtransaction e5969add849689854ac7f28e45628b89f7454b83e9699e551ce14b6f90c86163 2 | jq -r '.vin[0].txinwitness[2]')
signing_address=$(bitcoin-cli decodescript $segwit_script | jq -r '.asm' | awk '{print $2}')
echo $signing_address
