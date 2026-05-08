import SwiftUI

struct StateViewStart: View {

    var body: some View {
        VStack(spacing: 30) {
            Spacer()

            Text("Poke Network")
                .font(.title)

            Text("by Tien Manh Nguyen")
                .font(.caption)
                .foregroundStyle(.blue)

            Text("This app pulls Pokemon information from the web")
                .multilineTextAlignment(.center)

            Text("Enter a number in the field above to start.")
                .multilineTextAlignment(.center)

            Spacer()
        }
        .frame(width: 200)
    }
}

#Preview {
    StateViewStart()
}
