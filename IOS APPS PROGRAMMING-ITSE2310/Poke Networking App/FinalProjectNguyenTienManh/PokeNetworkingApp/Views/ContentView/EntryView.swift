import SwiftUI

struct EntryView: View {
    @ObservedObject private var vm: ContentViewModel

    init(vm: ContentViewModel) {
        self.vm = vm
    }

    var body: some View {
        VStack(spacing: 20) {

            LabeledContent {
                TextField("pokemon number", text: $vm.text)
            } label: {
                Text("Enter a Number: ")
            }

            Button {
                vm.updateState()
            } label: {
                ZStack {
                    Color.black.clipShape(.capsule)

                    Text("Get a Pokemon")
                        .foregroundStyle(.white)
                }
                .frame(height: 30)
            }
        }
        .padding(.horizontal, 30)
        .padding(.vertical, 50)
        .onChange(of: vm.text) { _, _ in
            vm.state = .start
        }
    }
}

#Preview {
    EntryView(vm: ContentViewModel())
}
