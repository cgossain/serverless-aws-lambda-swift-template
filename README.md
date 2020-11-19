# Serverless AWS Lambda Swift Project Template

This template project is designed to be used as a starting point for an AWS Lambda and API Gateway project using the new Swift AWS Lambda Runtime and the Serverless Framework.

## Requirements

- Install [Docker](https://docs.docker.com/install/)
- Install [Serverless Framework](https://www.serverless.com/framework/docs/getting-started/)
- Ensure your AWS Account has the right [credentials](https://www.serverless.com/framework/docs/providers/aws/guide/credentials/) to deploy a Serverless stack
- You should be familiar with using the [Serverless Framework](<(https://www.serverless.com/framework/docs/getting-started/)>)

## Future enhancements

- Improve the included scripts to enable deploying and removing functions individually
- Better integration with the `serverless create` command to automatically perform the template configuration steps described in this document

## Project structure

Each Lambda function in this template is configured as a separate target/executable in `Package.swift`.

The `serverless.yml` file manually maps each function to the underlying code using the `artifact` attribute to point to a zip file containing the function executable and any associated dependencies.

**Note: The zip file is packaged as one of the steps in the `build-and-packaged.sh` script which is called by the `serverless-deploy.sh` script.**

## Usage

Create a new service for each logical microservice you intend to deploy.

Each microservice could be made up of a single or several Lamda functions.

### Create a new service

Use the `serverless create` command to download the template into a new project folder:

```
serverless create --template-url https://github.com/cgossain/serverless-aws-lambda-swift-template.git --path my-new-service
```

### Configure the template

1. Open `Package.swift`:

```
cd my-new-service && open Package.swift
```

2. Change the package name, and replace the template executable products and targets with your first function:

<pre>
// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    <b>name: "MyPackageName"</b>,
    platforms: [
        .macOS(.v10_13),
    ],
    products: [
        <b>.executable(name: "MyFunctionName", targets: ["MyFunctionName"])</b>,
        ...
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(url: "https://github.com/swift-server/swift-aws-lambda-runtime.git", .upToNextMajor(from:"0.2.0")),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        <b>
        .target(
            name: "MyFunctionName",
            dependencies: [
                .product(name: "AWSLambdaRuntime", package: "swift-aws-lambda-runtime"),
                .product(name: "AWSLambdaEvents", package: "swift-aws-lambda-runtime"),
            ]
        ),
        </b>
        ...
    ]
)
</pre>

3. Replace the contents of the Source folder with a folder that matches each target named in the `Package.swift` file. Each folder should its own `main.swift` file.

<pre>
.
├── ...
├── Sources
│   └── <b>MyFunctionName</b>
│       └── main.swift
│   └── ...
├── ...
</pre>

4. Open `serverless.yml`, update the general parameters if needed (i.e. service name, provider details, etc.), then finally update the `functions` section to match the targets specified in the `Package.swift`:

<pre>
...

functions:
  <b>myFunctionName:</b>
    handler: <b>MyFunctionName</b>
    package:
      individually: true
      artifact: .build/lambda/<b>MyFunctionName</b>/<b>MyFunctionName</b>.zip
    memorySize: 128
    events:
      - httpApi:
          method: GET
          path: /path/to/api

...
</pre>

Pay attention to the file path of the artifact zip file. You'll want to update both the folder and zip file name to match the name of the executable in `Package.swift`.

**Note: Unlike other Serverless Framework projects the handler name within the function definition is not actually useful, however it's still required by AWS. Therefore for consistency you can also just use the same name as the executable from `Package.swift`.**

## Local testing

To test your Lambda locally, in Xcode open the _Edit Scheme_ menu for your function target and add the environment variable `LOCAL_LAMBDA_SERVER_ENABLED=true` to your Run settings.

## Deploy

Run the following command from the root folder to build and deploy all functions:

```
./scripts/serverless-deploy.sh
```

## Remove Deployment

Run the following command from the root folder to remove the deployment of all functions:

```
./scripts/serverless-remove.sh
```

## Credits and references

This template is a modified version of the example project(s) included in the [Swift AWS Lambda Runtime](https://github.com/swift-server/swift-aws-lambda-runtime) repositiory.

**Note: The scripts have been modified to deploy all functions in the project and to use a single `serverless.yml` file.**

1. [Swift AWS Lambda Runtime](https://github.com/swift-server/swift-aws-lambda-runtime)
2. [Getting started with Swift on AWS Lambda](https://fabianfett.de/getting-started-with-swift-aws-lambda-runtime)
3. [AWS Serverless Swift API Template](https://github.com/swift-sprinter/aws-serverless-swift-api-template)
4. [Serverless YML Reference](https://www.serverless.com/framework/docs/providers/aws/guide/serverless.yml/)
