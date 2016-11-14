import Foundation
#if os(Linux) 
    import Glibc
#endif

enum Warnings: String {
	case Help = "\nSimple TicTacToe game.\n\nUSAGE:\n\n-a\tAutomatic (computer plays alone)\n"
}

class CLI {

	var game = TicTacToe()
	var sourceFile: String?
	var command: String?
	var input: [String] = []

	init() {
		var args = CommandLine.arguments
		self.sourceFile = args[0]
		if args.count > 1 {
			self.command = args[1]
		} else {
			help()
		}
	}

	func startGame() {
		// WIP
		if let c = command {
			switch c {
			case "-a":
				game.play()
			default:
				help()
			}
		}
	}

	private func help() {
		print(Warnings.Help.rawValue)
		exit(0)
	}
}
