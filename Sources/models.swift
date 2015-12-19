public enum Mark {
    case X
    case O
}

public struct Player {
    public var symbol:Mark
    public var name:String
    public var slotsIndices:[Int] = []
    public init(symbol: Mark, name: String) {
        self.symbol = symbol
        self.name = name
    }
}

public func == (lhs:Player?, rhs:Player) -> Bool {
    return lhs?.symbol == rhs.symbol
}

public struct Slot: CustomStringConvertible {
    public var index:Int
    public var player:Player?
    public init(index:Int) {
        self.index = index
    }
    public var description:String {
        if let sym = self.player?.symbol {
            return "\(sym)"
        }
        return " "
    }
}

