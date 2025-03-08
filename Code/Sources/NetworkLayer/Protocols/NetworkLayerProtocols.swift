import Foundation

public protocol NetworkHandler {

    var delegate: NetworkLayerDelegate? { get set }
}

public protocol NetworkLayerDecoratorType: NetworkLayerRequestType {

    var network: NetworkLayerRequestType { get set }
}

public protocol NetworkLayerRequestType {

    func request(
        service: NetworkLayerServiceType,
        completion: @escaping (Data?, URLResponse?, Error?) -> Void
    )

    func request<T: Codable>(
        object: T.Type,
        service: NetworkLayerServiceType,
        completion: @escaping (Result<T, Error>) -> Void
    )
}

public protocol NetworkLayerDelegate: AnyObject {

    func authenticate(completion: @escaping () -> Void?)
}
