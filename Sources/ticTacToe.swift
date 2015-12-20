#if os(Linux) 
    import Glibc 
#else 
    import Foundation
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

	public var player1:Player
	public var player2:Player
	public var players:[Player] = []
	public var slots:[Slot] = []
	public var played:[Int] = []

	public init() {
		self.player1 = Player(symbol: Mark.X, name: "John")
		self.player2 = Player(symbol: Mark.O, name: "Jane")
		self.players = [player1, player2]
		for i in 0...8 {
		    slots.append(Slot(index: i))
		}
		srandom(UInt32(time(nil)))
	}

	public init(player1:Player, player2:Player) {
		self.player1 = player1
		self.player2 = player2
		self.players = [player1, player2]
		for i in 0...8 {
		    slots.append(Slot(index: i))
		}
		srandom(UInt32(time(nil)))
	}

	private func checkWin(player: Player, selectedIndexes:[Int]) -> Bool {
	    if winningSequences.map({ Set<Int>($0) }).contains( Set<Int>(selectedIndexes) ) {
	        return true
	    }
	    return false
	}

	var gridView: String {
	    let groups = slots.splitBy(3)
	    let sub = groups.map { "\($0)" }
	    return sub.joinWithSeparator("\n")
	}

	// TODO: find a way to generate a GOOD random number without killing the CPU
	// This function is very *pseudo* random. Bleh.
	func getPseudoRandomNumber(max:Int) -> Int {
	    return Int(random() % max)
	}

	private func randomIndex() -> Int {
		var index: Int
		#if os(Linux) 
		    repeat {
				index = getPseudoRandomNumber(9)
			} while played.contains(index)
		#else 
		    repeat {
		    	index = Int(arc4random_uniform(9))
		    } while played.contains(index)
		#endif
		played.append(index)
		return index
	}

	private func checkPermutations(player current:Player) {
		if current.slotsIndices.count > 3 {
			var perms:[[Int]] = []
			current.slotsIndices.permutation(3).map { $0.sort() }.forEach { (a) -> () in
			    let contains = perms.contains{ $0 == a }
			    if !contains {
			        perms.append(a)
			    }
			}
			for perm in perms {
				if checkWin(current, selectedIndexes: perm) {
					sayWinner(current)
					exit(0)
				}	
			}
		}
	}

	private func sayWinner(player:Player) {
		print("\(player.name) is the winner!")
	}

	private func checkSlots(player current:Player) {
		if checkWin(current, selectedIndexes: slots.filter { $0.player == current }.map { $0.index }) {
			sayWinner(current)
			exit(0)
		}
	}

	public func play() {
		var current = player1
		for _ in 1...9 {
			print("\(current.name) plays:\n")

			let idx = randomIndex()
			slots[idx].player = current
			if current == player1 {
				player1.slotsIndices.append(idx)
				current = player1
			} else {
				player2.slotsIndices.append(idx)
				current = player2
			}

			print("\(gridView)\n")

			checkPermutations(player: current)
			checkSlots(player: current)
			
			if played.count == 9 {
				print("No winner. They're both too dumb.")
				exit(0)
			}
			if current == player1 {
				current = player2
			} else {
				current = player1
			}
		}
	}

}