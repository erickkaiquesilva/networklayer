//
//  ResponseViewDTO.swift
//  Example
//
//  Created by Erick Silva on 18/03/25.
//

import Foundation

struct ResponseViewDTO: Equatable {

    // MARK: - Properties
    let baseUrl: String
    let servicePath: String
    let httpMethod: String
    let header: [String: String]?
    let body: String?
    let requestResult: String

    // MARK: - Initializer
    init(
        baseUrl: String = "",
        servicePath: String = "",
        httpMethod: String = "",
        header: [String : String]? = nil,
        body: String? = nil,
        requestResult: String = ""
    ) {
        self.baseUrl = baseUrl
        self.servicePath = servicePath
        self.httpMethod = httpMethod
        self.header = header
        self.body = body
        self.requestResult = requestResult
    }
}
