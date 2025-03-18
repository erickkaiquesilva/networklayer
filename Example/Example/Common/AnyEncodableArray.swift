//
//  AnyEncodableArray.swift
//  Example
//
//  Created by Erick Silva on 18/03/25.
//

struct AnyEncodableArray: Encodable {
    let value: [Any]
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.unkeyedContainer()
        for item in value {
            if let item = item as? Int {
                try container.encode(item)
            } else if let item = item as? String {
                try container.encode(item)
            } else if let item = item as? Double {
                try container.encode(item)
            } else if let item = item as? Bool {
                try container.encode(item)
            } else if let item = item as? [String: Any] {
                try container.encode(AnyEncodable(value: item))
            } else if let item = item as? [Any] {
                try container.encode(AnyEncodableArray(value: item))
            }
        }
    }
}
