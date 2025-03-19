//
//  ResponseType.swift
//  Example
//
//  Created by Erick Silva on 17/03/25.
//

import Foundation

enum ResponseType: String, CaseIterable, Identifiable {
    case example = "No Body"
    case custom = "Add Body"
    var id: String { rawValue }
}
