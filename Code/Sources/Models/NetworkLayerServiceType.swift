public protocol NetworkLayerServiceType {

    public let path: String { get set }
    public let httpMethod: HTTPMethod { get set }
    public let header: [String: String]? { get set }
    public let body: Encodable? { get set }
    public let cache: Bool { get set }
}

