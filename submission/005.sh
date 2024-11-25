#!/bin/bash
# Create a 1-of-4 P2SH multisig address from the public keys in the four inputs of this tx:
#   `37d966a263350fe747f1c606b159987545844a493dd38d84b070027a895c4517`
tx_inputs=$(bitcoin-cli getrawtransaction 37d966a263350fe747f1c606b159987545844a493dd38d84b070027a895c4517 1 | jq -c '.vin')

pubkey_0=$(echo "$tx_inputs" | jq -r '.[0].txinwitness[1]')
pubkey_1=$(echo "$tx_inputs" | jq -r '.[1].txinwitness[1]')
pubkey_2=$(echo "$tx_inputs" | jq -r '.[2].txinwitness[1]')
pubkey_3=$(echo "$tx_inputs" | jq -r '.[3].txinwitness[1]')

multisig_addresses=$(echo "[\"$pubkey_0\",\"$pubkey_1\",\"$pubkey_2\",\"$pubkey_3\"]")

echo $(bitcoin-cli createmultisig 1 $multisig_addresses | jq -r '.address')