import Foundation
import NetworkLayer

final class ExampleViewModel: ObservableObject {

    // MARK: - Published properties
    @Published var isLoading: Bool = false
    @Published var headers: [Header] = []
    @Published var selectedResponseType: ResponseType = .example
    @Published var selectedMethod: HTTPMethodType = .get
    @Published var errorMessage: String = ""
    @Published var showError: Bool = false

    func addHeaderVaure(newHeaderKey: String, newHeaderValue: String) {
        headers.append(Header(key: newHeaderKey, value: newHeaderValue))
    }

    func deleteHeader(at offsets: IndexSet) {
        headers.remove(atOffsets: offsets)
    }

    func performRequest(urlString: String, bodyRequest: String) {
        if urlString.isEmpty {
            showError = true
            errorMessage = "Alert... service path required."
            return
        }
        let body = bodyRequest.data(using: .utf8)
        print(body)
    }
}

