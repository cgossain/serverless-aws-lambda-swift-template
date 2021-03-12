import AWSLambdaRuntime
import AWSLambdaEvents

Lambda.run { (_, request: APIGateway.V2.Request, callback: @escaping (Result<APIGateway.V2.Response, Error>) -> Void) in
    callback(.success(APIGateway.V2.Response(statusCode: .ok, body: "Running my second lambda function, from Swift!")))
}
