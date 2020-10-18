# Swift AWS Lambda Project Template

This template project is designed to be used as a starting point for an AWS Lambda and API Gateway project using the new Swift AWS Lambda Runtime and the Serverless Framework.

## Requirements

- Install [Docker](https://docs.docker.com/install/)
- Install [Serverless Framework](https://www.serverless.com/framework/docs/getting-started/)
- Ensure your AWS Account has the right [credentials](https://www.serverless.com/framework/docs/providers/aws/guide/credentials/) to deploy a Serverless stack.

## Create a new service

```
serverless create --template-url https://github.com/cgossain/swift-aws-lambda-project-template --path my-new-service
```

## Deploy

Run the following command from the root folder to build and deploy all functions:

```
./scripts/serverless-deploy.sh
```

## Future enhancements

- Improve scripts to allow deploying or removing a single funtion

## Credits and references

1. [Swift AWS Lambda Runtime](https://github.com/swift-server/swift-aws-lambda-runtime)
2. [Getting started with Swift on AWS Lambda](https://fabianfett.de/getting-started-with-swift-aws-lambda-runtime)
3. [AWS Swift Serverless API Template](https://github.com/swift-sprinter/aws-serverless-swift-api-template)
4. [Serverless YML Reference](https://www.serverless.com/framework/docs/providers/aws/guide/serverless.yml/)
