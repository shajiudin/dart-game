import 'package:flutter/material.dart';
import 'globals.dart' as global;

class GameBoard extends StatefulWidget {
  const GameBoard({super.key});

  @override
  State<GameBoard> createState() => _GameBoardState();
}

class _GameBoardState extends State<GameBoard> {
  List<String> board = List.filled(9, '');
  bool isXTurn = true;

  void resetGame() {
    setState(() {
      board = List.filled(9, '');
      isXTurn = true;
    });
  }

  void handleTap(int index) {
    if (board[index] == '') {
      setState(() {
        board[index] = isXTurn ? 'X' : 'O';
        isXTurn = !isXTurn;
      });

      String? winner = checkWinner();
      if (winner != null) {
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: const Text("Game Over"),
            content: Text("Winner is $winner"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  resetGame();
                },
                child: const Text("Play Again"),
              )
            ],
          ),
        );
      }
    }
  }

  String? checkWinner() {
    List<List<int>> winPatterns = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6],
    ];

    for (var pattern in winPatterns) {
      String a = board[pattern[0]];
      String b = board[pattern[1]];
      String c = board[pattern[2]];
      if (a != '' && a == b && b == c) {
        return a;
      }
    }

    if (!board.contains('')) {
      return "Draw";
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final boardSize = screenWidth > 500 ? 400.0 : screenWidth * 0.9;

    return Scaffold(
      appBar: global.defaultAppBar("Tic Tac Toe", context, () => Navigator.pop(context), true),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "${isXTurn ? 'X' : 'O'}'s Turn",
              style: const TextStyle(fontSize: 30),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: boardSize,
              height: boardSize,
              child: GridView.builder(
                itemCount: 9,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                ),
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () => handleTap(index),
                  child: Container(
                    margin: const EdgeInsets.all(4.0),
                    decoration: BoxDecoration(
                      color: Colors.blue[100],
                      border: Border.all(color: Colors.black),
                    ),
                    child: Center(
                      child: Text(
                        board[index],
                        style: const TextStyle(fontSize: 40),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: resetGame,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 15, 10, 10), // Use backgroundColor instead of primary
              ),
              child: const Text(
                "Reset Game",
                style: TextStyle(fontSize: 20,color: Colors.white),

              ),
            ),
          ],
        ),
      ),
    );
  }
}
