import Foundation

final class NetworkLayerRequest: NetworkLayerRequestType {

    // MARK: - Private properties
    private let baseURL: String
    private let statusCode: ClosedRange<Int>
    private let urlSession: URLSession

    // MARK: Initializer
    init(
        baseURL: String,
        statusCode: ClosedRange<Int> = 200...299,
        urlSession: URLSession = .shared
    ) {
        self.baseURL = baseURL
        self.statusCode = statusCode
        self.urlSession = urlSession
    }

    func request(
        service: NetworkLayerServiceType,
        completion: @escaping (Result<Data, Error>) -> Void
    ) {
        let result: (urlRequest: URLRequest?, err: Error?) = configUrlRequest(service)

        if let err = result.err {
            completion(.failure(err))
        }

        if let urlRequest = result.urlRequest {
            let task = urlSession.dataTask(with: urlRequest) { data, response, err in
                DispatchQueue.global().async {
                    if let data = data {
                        DispatchQueue.main.async {
                            completion(.success(data))
                        }
                        return
                    }

                    if let err = err {
                        DispatchQueue.main.async {
                            completion(.failure(err))
                        }
                        return
                    }
                }
            }
            task.resume()
        }
    }

    func request<T: Codable>(
        object: T.Type,
        service: any NetworkLayerServiceType,
        completion: @escaping (Result<T, any Error>) -> Void
    ) {
        let result: (urlRequest: URLRequest?, err: Error?) = configUrlRequest(service)

        if let err = result.err {
            completion(.failure(err))
        }

        if let urlRequest = result.urlRequest {
            let task = urlSession.dataTask(with: urlRequest) { data, urlResponse, err in
                DispatchQueue.global().async {
                    let result: (response: T?, error: (Error)?) = self.validateUrlSession(
                        (data, urlResponse, err),
                        type: T.self
                    )

                    if let err: Error = result.error {
                        DispatchQueue.main.async {
                            completion(.failure(err))
                        }
                        return
                    }

                    if let response: T = result.response {
                        DispatchQueue.main.async {
                            completion(.success(response))
                        }
                    }
                }
            }
            task.resume()
        }
    }
}

private extension NetworkLayerRequest {

    func configUrlRequest(_ service: NetworkLayerServiceType) -> (URLRequest?, Error?) {
        let path: String = baseURL + service.path

        guard let url: URL = URL(string: path) else {
            return (nil, NetworkError.invalidURL)
        }

        var urlRequest: URLRequest = .init(url: url)

        urlRequest.httpMethod = service.httpMethod.rawValue

        if let header: [String: String] = service.header {
            header.forEach { value, key in
                urlRequest.setValue("\(key)", forHTTPHeaderField: value)
            }
        }

        if let body: Encodable = service.body {
            urlRequest.httpBody = try? JSONEncoder().encode(body)
        }

        return (urlRequest, nil)
    }

    func validateUrlSession<T: Codable>(
        _ session: (data: Data?, response: URLResponse?, err: Error?),
        type: T.Type
    ) -> (T?, Error?) {

        guard let httpResponse = session.response as? HTTPURLResponse else {
            return (nil, NetworkError.requestFailed(description: session.err?.localizedDescription ?? "No description"))
        }

        if !self.statusCode.contains(httpResponse.statusCode) {
            return (nil, NetworkError.responseUnsuccessful(description: "\(httpResponse.statusCode)"))
        }

        guard let data = session.data else {
            return (nil, NetworkError.noData)
        }

        guard let model: T = self.decodingTask(data: data, to: T.self) else {
            return (nil, NetworkError.jsonConversionFailure(description: "Error Parcial"))
        }

        return (model, nil)
    }

    func decodingTask<T: Decodable>(data: Data, to type: T.Type) -> T? {
        do {
            let genericModel = try JSONDecoder().decode(T.self, from: data)
            return genericModel
        } catch let err {
            print(err.localizedDescription)
            return nil
        }
    }
}
