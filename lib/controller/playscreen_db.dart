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
    bool found = false;

    for (int i = 0; i < letters.length; i++) {
      if (searchText.isNotEmpty &&
          letters[i].toLowerCase() == searchText[0].toLowerCase()) {
        // Check left to right --------------------------------------------
        found = true;
        for (int j = 1; j < searchText.length && found; j++) {
          if (i % columns + j >= columns ||
              letters[i + j] != searchText[j].toLowerCase()) {
            found = false;
          }
        }
        if (found) {
          for (int j = 0; j < searchText.length; j++) {
            gridColors[i + j] = Colors.green;
          }
          continue;
        }
        // Check right to left --------------------------------------------
        found = true;
        for (int j = 1; j < searchText.length && found; j++) {
          if (i % columns - j < 0 ||
              letters[i - j] != searchText[j].toLowerCase()) {
            found = false;
          }
        }
        if (found) {
          for (int j = 0; j < searchText.length; j++) {
            gridColors[i - j] = Colors.green;
          }
          continue;
        }
        // Check top to bottom --------------------------------------------
        found = true;
        for (int j = 1; j < searchText.length && found; j++) {
          if (i ~/ columns + j >= rows ||
              letters[i + j * columns] != searchText[j].toLowerCase()) {
            found = false;
          }
        }
        if (found) {
          for (int j = 0; j < searchText.length; j++) {
            gridColors[i + j * columns] = Colors.green;
          }
          continue;
        }
        // Check bottom to top -----------------------------------------------
        found = true;
        for (int j = 1; j < searchText.length && found; j++) {
          if (i ~/ columns - j < 0 ||
              letters[i - j * columns] != searchText[j].toLowerCase()) {
            found = false;
          }
        }
        if (found) {
          for (int j = 0; j < searchText.length; j++) {
            gridColors[i - j * columns] = Colors.green;
          }
          continue;
        }
        // Check top-right to bottom-left------------------------------------
        found = true;
        for (int j = 1; j < searchText.length && found; j++) {
          if (i % columns - j < 0 ||
              i ~/ columns - j < 0 ||
              letters[i - j * columns - j] != searchText[j].toLowerCase()) {
            found = false;
          }
        }
        if (found) {
          for (int j = 0; j < searchText.length; j++) {
            gridColors[i - j * columns - j] = Colors.green;
          }
          continue;
        } // Check top-left to bottom-right-----------------------------------
        found = true;
        for (int j = 1; j < searchText.length && found; j++) {
          if (i % columns + j >= columns ||
              i ~/ columns + j >= rows ||
              letters[i + j * columns + j] != searchText[j].toLowerCase()) {
            found = false;
          }
        }
        if (found) {
          for (int j = 0; j < searchText.length; j++) {
            gridColors[i + j * columns + j] = Colors.green;
          }
          continue;
        }
        // Check bottom-right to top-left------------------------------------
        found = true;
        for (int j = 1; j < searchText.length && found; j++) {
          if (i % columns - j < 0 ||
              i ~/ columns - j < 0 ||
              letters[i - j * columns + j] != searchText[j].toLowerCase()) {
            found = false;
          }
        }
        if (found) {
          for (int j = 0; j < searchText.length; j++) {
            gridColors[i - j * columns + j] = Colors.green;
          }
          continue;
        }
        // Check bottom-left to top-right---------------------------------------
        found = true;
        for (int j = 1; j < searchText.length && found; j++) {
          if (i % columns + j >= columns ||
              i ~/ columns - j < 0 ||
              letters[i - j * columns + j] != searchText[j].toLowerCase()) {
            found = false;
          }
        }
        if (found) {
          for (int j = 0; j < searchText.length; j++) {
            gridColors[i - j * columns + j] = Colors.green;
          }
          continue;
        }
      }
    }
    notifyListeners();
  }
}
