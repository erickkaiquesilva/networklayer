import Foundation

class NetworkDecoratorAbstract: NetworkLayerRequestType {

    // MARK: - Private properties
    private let decoratedService: NetworkLayerRequestType

    // MARK: - Initializer
    init(decoratedService: NetworkLayerRequestType) {
        self.decoratedService = decoratedService
    }

    // MARK: - Methods Protocol
    func request(serviceType: NetworkLayerServiceType, completion: @escaping (Data?, URLResponse?, (any Error)?) -> Void) {
        request(serviceType: serviceType, completion: completion)
    }
}

