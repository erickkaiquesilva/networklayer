import Foundation
import NetworkLayer

final class ExampleViewModel: ObservableObject {

    @Published var posts: [Post] = []
    @Published var errorMessage: ErrorMessage?

    // MARK: - Private properties
    private var networkLayer: NetworkLayer

    init() {
        networkLayer = NetworkLayer(baseUrl: "https://jsonplaceholder.typicode.com")
    }

    func fetchPosts() {
        let serviceType = PostExampleService()
        networkLayer.request(object: [Post].self, service: serviceType) { [weak self] result in
            switch result {
            case .success(let response):
                self?.posts = response
            case .failure(let failure):
                self?.errorMessage = ErrorMessage(message: failure.localizedDescription)
            }
        }
        
    }
}

