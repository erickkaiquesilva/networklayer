import Foundation

public protocol NetworkLayerType {

    func configDecorators(handlers: [NetworkHandler])
    func request(
        service: any NetworkLayerServiceType,
        completion: @escaping (Data?, URLResponse?, (any Error)?) -> Void
    )
    
    func request<T: Codable>(
        object: T.Type,
        service: any NetworkLayerServiceType,
        completion: @escaping (Result<T, any Error>) -> Void
    )
}

public final class NetworkLayer {

    // MARK: - Private properties
    private let network: NetworkLayerRequestType

    // MARK: - Initializer
    public init(
        urlSession: URLSession = .shared,
        baseUrl: String
    ) {
        self.network = NetworkLayerRequest(baseURL: baseUrl, urlSession: urlSession)
    }

    // MARK: - Private functions
    private func createDecoratorNetwork() -> NetworkLayerRequestType {
        var current: NetworkLayerRequestType = network

        return current
    }
}
// MARK: - NetworkLayerRequestType
extension NetworkLayer: NetworkLayerType {

    public func configDecorators(handlers: [any NetworkHandler]) {
        
    }

    public func request(
        service: any NetworkLayerServiceType,
        completion: @escaping (Data?, URLResponse?, (any Error)?) -> Void
    ) { }

    public func request<T: Codable>(
        object: T.Type,
        service: any NetworkLayerServiceType,
        completion: @escaping (Result<T, any Error>) -> Void
    ) {
        let network: NetworkLayerRequestType = createDecoratorNetwork()
        network.request(object: object, service: service, completion: completion)
    }
}
