import Foundation

protocol NetworkLayerRequestType {

    func request(
        serviceType: NetworkLayerServiceType,
        completion: @escaping (Data?, URLResponse?, Error?) -> Void
    )

    func request<T: Codable>(
        object: T.Type,
        service: NetworkLayerServiceType,
        completion: @escaping (Result<T, Error>) -> Void
    )
}
