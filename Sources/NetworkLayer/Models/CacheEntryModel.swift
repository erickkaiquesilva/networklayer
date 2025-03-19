//
//  File.swift
//  NetworkLayer
//
//  Created by Erick Silva on 22/02/25.
//

import Foundation

struct CacheEntryModel: Codable {

    // MARK: Private properties
    private let data: Data
    private let timestamp: Date

    // MARK: - Initializer
    init<T: Encodable>(_ value: T) throws {
        self.data = try JSONEncoder().encode(value)
        self.timestamp  = Date()
    }

    // MARK: - Internal methods
    func isValid(ttl: TimeInterval) -> Bool {
        return Date().timeIntervalSince(timestamp) < ttl
    }

    func decode<T: Decodable>(to type: T.Type) -> T? {
        return try? JSONDecoder().decode(T.self, from: data)
    }
}
