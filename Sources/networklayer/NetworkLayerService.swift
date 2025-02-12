import Foundation

protocol NetworkLayerType {
    func request(
        serviceType: NetworkLayerServiceType,
        completion: @escaping (Data?, URLResponse?, Error?) -> Void
    )
}
