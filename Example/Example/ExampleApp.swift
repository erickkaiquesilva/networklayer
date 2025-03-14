//
//  ExampleApp.swift
//  Example
//
//  Created by Erick Silva on 12/02/25.
//

import SwiftUI
import NetworkLayer

@main
struct ExampleApp: App {

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

struct PostResponse: Codable {
    let id: Int
    let title: String
}

struct ServiceTest: NetworkLayerServiceType {

    var path: String {
        "/posts"
    }

    var httpMethod: HTTPMethod {
        .get
    }

    var header: [String : String]? {
        nil
    }
    
    var body: (any Encodable)? {
        nil
    }

    var cache: Bool {
        false
    }
}
