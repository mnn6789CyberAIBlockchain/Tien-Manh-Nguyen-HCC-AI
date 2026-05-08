import SwiftUI

struct StateViewLoading: View {

    var body: some View {
        VStack {
            Spacer()

            Text("LOADING...")

            ProgressView()

            Spacer()
        }
    }
}

#Preview {
    StateViewLoading()
}
