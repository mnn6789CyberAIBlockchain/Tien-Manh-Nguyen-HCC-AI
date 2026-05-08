extension ContentView {
    enum ViewState: CaseIterable {
        case error
        case loading
        case loaded
        case start
    }
}

extension CaseIterable where Self: Equatable {
    mutating func next() {
        let all = Self.allCases
        let i = all.firstIndex(of: self)!
        let next = all.index(after: i)
        self = next == all.endIndex ? all.first! : all[next]
    }
}
