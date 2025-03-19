//
//  StringCodingKey.swift
//  Example
//
//  Created by Erick Silva on 18/03/25.
//


struct StringCodingKey: CodingKey {
    let stringValue: String
    init(stringValue: String) { self.stringValue = stringValue }
    var intValue: Int? { nil }
    init?(intValue: Int) { nil }
}