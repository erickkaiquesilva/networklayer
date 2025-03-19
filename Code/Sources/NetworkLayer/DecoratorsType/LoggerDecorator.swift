import Foundation

final class LoggerDecorator: NetworkLayerDecorator {

    // MARK: - Private properties
    private let handler: LoggerHandlerType

    // MARK: Initializer
    init(network: NetworkLayerRequestType, handler: LoggerHandlerType) {
        self.handler = handler
        super.init(network: network)
    }

    override func request(
        service: any NetworkLayerServiceType,
        completion: @escaping (Result<Data, Error>) -> Void
    ) {
        print(handler)
        super.request(service: service) { result in
            print(self.handler)
            self.handler.logRequest(service: service, result: result)
            print(result)
            completion(result)
        }
    }

    override func request<T: Codable>(
        object: T.Type,
        service: any NetworkLayerServiceType,
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        super.request(object: object, service: service) { [weak self] result in
            self?.handler.logRequest(service: service, result: result)
            completion(result)
        }
    }
}
