public struct Player {

    public var symbol: Mark

    public var name: String

    public var slotsIndices: [Int] = []

    public init(symbol: Mark, name: String) {
        self.symbol = symbol
        self.name = name
    }

}

public func == (lhs:Player?, rhs:Player) -> Bool {
    return lhs?.symbol == rhs.symbol
}