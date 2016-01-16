public class Grid {
	
	public var slots:[Slot] = []
	public var played:[Int] = []

	public init() {
		for i in 0...8 {
		    self.slots.append(Slot(index: i))
		}
		#if os(Linux)
			srandom(UInt32(time(nil)))
		#endif
	}

	public var view: String {
	    let groups = self.slots.splitBy(3)
	    let sub = groups.map { "\($0)" }
	    return sub.joinWithSeparator("\n")
	}

	public func updateIndex(index: Int, forPlayer currentPlayer: Player) {
		self.played.append(index)
		self.slots[index].player = currentPlayer
	}

}