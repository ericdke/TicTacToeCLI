public class View {

	public let playersManager: PlayersManager

	public init(manager: PlayersManager) {
		playersManager = manager
	}
	
	public func announce() {
		print("\n\(playersManager.player1.name) has \(playersManager.player1.symbol)")
		print("\(playersManager.player2.name) has \(playersManager.player2.symbol)\n")
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