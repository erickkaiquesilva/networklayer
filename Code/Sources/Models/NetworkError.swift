enum NetworkError: Error {
    case invalidURL
    case noData
    case invalidStatusCode(Int)
    case custom(Error)

    var localizedDescription: String {
        switch self {
        case .invalidURL:
            return "URL inválida."
        case .noData:
            return "Nenhum dado recebido."
        case .invalidStatusCode(let code):
            return "Código de status inválido: \(code)."
        case .custom(let error):
            return error.localizedDescription
        }
    }
}
