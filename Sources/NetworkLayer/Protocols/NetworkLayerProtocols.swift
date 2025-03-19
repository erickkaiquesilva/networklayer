import Foundation

public protocol NetworkHandler {

    var delegate: NetworkLayerDelegate? { get set }
}

protocol NetworkLayerDecoratorType: NetworkLayerRequestType {

    var network: NetworkLayerRequestType { get set }
}

protocol NetworkLayerRequestType {

    func request(
        service: NetworkLayerServiceType,
        completion: @escaping (Result<Data, Error>) -> Void
    )

    func request<T: Codable>(
        object: T.Type,
        service: NetworkLayerServiceType,
        completion: @escaping (Result<T, Error>) -> Void
    )
}

public protocol NetworkLayerDelegate: AnyObject {

    func authenticate(completion: @escaping () -> Void?)
    func loggerNetwork(log: LoggerResponse)
}
