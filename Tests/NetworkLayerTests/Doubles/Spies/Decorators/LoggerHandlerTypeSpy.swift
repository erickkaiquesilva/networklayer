//
//  File.swift
//  NetworkLayer
//
//  Created by Erick Silva on 19/03/25.
//

import Foundation

@testable import NetworkLayer

final class LoggerHandlerSpy: LoggerHandlerType {

    var delegate: (any NetworkLayerDelegate)?

    private(set) var logRequestWithDataCount: Int = 0
    private(set) var logRequestWithDataService: NetworkLayerServiceType?
    private(set) var logRequestResult: Result<Data, any Error>?

    func logRequest(service: any NetworkLayerServiceType, result: Result<Data, any Error>) {
        logRequestWithDataCount += 1
        logRequestWithDataService = service
        logRequestResult = result
    }

    private(set) var logRequestWithCodableCount: Int = 0
    private(set) var logRequestWithCodableService: NetworkLayerServiceType?

    func logRequest<T: Codable>(
        service: any NetworkLayerServiceType,
        result: Result<T, any Error>
    ) {
        logRequestWithCodableCount += 1
        logRequestWithCodableService = service
    }
}
