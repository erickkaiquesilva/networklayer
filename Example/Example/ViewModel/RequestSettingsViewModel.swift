import Foundation
import NetworkLayer

final class RequestSettingsViewModel: ObservableObject {

    // MARK: - Published properties
    @Published var isLoading: Bool = false
    @Published var headers: [Header] = []
    @Published var selectedResponseType: ResponseType = .example
    @Published var selectedMethod: HTTPMethodType = .get
    @Published var errorMessage: String = ""
    @Published var showError: Bool = false
    @Published var showResult: Bool = false
    @Published var resultDto: ResponseViewDTO = .init()

    // MARK: - Private properties
    private var requestBodyEncodable: (any Encodable)? = nil
    private var baseUrl: String?
    private var pathUrl: String?

    // MARK: - Methods
    func addHeaderVaure(newHeaderKey: String, newHeaderValue: String) {
        headers.append(Header(key: newHeaderKey, value: newHeaderValue))
    }

    func deleteHeader(at offsets: IndexSet) {
        headers.remove(atOffsets: offsets)
    }

    func handlerFile(result: Result<[URL], any Error>) {
        switch result {
        case .success(let files):
            if let fileURL = files.first {
                do {
                    guard fileURL.startAccessingSecurityScopedResource() else {
                        errorMessage = "Não foi possível acessar o arquivo devido a permissões!"
                        showError = true
                        return
                    }

                    defer { fileURL.stopAccessingSecurityScopedResource() }

                    let data = try Data(contentsOf: fileURL)
                    if let jsonString = String(data: data, encoding: .utf8) {
                        transformerDataInEncodableObject(jsonString)
                    } else {
                        errorMessage = "Não foi possível converter o arquivo .json em string!"
                        showError = true
                    }
                } catch {
                    errorMessage = "Erro ao ler o arquivo: \(error.localizedDescription)"
                    print(errorMessage)
                    showError = true
                }
            }
        case .failure(let error):
            errorMessage = "Erro ao abrir o arquivo: \(error.localizedDescription)"
            showError = true
        }
    }

    func performRequest(baseUrl: String, pathUrl: String) {
        if !baseUrl.isEmpty && !pathUrl.isEmpty {
            isLoading = true
            self.baseUrl = baseUrl
            self.pathUrl = pathUrl
            let network: NetworkLayer = NetworkFactory.createNetwork(baseUrl: baseUrl, delegate: self)
//            network.setDelegate(delegate: self)
            let service: NetworkLayerServiceType = NetworkFactory.createServiceNetwork(
                path: pathUrl,
                method: selectedMethod,
                header: transformeHeader(),
                body: requestBodyEncodable
            )
            network.request(service: service) { [weak self] result in
                self?.isLoading = false
                switch result {
                case .success(let data):
                    if let result = String(data: data, encoding: .utf8) {
                        self?.createDTO(result)
                    }
                case .failure(let failure):
                    self?.errorMessage = failure.localizedDescription
                    self?.showError = true
                }
            }
        }
    }
}

private extension RequestSettingsViewModel {

    func createDTO(_ responseResult: String) {
        resultDto = ResponseViewDTO(
            baseUrl: baseUrl ?? "",
            servicePath: pathUrl ?? "",
            httpMethod: selectedMethod.rawValue.uppercased(),
            header: transformeHeader(),
            requestResult: responseResult
        )
        showResult = true
    }

    func transformerDataInEncodableObject(_ jsonString: String) {
        do {
            let trimmedBody = jsonString.trimmingCharacters(in: .whitespacesAndNewlines)

            guard let jsonData = trimmedBody.data(using: .utf8) else {
                errorMessage = "Não foi possível converter o body em dados UTF-8!"
                showError = true
                isLoading = false
                return
            }

            let jsonObject = try JSONSerialization.jsonObject(with: jsonData, options: [])

            if let jsonDict = jsonObject as? [String: Any] {
                requestBodyEncodable = AnyEncodable(value: jsonDict)
            } else if let jsonArray = jsonObject as? [Any] {
                requestBodyEncodable = AnyEncodableArray(value: jsonArray)
            } else {
                errorMessage = "O body deve ser um objeto JSON (ex.: {\"key\": \"value\"}) ou array (ex.: [\"value1\", \"value2\"])!"
                showError = true
                isLoading = false
                return
            }
        } catch {
            errorMessage = "Erro ao processar o body: \(error.localizedDescription)\nVerifique se o arquivo .json está correto."
            showError = true
            isLoading = false
            return
        }
    }

    func transformeHeader() -> [String: String]? {
        if !headers.isEmpty {
            let header: [String: String] = Dictionary(
                uniqueKeysWithValues: headers.compactMap { ($0.key, $0.value)
                })
            return header
        }
        return nil
    }
}

extension RequestSettingsViewModel: NetworkLayerDelegate {
    func authenticate(completion: @escaping () -> Void?) {
        
    }
    
    func loggerNetwork(log: LoggerResponse) {
        print(log)
    }
}
