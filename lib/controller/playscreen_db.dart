import 'dart:developer';
import 'package:flutter/material.dart';

class PlayScreenProvider with ChangeNotifier {
  final List<String> contents;
  final int rows;
  final int columns;
  late final List<String> letters;
  String searchText = '';
  bool success = false;

  PlayScreenProvider(this.contents, this.rows, this.columns) {
    letters = contents.length > rows * columns
        ? contents.sublist(0, rows * columns)
        : contents.toList();
  }
  void textChanged(String searchText) {
    searchText = searchText.toLowerCase();
    log(searchText);
    var characters = contents.map((e) => e.toLowerCase()).toList();
    log(characters.toString());

    var mRow = rows;
    var mCol = columns;
    List<List<String>> charMatrix = [];
    int pos = 0;

    for (int i = 0; i < mRow; i++) {
      if (charMatrix.length != i + 1) {
        charMatrix.add([]);
      }
      for (var j = 0; j < mCol; j++, pos++) {
        charMatrix[i].add(characters[pos]);
      }
    }

    log(charMatrix[0].toString());
    log(charMatrix[1].toString());
    log(charMatrix[2].toString());

    int prevRow = -1;
    int prevCol = -1;
    int? patternRow;
    int? patternCol;
    bool patternSet = false;
    int flowCount = 0;

    for (int i = 0; i < searchText.length; i++) {
      String currentText = searchText[i];
      bool isFlow = false;

      for (var row = 0; row < charMatrix.length; row++) {
        for (var col = 0; col < charMatrix[0].length; col++) {
          if (charMatrix[row][col] == currentText &&
              (prevRow + 1 == row ||
                  prevRow - 1 == row ||
                  prevRow == row ||
                  prevRow == -1) &&
              (prevCol + 1 == col ||
                  prevCol - 1 == col ||
                  prevCol == col ||
                  prevCol == -1)) {
            if (patternSet == true) {
              if (prevCol + patternCol! == col &&
                  prevRow + patternRow! == row) {
                prevRow = row;
                prevCol = col;
                log('$row,$col');
                flowCount++;
                isFlow = true;
              }
            } else {
              if (prevRow != -1 && prevCol != -1) {
                patternCol = col - prevCol;
                patternRow = row - prevRow;
                patternSet = true;
              }
              prevRow = row;
              prevCol = col;
              log('$row,$col');
              flowCount++;
              isFlow = true;
            }
          }
        }
      }
      if (isFlow == false) {
        success = false;
        notifyListeners();
        return;
      }
    }
    if (flowCount == searchText.length) {
      success = true;
      notifyListeners();
      return;
    } else {
      success = false;
      notifyListeners();
      return;
    }
  }
}
