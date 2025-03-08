import Foundation
import NetworkLayer

final class ExampleViewModel: ObservableObject {

    @Published var posts: [Post] = []
    @Published var errorMessage: ErrorMessage?

//    private var networkLayer: NetworkLayer
//
//    init() {
//        let baseURL = URL(string: "https://jsonplaceholder.typicode.com")!
//        networkLayer = NetworkLayer(baseURL: baseURL, useLogging: true, useCaching: false, useErrorHandling: true)
//        fetchPosts()
//    }
//
//    func fetchPosts() {
//        let serviceType = PostExampleService()
//
//        networkLayer.request(serviceType: serviceType) { [weak self] data, response, error in
//            if let error = error {
//                DispatchQueue.main.async {
//                    print("Error: \(error.localizedDescription)")
//                    self?.errorMessage = .init(message: "Error: \(error.localizedDescription)")
//                }
//                return
//            }
//
//            if let data = data {
//                do {
//                    let posts = try JSONDecoder().decode([Post].self, from: data)
//                    DispatchQueue.main.async {
//                        print(posts)
//                        self?.posts = posts
//                    }
//                } catch {
//                    DispatchQueue.main.async {
//                        print("Failed to decode response: \(error.localizedDescription)")
//                        self?.errorMessage = .init(message: "Failed to decode response: \(error.localizedDescription)")
//                    }
//                }
//            }
//        }
//    }
}

