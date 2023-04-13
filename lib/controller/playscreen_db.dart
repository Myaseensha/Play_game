import 'package:flutter/material.dart';

class PlayScreenProvider with ChangeNotifier {
  final List<String> contents;
  final int rows;
  final int columns;
  late final List<String> letters;
  late List<Color> gridColors;
  String searchText = '';

  PlayScreenProvider(this.contents, this.rows, this.columns) {
    letters = contents.length > rows * columns
        ? contents.sublist(0, rows * columns)
        : contents.toList();
    gridColors = List.filled(letters.length, Colors.grey);
  }

  List<String> get letter => letters;
  List<Color> get gridColor => gridColors;

  void textChanged(String value) {
    searchText = value;
    gridColors = List.filled(letters.length, Colors.grey);

    if (searchText.isNotEmpty) {
      for (int i = 0; i < letters.length; i++) {
        if (letters[i].toLowerCase() == searchText[0].toLowerCase()) {
          bool found = checkMatch(i, 1, 0); //left to right
          found = found || checkMatch(i, -1, 0); //right to left
          found = found || checkMatch(i, 0, 1); //top to bottom
          found = found || checkMatch(i, 0, -1); //bottom to top
          found = found || checkMatch(i, -1, -1); //top-right to bottom-left
          found = found || checkMatch(i, 1, 1); //top-left to bottom-right
          found = found || checkMatch(i, -1, 1); //bottom-right to top-left
          found = found || checkMatch(i, 1, -1); //bottom-left to top-right
          if (found) {
            gridColors[i] = Colors.green;
            break;
          }
        }
      }
    }

    notifyListeners();
  }

  bool checkMatch(int index, int xAxis, int yAxis) {
    for (int j = 1; j < searchText.length; j++) {
      int row = (index ~/ columns) + (yAxis * j);
      int col = (index ~/ columns) + (xAxis * j);
      if (row < 0 || row >= rows || col < 0 || col >= columns) {
        return false;
      }
      int letterIndex = (row * columns) + col;
      if (letters[letterIndex].toLowerCase() != searchText[j].toLowerCase()) {
        return false;
      }
    }
    for (int j = 0; j < searchText.length; j++) {
      int row = (index ~/ columns) + (yAxis * j);
      int col = (index ~/ columns) + (xAxis * j);
      int letterIndex = (row * columns) + col;
      gridColors[letterIndex] = Colors.green;
    }
    return true;
  }
}
