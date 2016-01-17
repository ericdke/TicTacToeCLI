#if os(Linux)
	import Glibc
#endif

public class Grid: CustomStringConvertible {

	public var slots:[Slot]
	public var played:[Int] = []

	public init() {
		self.slots = Array(0...8).map { Slot(index: $0) }
		#if os(Linux)
			srandom(UInt32(time(nil)))
		#endif
	}

	public var description: String {
	    let groups = self.slots.splitBy(3)
	    let sub = groups.map { "\($0)" }
	    return sub.joinWithSeparator("\n")
	}

	public func updateIndex(index: Int, forPlayer currentPlayer: Player) {
		self.played.append(index)
		self.slots[index].player = currentPlayer
	}

}
