#!/bin/bash

output=$(kubeconform -summary -output json "$@")
invalid=$(echo "$output" | jq '.resources[] | select(.status == "statusInvalid")')

if [ -n "$invalid" ]; then
    echo "$invalid" | jq .
    exit 1
fi