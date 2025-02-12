import Foundation

final class CachingNetworkService: NetworkServiceDecorator {

    // MARK: - Private properties
    private var cache: [URL: Data] = [:]

    // MARK: - Override functions
    override func request(url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        if let cachedData = cache[url] {
            print("Returning cached data for URL: \(url)")
            completion(cachedData, nil, nil)
        } else {
            super.request(url: url) { data, response, error in
                if let data = data {
                    self.cache[url] = data
                }
                completion(data, response, error)
            }
        }
    }
}
