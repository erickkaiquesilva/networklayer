//
//  LoggerHandlerType.swift
//  NetworkLayer
//
//  Created by Erick Silva on 19/03/25.
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
