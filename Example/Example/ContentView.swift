import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ExampleViewModel()
    
    var body: some View {
        Text("Config Service")
    }
}
