public enum NetworkError: Error {
    case invalidURL
    case noData
    case failureSaveCache(String)
    case failureDecoderCache(String)
    case expiredCache(String)
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
        case .failureSaveCache(let path):
            return "Falha ao tentar salvar cache da request: \(path)"
        case .failureDecoderCache(let path):
            return "Falha ao tentar decodar o cache da request: \(path)"
        case .expiredCache(let path):
            return "Cache expirado, serviço: \(path)"
        case .custom(let error):
            return error.localizedDescription
        }
    }
}
