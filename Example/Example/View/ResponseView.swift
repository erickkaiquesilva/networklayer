//
//  ResponseView.swift
//  Example
//
//  Created by Erick Silva on 18/03/25.
//

import SwiftUI

struct ResponseView: View {

    @Environment(\.dismiss) var dismiss

    // MARK: - Private properties
    private let dto: ResponseViewDTO
    @State private var showCopyConfirmation: Bool = false

    // MARK: - Initializer
    init(dto: ResponseViewDTO) {
        self.dto = dto
    }

    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 20) {
                VStack(alignment: .leading, spacing: 10) {
                    Text("Request Info")
                        .font(.headline)
                        .foregroundColor(.blue)

                    Text("Base Url: \(dto.baseUrl)")
                        .font(.body)
                        .foregroundColor(.black)

                    Text("Path: \(dto.servicePath)")
                        .font(.body)
                        .foregroundColor(.black)

                    Text("HTTP Method: \(dto.httpMethod)")
                        .font(.body)
                        .foregroundColor(.black)

                    if let headers = dto.header, !headers.isEmpty {
                        Text("Headers:")
                            .font(.body)
                            .foregroundColor(.black)
                        ForEach(Array(headers.keys), id: \.self) { key in
                            Text("  \(key): \(headers[key] ?? "")")
                                .font(.body)
                                .foregroundColor(.gray)
                        }
                    } else {
                        Text("Headers: Nenhum")
                            .font(.body)
                            .foregroundColor(.gray)
                    }

                    if let body = dto.body {
                        Text("Body:")
                            .font(.body)
                            .foregroundColor(.black)
                        ScrollView {
                            Text(body)
                                .font(.body)
                                .foregroundColor(.gray)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        .frame(maxHeight: 100)
                        .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray))
                    } else {
                        Text("Body: Nenhum")
                            .font(.body)
                            .foregroundColor(.gray)
                    }
                }
                .padding(.horizontal)

                VStack(alignment: .leading, spacing: 10) {
                    HStack {
                        Text("Response Result")
                            .font(.headline)
                            .foregroundColor(.blue)

                        Spacer()

                        Button(action: {
                            UIPasteboard.general.string = dto.requestResult
                            showCopyConfirmation = true
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                showCopyConfirmation = false
                            }
                        }) {
                            Image(systemName: "doc.on.doc")
                                .foregroundColor(.blue)
                                .font(.system(size: 20))
                        }
                        .overlay(
                            Group {
                                if showCopyConfirmation {
                                    Text("Copiado!")
                                        .font(.caption)
                                        .foregroundColor(.green)
                                        .offset(y: -25)
                                }
                            }
                        )
                    }
                    
                    ScrollView {
                        Text(dto.requestResult)
                            .font(.body)
                            .foregroundColor(.black)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .frame(maxHeight: 200)
                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray))
                }
                .padding(.horizontal)
                
                Spacer()
            }
            .padding(.top)
            .navigationTitle("Info")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Fechar") {
                        dismiss()
                    }
                }
            }
        }
    }
}
