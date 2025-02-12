//
//  ExampleApp.swift
//  Example
//
//  Created by Magalu on 12/02/25.
//

import SwiftUI
import networklayer

@main
struct ExampleApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        let s = NetworkLayerShared()
    }
}
