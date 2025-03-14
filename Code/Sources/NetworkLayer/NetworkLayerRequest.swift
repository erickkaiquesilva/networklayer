import Foundation

final class NetworkLayerRequest: NetworkLayerRequestType {

    // MARK: - Private properties
    private let baseURL: String
    private let statusCode: ClosedRange<Int>
    private let urlSession: URLSession

    // MARK: Initializer
    init(
        baseURL: String,
        statusCode: ClosedRange<Int>,
        urlSession: URLSession = .shared
    ) {
        self.baseURL = baseURL
        self.statusCode = statusCode
        self.urlSession = urlSession
    }

    func request(
        service: NetworkLayerServiceType,
        completion: @escaping (Data?, URLResponse?, Error?) -> Void
    ) {
        
    }

    func request<T: Codable>(
        object: T.Type,
        service: any NetworkLayerServiceType,
        completion: @escaping (Result<T, any Error>) -> Void
    ) {
        
    }
}

private extension NetworkLayerRequest {

    func configUrlRequest(_ service: NetworkLayerServiceType) -> (URLRequest?, Error?) {
        let path: String = baseURL + service.path

        guard let url: URL = URL(string: path) else {
            return (nil, NetworkError.invalidURL)
        }

        var urlRequest: URLRequest = .init(url: url)

        urlRequest.httpMethod = service.httpMethod.rawValue

        if let header: [String: String] = service.header {
            header.forEach { value, key in
                urlRequest.setValue("\(key)", forHTTPHeaderField: value)
            }
        }

        if let body: Encodable = service.body {
            urlRequest.httpBody = try? JSONEncoder().encode(body)
        }

        return (urlRequest, nil)
    }
}
