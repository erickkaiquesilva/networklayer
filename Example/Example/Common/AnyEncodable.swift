//
//  AnyEncodable.swift
//  Example
//
//  Created by Erick Silva on 18/03/25.
//

struct AnyEncodable: Encodable {
    let value: [String: Any]
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: StringCodingKey.self)
        for (key, value) in self.value {
            if let value = value as? Int {
                try container.encode(value, forKey: StringCodingKey(stringValue: key))
            } else if let value = value as? String {
                try container.encode(value, forKey: StringCodingKey(stringValue: key))
            } else if let value = value as? Double {
                try container.encode(value, forKey: StringCodingKey(stringValue: key))
            } else if let value = value as? Bool {
                try container.encode(value, forKey: StringCodingKey(stringValue: key))
            } else if let value = value as? [String: Any] {
                try container.encode(AnyEncodable(value: value), forKey: StringCodingKey(stringValue: key))
            } else if let value = value as? [Any] {
                try container.encode(AnyEncodableArray(value: value), forKey: StringCodingKey(stringValue: key))
            }
        }
    }
}
