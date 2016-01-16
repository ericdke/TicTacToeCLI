public class PlayersManager {

	public var player1:Player
	public var player2:Player
	public var players:[Player] = []

	public init() {
		self.player1 = Player(symbol: Mark.X, name: "John")
		self.player2 = Player(symbol: Mark.O, name: "Jane")
		self.players = [player1, player2]
	}

	public init(player1:Player, player2:Player) {
		self.player1 = player1
		self.player2 = player2
		self.players = [player1, player2]
	}

}