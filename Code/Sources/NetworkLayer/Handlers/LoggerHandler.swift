//
//  File.swift
//  NetworkLayer
//
//  Created by Erick Silva on 22/02/25.
//

import Foundation

protocol LoggerHandlerType: NetworkHandler {

    func logRequest(service: NetworkLayerServiceType)
    func logError(error: Error)
    func logResponse<T: Decodable>(service: NetworkLayerServiceType, response: T.Type)
}

struct LoggerHandler: LoggerHandlerType {

    weak var delegate: (any NetworkLayerDelegate)?

    func logRequest(service: any NetworkLayerServiceType) {
        
    }

    func logError(error: any Error) {
        
    }

    func logResponse<T: Decodable>(service: any NetworkLayerServiceType, response: T.Type) {
        
    }
}
