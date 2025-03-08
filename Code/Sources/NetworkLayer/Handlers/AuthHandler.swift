//
//  File.swift
//  NetworkLayer
//
//  Created by Erick Silva on 22/02/25.
//

import Foundation

protocol AuthHandlerType: NetworkHandler {

    func auth(completion: @escaping () -> Void?)
}

struct AuthHandler: AuthHandlerType {

    weak var delegate: (any NetworkLayerDelegate)?

    func auth(completion: @escaping () -> Void?) {
        delegate?.authenticate(completion: completion)
    }
}
