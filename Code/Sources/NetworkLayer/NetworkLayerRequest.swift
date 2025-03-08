import Foundation

final class NetworkLayerRequest: NetworkLayerRequestType {

    // MARK: - Private properties
    private let baseURL: URL
    private let statusCode: ClosedRange<Int>
    private let urlSession: URLSession

    // MARK: Initializer
    init(
        baseURL: URL,
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
    
}
