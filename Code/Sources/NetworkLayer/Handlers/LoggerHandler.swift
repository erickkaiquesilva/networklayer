//
//  File.swift
//  NetworkLayer
//
//  Created by Erick Silva on 22/02/25.
//

import Foundation

protocol LoggerHandlerType: NetworkHandler {

    func logRequest(
        service: NetworkLayerServiceType,
        result: Result<Data, Error>
    )
    func logRequest<T: Codable>(
        service: NetworkLayerServiceType,
        result: Result<T, Error>
    )
}

struct LoggerHandler: LoggerHandlerType {

    weak var delegate: (any NetworkLayerDelegate)?

    func logRequest(
        service: NetworkLayerServiceType,
        result: Result<Data, Error>
    ) {
        var logMessage = buildHeaderLog(service)
        logMessage += "----------------------------------------\n"
        let timestamp = formattedTimestamp()
        logMessage += "[\(timestamp)] RESPONSE\n"
        switch result {
        case .success(let data):
            let jsonFormatter: String? = String(data: data, encoding: .utf8)
            logMessage += jsonFormatter ?? "Not Found"
        case .failure(let err):
            logMessage += err.localizedDescription
        }
        print(logMessage)
    }
    
    func logRequest<T: Codable>(
        service: NetworkLayerServiceType,
        result: Result<T, Error>
    ) {
        var logMessage = buildHeaderLog(service)
        logMessage += "----------------------------------------\n"
        let timestamp = formattedTimestamp()
        logMessage += "[\(timestamp)] RESPONSE\n"

        switch result {
        case .success(let response):
            logMessage += "\(response)"
        case .failure(let err):
            logMessage += err.localizedDescription
        }
        print(logMessage)
    }

    // MARK: - Private methods
    private func buildHeaderLog(_ service: NetworkLayerServiceType) -> String {
        let timestamp = formattedTimestamp()
        var logMessage = "[\(timestamp)] REQUEST STARTED\n"
        logMessage += "Method: \(service.httpMethod.rawValue)\n"
        logMessage += "URL: \(service.path)\n"

        if let header = service.header, !header.isEmpty {
            logMessage += "Headers: \(header)\n"
        }

        if let body = service.body {
            logMessage += "Body: \(body)\n"
        }
        return logMessage
    }
    private func formattedTimestamp() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter.string(from: Date())
    }
}
