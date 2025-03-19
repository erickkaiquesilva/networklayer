//
//  HTTPMethod.swift
//  Example
//
//  Created by Erick Silva on 17/03/25.
//

import Foundation

enum HTTPMethodType: String, CaseIterable, Identifiable {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"

    var id: String { rawValue }
}
