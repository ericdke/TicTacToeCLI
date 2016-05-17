public struct Slot: CustomStringConvertible {

    public var index: Int

    public var player: Player?

    public init(index: Int) {
        self.index = index
    }

    public var description: String {
        if let sym = self.player?.symbol {
            return "\(sym)"
        }
        return " "
    }
}