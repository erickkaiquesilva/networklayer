import Foundation

class NetworkLayerDecorator: NetworkLayerRequestType {

    // MARK: - Private properties
    private let network: NetworkLayerRequestType

    // MARK: - Initializer
    init(network: NetworkLayerRequestType) {
        self.network = network
    }

    func request(
        service: any NetworkLayerServiceType,
        completion: @escaping (Data?, URLResponse?, (any Error)?) -> Void
    ) {
        network.request(service: service, completion: completion)
    }

    func request<T: Codable>(
        object: T.Type,
        service: any NetworkLayerServiceType,
        completion: @escaping (Result<T, any Error>) -> Void
    ) {
        network.request(object: object, service: service, completion: completion)
    }
}

