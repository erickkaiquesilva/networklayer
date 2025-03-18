import SwiftUI

struct ContentView: View {

    // MARK: - Private properties
    @StateObject private var viewModel: ExampleViewModel
    @State private var urlString: String = ""
    @State private var newHeaderKey: String = ""
    @State private var newHeaderValue: String = ""
    @State private var customJson: String = ""

    // MARK: - Initializer
    init(viewModel: ExampleViewModel) {
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
            EditButton()
        }
        .alert(isPresented: $viewModel.showError) {
            Alert(
                title: Text("Error"),
                message: Text(viewModel.errorMessage),
                dismissButton: .default(Text("OK")) {
                    viewModel.showError = false // Reseta o estado ao fechar
                }
            )
        }
    }

    private var baseUrlInformationView: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Setting netwrok")
                .font(.headline)

            TextField("Type a url", text: $urlString)
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

            Text("Example: {\"id\": 1, \"name\": \"\"}")
                .foregroundColor(.gray)
                .font(.caption)
            TextEditor(text: $customJson)
                .frame(height: 100)
                .overlay(RoundedRectangle(cornerRadius: 8)
                .stroke(Color.gray))
                .padding()
        }
    }

    private var sendRequestButton: some View {
        Button(action: {
            viewModel.performRequest(urlString: urlString, bodyRequest: customJson)
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
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: ExampleViewModel())
    }
}
