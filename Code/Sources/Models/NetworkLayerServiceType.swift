public protocol NetworkLayerServiceType {

    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var header: [String: String]? { get }
    var body: Encodable? { get }
    var cache: Bool { get }
}

