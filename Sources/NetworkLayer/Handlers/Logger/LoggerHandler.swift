//
//  File.swift
//  NetworkLayer
//
//  Created by Erick Silva on 22/02/25.
//

import Foundation

struct LoggerHandler: LoggerHandlerType {

    weak var delegate: (any NetworkLayerDelegate)?

    init(delegate: (any NetworkLayerDelegate)?) {
        self.delegate = delegate
    }

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
        logMessage += "----------------------------------------"

        createLogResponse(
            logType: .message,
            title: "TRACE REQUEST",
            message: logMessage
        )
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
        logMessage += "----------------------------------------"

        createLogResponse(
            logType: .message,
            title: "TRACE REQUEST",
            message: logMessage
        )
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

    private func createLogResponse(logType: LoggerType, title: String, message: String) {
        let response: LoggerResponse = .init(type: logType, title: title, message: message)
        delegate?.loggerNetwork(log: response)
    }
}

public enum LoggerType: String {

    case warning = "WARNING"
    case error = "ERROR"
    case message = "MESSAGE"
}

public struct LoggerResponse {

    let type: LoggerType
    let title: String
    let message: String
}
