import 'package:flutter/material.dart';
import 'package:puzzle_hack/block.dart';

class PuzzleState extends ChangeNotifier {
  List<int> priorityList = [0, 1, 2, 3, 4, 5, 6, 7];
  List<int> positionList = [0, 1, 2, 3, 4, 5, 6, 7];


  int emptyIndex = 8;

  void shuffle() {

  }



  bool isAdjacentToEmpty(int i1) {
    int x1 = i1 ~/ 3;
    int y1 = i1 % 3;
    int x2 = emptyIndex ~/ 3;
    int y2 = emptyIndex % 3;
    return (x1 == x2 && (y1 == y2 + 1 || y1 == y2 - 1)) || (y1 == y2 && (x1 == x2 + 1 || x1 == x2 - 1));
  }

  void swapBlockWithEmpty(int i1) {
    if (isAdjacentToEmpty(i1)) {

      int temp = positionList.indexOf(i1);
      positionList.remove(i1); 
      positionList.insert(temp, emptyIndex);
      emptyIndex = i1;
      
      print(positionList);




    }
    notifyListeners();
  }

  List<int> deepCopy(List<int> source) {
  return source.map((e) => e.toInt()).toList();
  }

  void updatePriority() {
    List<int> temp = deepCopy(positionList);
    temp.sort();
    priorityList = temp;
    print(priorityList);
    notifyListeners();
  }
}