import NetworkLayer

struct PostExampleService: NetworkLayerServiceType {

    var path: String {
        "/posts"
    }

    var httpMethod: HTTPMethod {
        .get
    }

    var header: [String : String]? {
        ["Content-Type": "application/json"]
    }

    var body: (any Encodable)? {
        nil
    }

    var cache: Bool {
        false
    }
}
