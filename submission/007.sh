#!/bin/bash
# Only one single output remains unspent from block 123,321. What address was it sent to?
block_hash=$(bitcoin-cli getblockhash 123321)
block_data=$(bitcoin-cli getblock $block_hash 3)

echo "$block_data" | jq -c '.tx[]' | while read tx; do
    index=-1
    echo "$tx" | jq -c '.vout[]' | while read output; do
        index=$(( index + 1 ))
        txid=$(echo $tx | jq -r '.txid')
        utxo=$(bitcoin-cli gettxout $txid $index | jq -r)
        if [[ -n "$utxo" ]]; then
            echo $utxo | jq -r '.scriptPubKey.address'
            break 2
        fi
    done
done
