//
//  File.swift
//  NetworkLayer
//
//  Created by Erick Silva on 23/02/25.
//

import Foundation

final class AuthDecorator: NetworkLayerDecoratorType {

    // MARK: - Public properties
    var network: any NetworkLayerRequestType

    // MARK: - Private properties
    private var authHandler: NetworkHandler

    // MARK: - Initializer
    init(network: any NetworkLayerRequestType, authHandler: NetworkHandler) {
        self.network = network
        self.authHandler = authHandler
    }

    func request(
        service: NetworkLayerServiceType,
        completion: @escaping (Result<Data, Error>) -> Void
    ) {
        
    }
    
    func request<T: Codable>(
        object: T.Type,
        service: any NetworkLayerServiceType,
        completion: @escaping (Result<T, any Error>) -> Void
    ) {
        
    }
}
