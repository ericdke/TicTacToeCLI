public class Grid {
	
	public var slots:[Slot] = []
	public var played:[Int] = []

	public init() {
		for i in 0...8 {
		    slots.append(Slot(index: i))
		}
		#if os(Linux)
			srandom(UInt32(time(nil)))
		#endif
	}

	public var view: String {
	    let groups = slots.splitBy(3)
	    let sub = groups.map { "\($0)" }
	    return sub.joinWithSeparator("\n")
	}

	func updateIndex(index: Int, forPlayer currentPlayer: Player) {
		played.append(index)
		slots[index].player = currentPlayer
	}

}