import Foundation

final class LoggingNetworkService: NetworkServiceDecorator {

    // MARK: - Override functions
    override func request(url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        print("Requesting URL: \(url)")
        super.request(url: url) { data, response, error in
            if let error = error {
                print("Error: \(error)")
            } else {
                print("Response: \(response!)")
            }
            completion(data, response, error)
        }
    }
}
