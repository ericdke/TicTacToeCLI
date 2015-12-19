public enum Mark: String {
    case X = "X"
    case O = "O"
}

public struct Player {
    var symbol:Mark
    var name:String
    var slotsIndices:[Int] = []
    init(symbol: Mark, name: String) {
        self.symbol = symbol
        self.name = name
    }
}

public func == (lhs:Player?, rhs:Player) -> Bool {
    return lhs?.symbol == rhs.symbol
}

public struct Slot {
    var index:Int
    var player:Player?
    init(index:Int) {
        self.index = index
    }
    var description:String {
        return self.player?.symbol.rawValue ?? " "
    }
}

