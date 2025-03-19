public enum NetworkError: Error {
    case invalidURL
    case noData
    case failureSaveCache(String)
    case failureDecoderCache(String)
    case expiredCache(String)
    case invalidStatusCode(Int)
    case jsonDecodingFailure
    case responseUnsuccessful(description: String)
    case decodingTaskFailure(description: String)
    case requestFailed(description: String)
    case jsonConversionFailure(description: String)
    case postParametersEncodingFailure(description: String)
    case unsupportedVersion(description: String)
    case custom(Error)

    var localizedDescription: String {
        switch self {
        case .invalidURL: return "Invalid url."
        case .noData: return "No data"
        case .invalidStatusCode(let code): return "Status code invalid: \(code)."
        case .failureSaveCache(let path): return "Failed to save request cache: \(path)"
        case .failureDecoderCache(let path): return "Failed to try get request cache: \(path)"
        case .expiredCache(let path): return "Failed expired cache the service: \(path)"
        case .jsonDecodingFailure: return "NetworkError - JSON decoding Failure"
        case .responseUnsuccessful(description: let description): return "APIError - Response Unsuccessful status code -> \(description)"
        case .decodingTaskFailure(description: let description): return "NetworkError - decodingtask failure with error -> \(description)"
        case .requestFailed(description: let description): return "NetworkError - Request Failed -> \(description)"
        case .jsonConversionFailure(description: let description): return "NetworkError - JSON Conversion Failure -> \(description)"
        case .postParametersEncodingFailure(description: let description): return "NetworkError - post parameters failure -> \(description)"
        case .unsupportedVersion(description: let description): return "NetworkLayer is not suported async await -> \(description)"
        case .custom(let error): return error.localizedDescription
        }
    }
}
