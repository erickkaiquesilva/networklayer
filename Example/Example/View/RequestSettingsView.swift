import SwiftUI
import UniformTypeIdentifiers

struct RequestSettingsView: View {

    // MARK: - Private properties
    @StateObject private var viewModel: RequestSettingsViewModel
    @State private var baseUrl: String = ""
    @State private var pathUrl: String = ""
    @State private var newHeaderKey: String = ""
    @State private var newHeaderValue: String = ""
    @State private var customJson: String = ""
    @State private var showFileImporter: Bool = false

    // MARK: - Initializer
    init(viewModel: RequestSettingsViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    // MARK: - View
    var body: some View {
        NavigationView {
            VStack(spacing: 24) {
                baseUrlInformationView
                httpMethodView
                addHeadersView
                if viewModel.selectedMethod == .post || viewModel.selectedMethod == .put {
                    mappingBodyView
                }
                sendRequestButton
                Spacer()
            }
        }
        .padding()
        .navigationTitle("Network Test")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    
                }) {
                    Image(systemName: "square.and.arrow.down")
                        .foregroundColor(.orange)
                }
            }
        }
        .alert(isPresented: $viewModel.showError) {
            Alert(
                title: Text("Error"),
                message: Text(viewModel.errorMessage),
                dismissButton: .default(Text("OK")) {
                    viewModel.showError = false
                }
            )
        }
        .sheet(isPresented: $viewModel.showResult) {
            ResponseView(dto: viewModel.resultDto)
        }
        .onTapGesture {
            dismissKeyboard()
        }
    }

    // MARK: - UIComponents
    private var baseUrlInformationView: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Setting netwrok")
                .font(.headline)

            TextField("Base URL", text: $baseUrl)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.URL)
                .autocapitalization(.none)
                .disableAutocorrection(true)

            TextField("Path service", text: $pathUrl)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.URL)
                .autocapitalization(.none)
                .disableAutocorrection(true)
        }
    }

    private var httpMethodView: some View {
        VStack(alignment: .leading) {
            Text("Selected Http method")
                .font(.headline)
            Picker("HTTP Method", selection: $viewModel.selectedMethod) {
                ForEach(HTTPMethodType.allCases) { method in
                    Text(method.rawValue).tag(method)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
        }
    }

    private var addHeadersView: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Headers")
                .font(.headline)

            HStack {
                TextField("Key", text: $newHeaderKey)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                TextField("Value", text: $newHeaderValue)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Button(action: {
                    if !newHeaderKey.isEmpty && !newHeaderValue.isEmpty {
                        viewModel.addHeaderVaure(newHeaderKey: newHeaderKey, newHeaderValue: newHeaderValue)
                        newHeaderKey = ""
                        newHeaderValue = ""
                    }
                }) {
                    Image(systemName: "plus.circle.fill")
                        .foregroundColor(.green)
                }
            }

            if !viewModel.headers.isEmpty {
                List {
                    ForEach(viewModel.headers) { header in
                        HStack {
                            Text("\(header.key): \(header.value)")
                            Spacer()
                        }
                    }
                    .onDelete(perform: viewModel.deleteHeader)
                }
                .frame(maxHeight: 150)
            }
        }
    }

    private var mappingBodyView: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Mapping body request")
                .font(.headline)

            Button(action: {
                showFileImporter = true
            }) {
                Text(customJson.isEmpty ? "Selecionar arquivo .json" : "Arquivo carregado (\(customJson.count) caracteres)")
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.green)
                    .cornerRadius(8)
            }
        }
        .padding()
        .fileImporter(
            isPresented: $showFileImporter,
            allowedContentTypes: [.json],
            allowsMultipleSelection: false
        ) { result in viewModel.handlerFile(result: result) }
    }

    private var sendRequestButton: some View {
        Button(action: {
            viewModel.performRequest(baseUrl: baseUrl, pathUrl: pathUrl)
        }) {
            Text(viewModel.isLoading ? "Loading..." : "Send Request")
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity)
                .background(viewModel.isLoading ? Color.gray : Color.blue)
                .cornerRadius(8)
        }
        .disabled(viewModel.isLoading)
        .padding()
    }

    // MARK: - Private methods
    private func dismissKeyboard() {
        UIApplication.shared.sendAction(
            #selector(UIResponder.resignFirstResponder),
            to: nil,
            from: nil,
            for: nil
        )
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView(viewModel: ExampleViewModel())
//    }
//}
