$(aws ecr get-login --no-include-email --profile $AWS_PROFILE)
docker build -t $AWS_ID.dkr.ecr.$AWS_REGION.amazonaws.com/tilloo:5 .
docker push $AWS_ID.dkr.ecr.$AWS_REGION.amazonaws.com/tilloo:5
