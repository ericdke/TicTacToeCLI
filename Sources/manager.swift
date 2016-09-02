public class PlayersManager {

	public var player1: Player
	public var player2: Player
    public var grid = Grid()
    public var currentPlayer: Player

	public init() {
		self.player1 = Player(symbol: Mark.X, name: "John")
		self.player2 = Player(symbol: Mark.O, name: "Jane")
        self.currentPlayer = self.player1
	}

	public init(player1:Player, player2:Player) {
		self.player1 = player1
		self.player2 = player2
        self.currentPlayer = self.player1
	}

    public func updateIndices(index: Int) {
        grid.updateIndex(index: index, player: currentPlayer)
        currentPlayer.indices.append(index)
    }

	public func swapPlayers() {
		if currentPlayer == player1 {
			currentPlayer = player2
		} else {
			currentPlayer = player1
		}
	}

}
