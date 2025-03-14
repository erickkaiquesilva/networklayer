public enum NetworkError: Error {
    case invalidURL
    case noData
    case failureSaveCache(String)
    case failureDecoderCache(String)
    case expiredCache(String)
    case invalidStatusCode(Int)
    case custom(Error)

    var localizedDescription: String {
        switch self {
        case .invalidURL:
            return "Invalid url."
        case .noData:
            return "No data"
        case .invalidStatusCode(let code):
            return "Status code invalid: \(code)."
        case .failureSaveCache(let path):
            return "Failed to save request cache: \(path)"
        case .failureDecoderCache(let path):
            return "Failed to try get request cache: \(path)"
        case .expiredCache(let path):
            return "Failed expired cache the service: \(path)"
        case .custom(let error):
            return error.localizedDescription
        }
    }
}
