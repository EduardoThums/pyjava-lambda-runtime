#!/bin/bash

LAMBDA_NAME=$1

if [ -z $LAMBDA_NAME ]; then
    echo "Missing lambda function name!"
    exit 1
fi

aws lambda invoke \
    --function-name $LAMBDA_NAME \
    out \
    --log-type Tail \
    --query 'LogResult' \
    --output text | \
    base64 -d && \
    rm out
