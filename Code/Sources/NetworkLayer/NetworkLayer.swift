import Foundation

final class NetworkLayer {

    // MARK: - Private properties
    private let network: NetworkLayerRequestType
    private let authHandler: AuthHandler?
    private let logHandler: LoggerHandler?
    private let cacheHandler: CacheHandler?

    // MARK: - Initializer
    init(
        network: NetworkLayerRequestType,
        authHandler: AuthHandler,
        logHandler: LoggerHandler,
        cacheHandler: CacheHandler
    ) {
        self.network = network
        self.authHandler = authHandler
        self.logHandler = logHandler
        self.cacheHandler = cacheHandler
    }

    // MARK: - Private functions
    private func createDecoratorNetwork() -> NetworkLayerRequestType {
        var current: NetworkLayerRequestType = network

        if let auth = authHandler {
            current = AuthDecorator(network: current, authHandler: auth)
        }

        if let cache = cacheHandler {
            
        }

        return current
    }
}
// MARK: - NetworkLayerRequestType
extension NetworkLayer: NetworkLayerRequestType {
    func request(
        service: any NetworkLayerServiceType,
        completion: @escaping (Data?, URLResponse?, (any Error)?) -> Void
    ) {
        
    }

    func request<T: Codable>(
        object: T.Type,
        service: any NetworkLayerServiceType,
        completion: @escaping (Result<T, any Error>) -> Void
    ) {
        
    }
}
