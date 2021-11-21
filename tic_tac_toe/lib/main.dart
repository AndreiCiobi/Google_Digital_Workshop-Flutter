import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TicTacToe(),
    );
  }
}

class TicTacToe extends StatefulWidget {
  const TicTacToe({Key? key}) : super(key: key);

  @override
  _TicTacToeState createState() => _TicTacToeState();
}

class Cell {
  Cell({required this.color, required this.isPressed, required this.index});

  final Color color;
  final bool isPressed;
  final int index;
}

class _TicTacToeState extends State<TicTacToe> {
  final List<Cell> _cells = <Cell>[];
  bool firstPlayerTurn = true;
  bool gameOver = false;

  Color _switchTurn() {
    return firstPlayerTurn ? Colors.red : Colors.green;
  }

  bool _gameOver() {
    final List<int> _redCells = _cells.where((Cell cell) => cell.color == Colors.red).map((Cell e) => e.index).toList();
    final List<int> _greenCells =
        _cells.where((Cell cell) => cell.color == Colors.green).map((Cell e) => e.index).toList();

    for (int i = 0; i < 3; ++i) {
      // for rows
      if (_redCells.contains(3 * i) && _redCells.contains(3 * i + 1) && _redCells.contains(3 * i + 2)) {
        setState(() {
          _cells.removeWhere((Cell cell) => cell.color == Colors.green);
        });
        return true;
      }

      if (_greenCells.contains(3 * i) && _greenCells.contains(3 * i + 1) && _greenCells.contains(3 * i + 2)) {
        setState(() {
          _cells.removeWhere((Cell cell) => cell.color == Colors.red);
        });
        return true;
      }

      // for columns
      if (_redCells.contains(i) && _redCells.contains(i + 3) && _redCells.contains(i + 6)) {
        setState(() {
          _cells.removeWhere((Cell cell) => cell.color == Colors.green);
        });
        return true;
      }

      if (_greenCells.contains(i) && _greenCells.contains(i + 3) && _greenCells.contains(i + 6)) {
        setState(() {
          _cells.removeWhere((Cell cell) => cell.color == Colors.red);
        });
        return true;
      }
    }

    if (_redCells.contains(0) && _redCells.contains(4) && _redCells.contains(8) ||
    _redCells.contains(2) && _redCells.contains(4) && _redCells.contains(6)) {
      setState(() {
        _cells.removeWhere((Cell cell) => cell.color == Colors.green);
      });
      return true;
    }

    if (_greenCells.contains(0) && _greenCells.contains(4) && _greenCells.contains(8) ||
        _greenCells.contains(2) && _greenCells.contains(4) && _greenCells.contains(6)) {
      setState(() {
        _cells.removeWhere((Cell cell) => cell.color == Colors.red);
      });
      return true;
    }

    return _cells.length == 9;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('tic-tac-toe'),
        centerTitle: true,
        backgroundColor: Colors.amberAccent,
        foregroundColor: Colors.black,
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.605,
            child: GridView.builder(
              itemCount: 9,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
              ),
              itemBuilder: (BuildContext ctx, int index) {
                final Cell? element = _cells.firstWhereOrNull((Cell item) => item.index == index);

                return GestureDetector(
                  onTap: element != null
                      ? null
                      : () {
                          setState(() {
                            _cells.add(Cell(color: _switchTurn(), isPressed: false, index: index));
                            firstPlayerTurn = !firstPlayerTurn;
                          });
                        },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    decoration: BoxDecoration(
                      color: element != null ? element.color : Colors.white,
                      border: Border.all(
                        width: 0.5,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          if (_gameOver())
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _cells.clear();
                });
                firstPlayerTurn = true;
              },
              style: ElevatedButton.styleFrom(
                onPrimary: Colors.black,
                primary: Colors.white54,
              ),
              child: const Text('Play again!'),
            ),
        ],
      ),
    );
  }
}
