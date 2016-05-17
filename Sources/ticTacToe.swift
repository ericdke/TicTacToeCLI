import Foundation
#if os(Linux) 
    import Glibc 
#endif

public class TicTacToe {

	private let winningSequences = [
	    // Horizontal rows
	    [ 0, 1, 2 ],
	    [ 3, 4, 5 ],
	    [ 6, 7, 8 ],
	    // Diagonals
	    [ 0, 4, 8 ],
	    [ 2, 4, 6 ],
	    // Vertical rows
	    [ 0, 3, 6 ],
	    [ 1, 4, 7 ],
	    [ 2, 5, 8 ]
	]

	public let playersManager: PlayersManager
	public let grid: Grid
	public let view: View

	public init() {
		self.playersManager = PlayersManager()
		self.grid = Grid()
		self.view = View(manager: self.playersManager)
	}

	public init(player1:Player, player2:Player) {
		self.playersManager = PlayersManager(player1: player1, player2: player2)
		self.grid = Grid()
		self.view = View(manager: self.playersManager)
	}

	private func checkWin(player: Player, selectedIndexes:[Int]) -> Bool {
		let wS = winningSequences.map({ Set<Int>($0) })
		let sI = Set<Int>(selectedIndexes)
		if sI.count > 3 {
			var pl = player // player is a struct
			pl.slotsIndices = sI.map { Int($0) }
			checkPermutations(player: pl)
		}
	    if wS.contains(sI) {
	        return true
	    }
	    return false
	}

	// TODO: find a way to generate a GOOD random number without killing the CPU
	// This function is very *pseudo* random. Bleh.
	private func getPseudoRandomNumber(max: Int) -> Int {
	    return Int(random() % max)
	}

	private func randomIndex() -> Int {
		var index: Int
		#if os(OSX)
			repeat {
		    	index = Int(arc4random_uniform(9))
		    } while self.grid.played.contains(index)
		#else
			repeat {
				index = getPseudoRandomNumber(max: 9)
			} while self.grid.played.contains(index)
		#endif
		return index
	}

	private func checkPermutations(player currentPlayer: Player) {
		if currentPlayer.slotsIndices.count > 3 {
			var perms: [[Int]] = []
			currentPlayer.slotsIndices.permutation(length: 3).map { $0.sorted() }.forEach { (a) -> () in
			    let contains = perms.contains { $0 == a }
			    if !contains {
			        perms.append(a)
			    }
			}
			for perm in perms {
				if checkWin(player: currentPlayer, selectedIndexes: perm) {
					self.view.sayWinner(player: currentPlayer)
					exit(0)
				}	
			}
		}
	}

	private func checkSlots(player currentPlayer:Player) {
		let indices = self.grid.slots.filter { $0.player == currentPlayer }.map { $0.index }
		if checkWin(player: currentPlayer, selectedIndexes: indices) {
			self.view.sayWinner(player: currentPlayer)
			exit(0)
		}
	}

	private func addIndexToPlayer(currentPlayer: Player, index:Int) {
		if currentPlayer == self.playersManager.player1 {
			self.playersManager.player1.slotsIndices.append(index)
		} else {
			self.playersManager.player2.slotsIndices.append(index)
		}
	}

	private func swapPlayers(currentPlayer: Player) -> Player {
		if currentPlayer == self.playersManager.player1 {
			return self.playersManager.player2
		} else {
			return self.playersManager.player1
		}
	}

	private func checkNoWinner() {
		if self.grid.played.count == 9 {
			self.view.noWinner()
			exit(0)
		}
	}

	public func play() {
		self.view.announce()
		var currentPlayer = self.playersManager.player1
		9.times {
			self.view.playerPlays(player: currentPlayer)

			let idx = self.randomIndex()
			self.grid.updateIndex(index: idx, forPlayer: currentPlayer)
			self.addIndexToPlayer(currentPlayer: currentPlayer, index: idx)

			self.view.printGrid(grid: self.grid)

			self.checkPermutations(player: currentPlayer)
			self.checkSlots(player: currentPlayer)
			self.checkNoWinner()
			
			currentPlayer = self.swapPlayers(currentPlayer: currentPlayer)
		}
	}

}