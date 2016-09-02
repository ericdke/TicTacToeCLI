public struct Slot: CustomStringConvertible {

    public var index: Int
    private let is_term: Bool
    public var player: Player?

    public init(index: Int, is_term: Bool = true) {
        self.index = index
        self.is_term = is_term
    }

    public var description: String {
        if is_term {
            if let sym = player?.symbol {
                let s = "\(sym)"
                if s == "X" {
                    return s.colorized(color: .blue)
                }
                return s.colorized(color: .green)
            }
            return "-".colorized(color: .magenta)
        }
        if let sym = player?.symbol {
            return "\(sym)"
        }
        return "-"
    }
}

