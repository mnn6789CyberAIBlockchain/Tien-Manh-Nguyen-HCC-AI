import SwiftUI

struct StateViewError: View {

    var body: some View {
        Spacer()

        Text("Network call failed")
            .font(.callout)
            .foregroundStyle(.red)

        Spacer()
    }
}

#Preview {
    StateViewError()
}
