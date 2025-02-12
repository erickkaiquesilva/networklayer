import Foundation

public protocol NetworkLayerRequestType {
    func request(
        serviceType: NetworkLayerServiceType,
        completion: @escaping (Data?, URLResponse?, Error?) -> Void
    )
}
