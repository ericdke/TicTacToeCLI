public class View {
	
    public func announce(p1: Player, p2: Player) {
		print("\n\(p1.name) has \(p1.symbol)")
		print("\(p2.name) has \(p2.symbol)\n")
	}

	public func playerPlays(player: Player) {
		print("\(player.name) plays:\n")
	}

	public func printGrid(grid: Grid) {
		print("\(grid)\n")
	}

	public func noWinner() {
		print("No winner. They're both too dumb.")
	}

	public func sayWinner(player: Player) {
		print("\(player.name) is the winner!")
	}

}
