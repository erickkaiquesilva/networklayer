import Foundation

class NetworkServiceDecorator: NetworkLayerType {

    // MARK: - Private properties
    private let decoratedService: NetworkLayerService

    // MARK: - Initializer
    init(decoratedService: NetworkLayerService) {
        self.decoratedService = decoratedService
    }

    // MARK: - Methods Protocol
    func request(url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        decoratedService.request(url: url, completion: completion)
    }
}
