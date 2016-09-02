import Foundation
#if os(Linux) 
    import Glibc 
#endif

public class TicTacToe {

	private let winningSequences = [
	    // Horizontal
	    [ 0, 1, 2 ],
	    [ 3, 4, 5 ],
	    [ 6, 7, 8 ],
	    // Diagonal
	    [ 0, 4, 8 ],
	    [ 2, 4, 6 ],
	    // Vertical
	    [ 0, 3, 6 ],
	    [ 1, 4, 7 ],
	    [ 2, 5, 8 ]
	]

	public var playersManager: PlayersManager
	public var view = View()

	public init() {
		self.playersManager = PlayersManager()
		#if os(Linux)
			srandom(UInt32(time(nil)))
		#endif
	}

	public init(player1: Player, player2: Player) {
		self.playersManager = PlayersManager(player1: player1, player2: player2)
	}

	private func checkWin() {
        let cb = playersManager.currentPlayer.indices.combination(length: 3)
        for c in cb {
            let s = c.sorted()
            for seq in winningSequences {
                if s == seq {
                    view.sayWinner(player: playersManager.currentPlayer)
                    exit(0)
                }
            }
        }
	}

	private func randomIndex() -> Int {
		var index: Int
		#if os(OSX)
			repeat {
		    	index = Int(arc4random_uniform(9))
		    } while playersManager.grid.played.contains(index)
		#else
			repeat {
				index = Int(random() % 9)
			} while playersManager.grid.played.contains(index)
		#endif
		return index
	}

	public func play() {
		view.announce(p1: playersManager.player1, p2: playersManager.player2)
        for _ in 1...9 {
            view.playerPlays(player: playersManager.currentPlayer)
            let idx = randomIndex()
            playersManager.updateIndices(index: idx)
            view.printGrid(grid: playersManager.grid)
            checkWin()
            playersManager.swapPlayers()
        }
        view.noWinner()
	}

}
