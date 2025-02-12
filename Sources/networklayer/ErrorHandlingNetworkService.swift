import Foundation

final class ErrorHandlingNetworkService: NetworkServiceDecorator {
    private let errorMapper: NetworkErrorMapper

    init(decoratedService: NetworkService, errorMapper: NetworkErrorMapper) {
        self.errorMapper = errorMapper
        super.init(decoratedService: decoratedService)
    }

    override func request(serviceType: NetworkLayerServiceType, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        super.request(serviceType: serviceType) { data, response, error in
            if let httpResponse = response as? HTTPURLResponse, !(200...299).contains(httpResponse.statusCode) {
                let error = NetworkError.invalidStatusCode(httpResponse.statusCode)
                completion(nil, response, error)
            } else if let error = error {
                let mappedError = self.errorMapper.map(error: error)
                completion(nil, response, mappedError)
            } else if data == nil {
                completion(nil, response, NetworkError.noData)
            } else {
                completion(data, response, nil)
            }
        }
    
