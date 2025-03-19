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
            let viewModel: RequestSettingsViewModel = .init()
            RequestSettingsView(viewModel: viewModel)
        }
    }
}
