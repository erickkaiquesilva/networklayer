//
//  NetworkFactory.swift
//  Example
//
//  Created by Erick Silva on 18/03/25.
//

import Foundation
import NetworkLayer

struct NetworkFactory {

    static func createNetwork(baseUrl: String) -> NetworkLayer {
        return NetworkLayer(baseUrl: baseUrl)
    }

    static func createServiceNetwork(
        path: String,
        method: HTTPMethodType,
        header: [String: String]?, body: Encodable?
    ) -> NetworkLayerServiceType {
        let httpMethod: HTTPMethod = HTTPMethod(rawValue: method.id) ?? .get
        let service = ServiceExample(
            path: path,
            httpMethod: httpMethod,
            header: header,
            body: body
        )
        return service
    }
}
