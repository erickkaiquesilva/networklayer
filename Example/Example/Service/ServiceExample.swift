//
//  ServiceExample.swift
//  Example
//
//  Created by Erick Silva on 17/03/25.
//

import Foundation
import NetworkLayer

struct ServiceExample: NetworkLayerServiceType {

    var path: String

    var httpMethod: HTTPMethod
    
    var header: [String : String]?
    
    var body: (any Encodable)?
    
    var cache: Bool {
        false
    }
}
