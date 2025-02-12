import Foundation

final class LoggingNetworkService: NetworkServiceDecorator {

    // MARK: - Override functions
    override func request(
        serviceType: NetworkLayerServiceType,
        completion: @escaping (Data?, URLResponse?, (any Error)?) -> Void
    ) {
        super.request(serviceType: serviceType) { data, response, error in
            if let error = error {
                print("Error: \(error)")
            } else {
                print("Response: \(response!)")
            }
            completion(data, response, error)
        }
    }
}
