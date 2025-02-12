import Foundation

final class NetworkLayer: NetworkLayerType {
    // MARK: - Private properties
    private let baseURL: URL

    // MARK: - Initializer
    init(baseURL: URL) {
        self.baseURL = baseURL
    }

    // MARK: - Method protocol
    func request(
        serviceType: NetworkLayerServiceType,
        completion: @escaping (Data?, URLResponse?, (any Error)?) -> Void
    ) {
        guard let url = URL(string: serviceType.path, relativeTo: baseURL) else {
            completion(nil, nil, NSError(domain: "Invalid URL", code: 0, userInfo: nil))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = serviceType.httpMethod.rawValue
        request.allHTTPHeaderFields = serviceType.header
        
        if let body = serviceType.body {
            request.httpBody = try? JSONEncoder().encode(body)
        }
        
        let task = URLSession.shared.dataTask(with: request, completionHandler: completion)
        task.resume()
    }
}
