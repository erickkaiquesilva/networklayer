import Foundation

public protocol NetworkLayerRequestType {
    func request(
        serviceType: Test,
        completion: @escaping (Data?, URLResponse?, Error?) -> Void
    )
}
