struct NetworkLayerServiceType {

    let path: String
    let httpMethod: HTTPMethod
    let header: [String: String]?
    let body: Encodable?
    let cash: Bool?
}
