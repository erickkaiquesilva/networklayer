import Foundation

final class LoggerDecorator: NetworkLayerDecoratorType {

    // MARK: - Public properties
    var network: NetworkLayerRequestType

    // MARK: - Private properties
    private let handler: LoggerHandlerType

    // MARK: Initializer
    init(network: NetworkLayerRequestType, handler: LoggerHandlerType = LoggerHandler()) {
        self.network = network
        self.handler = handler
    }

    func request(
        service: any NetworkLayerServiceType,
        completion: @escaping (Result<Data, Error>) -> Void
    ) {
        network.request(service: service) { [weak self] result in
            self?.handler.logRequest(service: service, result: result)
            completion(result)
        }
    }

    func request<T: Codable>(
        object: T.Type,
        service: any NetworkLayerServiceType,
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        network.request(object: object, service: service) { [weak self] result in
            self?.handler.logRequest(service: service, result: result)
            completion(result)
        }
    }
}
