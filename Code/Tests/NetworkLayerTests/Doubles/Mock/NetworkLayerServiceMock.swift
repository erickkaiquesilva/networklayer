//
//  File.swift
//  NetworkLayer
//
//  Created by Erick Silva on 19/03/25.
//

import Foundation
@testable import NetworkLayer

struct NetworkLayerServiceMock: Equatable, NetworkLayerServiceType {

    var path: String {
        "mock-service"
    }

    var httpMethod: HTTPMethod {
        .get
    }

    var header: [String : String]? {
        [
            "dummyKey1": "dummyValue1",
            "dummyKey2": "dummyValue2"
        ]
    }

    var body: (any Encodable)? {
        nil
    }

    var cache: Bool {
        false
    }
}
