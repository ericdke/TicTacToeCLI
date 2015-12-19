let ttt = TicTacToe()

print("\(ttt.player1.name) has \(ttt.player1.symbol)")
print("\(ttt.player2.name) has \(ttt.player2.symbol)\n")

// ttt.slots[0].player = ttt.player1
// ttt.slots[4].player = ttt.player2
// ttt.slots[1].player = ttt.player1
// ttt.slots[2].player = ttt.player2
// ttt.slots[3].player = ttt.player1
// ttt.slots[6].player = ttt.player2

// print(ttt.gridView)

// let winner = ttt.checkWin(ttt.player1) ? ttt.player1.name : ttt.player2.name

// print("\nWinner is \(winner)!")

ttt.play()