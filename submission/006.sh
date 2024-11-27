#!/bin/bash
# Which tx in block 257,343 spends the coinbase output of block 256,128?
verbose=2
first_block_hash=$(bitcoin-cli getblockhash 256128)
coinbase_output_address=$(bitcoin-cli getblock $first_block_hash $verbose | jq -r '.tx[0].vout[0].scriptPubKey.address')

second_block_hash=$(bitcoin-cli getblockhash 257343)
second_block_data=$(bitcoin-cli getblock $second_block_hash 3)

# loops through the tx's of the 2nd block
echo "$second_block_data" | jq -c '.tx[]' | while read tx; do
    # loops through the inputs array
    echo "$tx" | jq -c '.vin[]' | while read vin; do
        prevout=$(echo "$vin" | jq -r '.prevout.scriptPubKey.address')
        if [[ "$prevout" == "$coinbase_output_address" ]]; then
            echo "$tx" | jq -r '.txid'
            break 2
        fi
    done
done
