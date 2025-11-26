# Distribution Registry Serverless

This is a simple example for hosting [CNCF Distribution Registry](https://distribution.github.io/distribution/) in read-only mode with AWS serverless architecture.

## Quick Start

Configure the login user:

```shell
htpasswd -bcB .htpasswd <username> <password>
```

Deploy AWS resources:

```shell
sam build
sam deploy
```

Push an example image via the local server:

```shell
export AWS_ACCOUNT_ID=$(aws sts get-caller-identity --query "Account" --output text)
aws configure export-credentials --format env-no-export > local.env
docker compose up -d
docker login localhost:5000 -u <username> -p <password>
docker pull alpine
docker tag alpine localhost:5000/alpine
docker push localhost:5000/alpine
docker compose down
```

Pull the example image from the serverless endpoint:

```shell
SERVER=$(aws cloudformation describe-stacks --stack-name distribution-registry --query "Stacks[0].Outputs[?OutputKey=='Server'].OutputValue" --output text)
docker login $SERVER -u <username> -p <password>
docker pull $SERVER/alpine
```
