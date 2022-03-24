#!/bin/bash

IMAGE_NAME=${1:-"--help"}
REPOSITORY_URI=$2
LAMBDA_NAME=$3
LAMBDA_ROLE=$4

if [[ $IMAGE_NAME == "-h" || $IMAGE_NAME == "--help" ]]; then 
    echo "Exemple usage:"
    echo "  ./deploy <image-name> <repo-uri> <lambda-name> <lambda-role>"
    exit 0
fi

if [ -z $IMAGE_NAME ]; then
    echo "Missing image name!"
    exit 1
fi

if [ -z $REPOSITORY_URI ]; then
    echo "Missing repository URI!"
    exit 1
fi

if [ -z $LAMBDA_NAME ]; then
    echo "Missing lambda function name!"
    exit 1
fi

if [ -z $LAMBDA_ROLE ]; then
    echo "Missing lambda role!"
    exit 1
fi

IMAGE_TAG="$IMAGE_NAME:latest"
IMAGE_URI="$REPOSITORY_URI:latest"

echo "--> Build docker image"
docker image build -t $IMAGE_TAG .

echo "--> Tag built image with the ECR repository"
docker image tag $IMAGE_TAG $IMAGE_URI

echo "--> Authenticate on ECR"
docker login --username AWS -p $(aws ecr get-login-password) $REPOSITORY_URI

echo "--> Pushing image!"
docker image push $IMAGE_URI

echo "--> Try to create lambda function"
aws lambda create-function \
    --function-name $LAMBDA_NAME \
    --role $LAMBDA_ROLE \
    --code ImageUri=$IMAGE_URI \
    --package-type Image \
    2>/dev/null

if [ ! $? -eq 0 ]; then
    echo "--> Lambda function already exists! Update instead"
    aws lambda update-function-code \
        --function-name $LAMBDA_NAME \
        --image-uri $IMAGE_URI \
        2>/dev/null
fi

if [ $? -eq 0 ]; then
    echo "Lambda runtime with Python and Java created!!!"
else
    echo "Oh no, something went wrong!"
    exit 1
fi
