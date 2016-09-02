#if os(Linux)
	import Glibc
#endif

public class Grid: CustomStringConvertible {

	public var slots: [Slot]
	public var played: [Int] = []

	public init() {
		self.slots = Array(0...8).map { Slot(index: $0) }
	}

	public var description: String {
	    let groups = self.slots.splitBy(subSize: 3)
	    let sub = groups.map { $0.map({ $0.description }).joined(separator: " ") }
	    return sub.joined(separator: "\n")
	}

	public func updateIndex(index: Int, player: Player) {
		self.played.append(index)
		self.slots[index].player = player
	}

}
