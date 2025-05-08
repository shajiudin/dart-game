import 'package:flutter/material.dart';
import 'globals.dart' as global;

class LightsOutPage extends StatefulWidget {
  const LightsOutPage({super.key});

  @override
  State<LightsOutPage> createState() => _LightsOutPageState();
}

class _LightsOutPageState extends State<LightsOutPage> {
  List<List<bool>> grid = List.generate(5, (_) => List.filled(5, false));

  void toggle(int row, int col) {
    setState(() {
      if (row >= 0 && row < 5 && col >= 0 && col < 5) {
        grid[row][col] = !grid[row][col];
      }
    });
  }

  void handleTap(int row, int col) {
    toggle(row, col);
    toggle(row - 1, col);
    toggle(row + 1, col);
    toggle(row, col - 1);
    toggle(row, col + 1);
  }

  bool isWin() {
    return grid.every((row) => row.every((cell) => !cell));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: global.defaultAppBar("Lights Out", context, () => Navigator.pop(context), true),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          for (int i = 0; i < 5; i++)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int j = 0; j < 5; j++)
                  GestureDetector(
                    onTap: () {
                      handleTap(i, j);
                      if (isWin()) {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text("Congratulations!"),
                            content: const Text("You turned off all the lights!"),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  setState(() {
                                    grid = List.generate(5, (_) => List.filled(5, false));
                                  });
                                },
                                child: const Text("Restart"),
                              )
                            ],
                          ),
                        );
                      }
                    },
                    child: Container(
                      margin: const EdgeInsets.all(4.0),
                      width: 50,
                      height: 50,
                      color: grid[i][j] ? Colors.yellow : Colors.grey[300],
                    ),
                  )
              ],
            ),
        ],
      ),
    );
  }
}