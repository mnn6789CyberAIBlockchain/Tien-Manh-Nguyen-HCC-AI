import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ContentViewModel()

    var body: some View {
        VStack {

            EntryView(vm: viewModel)

            switch viewModel.state {

            case .error:
                StateViewError()

            case .loading:
                StateViewLoading()

            case .loaded:
                StateViewLoaded(vm: viewModel)

            case .start:
                StateViewStart()
            }
        }
        .padding()
        .ignoresSafeArea(edges: .bottom)
    }
}

#Preview {
    ContentView()
}
