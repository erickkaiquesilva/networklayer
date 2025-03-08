import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ExampleViewModel()
    
    var body: some View {
        NavigationView {
            Text("testando")
//            List(viewModel.posts) { post in
//                VStack(alignment: .leading) {
//                    Text(post.title)
//                        .font(.headline)
//                    Text(post.body)
//                        .font(.subheadline)
//                }
//            }
//            .navigationBarTitle("Posts")
//            .alert(item: $viewModel.errorMessage) { errorMessage in
//                Alert(title: Text("Error"), message: Text(errorMessage.message), dismissButton: .default(Text("OK")))
//            }
        }
    }
}
