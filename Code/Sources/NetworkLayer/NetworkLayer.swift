import Foundation

public protocol NetworkLayerType {

    func setDelegate(delegate: NetworkLayerDelegate)
    func configDecorators(handlers: [NetworkHandler])
    func request(
        service: NetworkLayerServiceType,
        completion: @escaping (Result<Data, Error>) -> Void
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
    private var loggerHandler: LoggerHandler
    private weak var delegate: NetworkLayerDelegate?

    // MARK: - Initializer
    public init(
        urlSession: URLSession = .shared,
        baseUrl: String,
        delegate: NetworkLayerDelegate?
    ) {
        self.network = NetworkLayerRequest(baseURL: baseUrl, urlSession: urlSession)
        self.loggerHandler = LoggerHandler(delegate: delegate)
    }

    // MARK: - Private functions
    private func createDecoratorNetwork() -> NetworkLayerRequestType {
        var current: NetworkLayerRequestType = network
        current = LoggerDecorator(network: current, handler: loggerHandler)

        return current
    }
}
// MARK: - NetworkLayerRequestType
extension NetworkLayer: NetworkLayerType {

    public func setDelegate(delegate: any NetworkLayerDelegate) {
        loggerHandler.delegate = delegate
    }

    public func configDecorators(handlers: [any NetworkHandler]) {
        
    }

    public func request(
        service: NetworkLayerServiceType,
        completion: @escaping (Result<Data, Error>) -> Void
    ) {
        let network = createDecoratorNetwork()
        network.request(service: service, completion: completion)
    }

    public func request<T: Codable>(
        object: T.Type,
        service: any NetworkLayerServiceType,
        completion: @escaping (Result<T, any Error>) -> Void
    ) {
        let network: NetworkLayerRequestType = createDecoratorNetwork()
        network.request(object: object, service: service, completion: completion)
    }
}
