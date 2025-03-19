import Foundation

@testable import NetworkLayer

final class NetworkLayerRequestSpy: NetworkLayerRequestType {

    // MARK: Propertie General
    private let resultFailure: Error = NSError(domain: "com.example.test", code: -1, userInfo: [
        NSLocalizedDescriptionKey: "Erro simulado para teste"
    ])

    private(set) var requestWithDataResultCount: Int = 0
    private(set) var requestServiceWithDataResult: (any NetworkLayerServiceType)?

    func request(
        service: any NetworkLayerServiceType,
        completion: @escaping (Result<Data, any Error>) -> Void
    ) {
        requestWithDataResultCount += 1
        requestServiceWithDataResult = service
        completion(.failure(resultFailure))
    }

    private(set) var requestWithCodableResultCount: Int = 0
    private(set) var requestServiceWithCodableResult: (any NetworkLayerServiceType)?

    func request<T: Codable>(
        object: T.Type,
        service: any NetworkLayerServiceType,
        completion: @escaping (Result<T, any Error>) -> Void
    ) {
        requestWithCodableResultCount += 1
        requestServiceWithCodableResult = service
        completion(.failure(resultFailure))
    }
}
