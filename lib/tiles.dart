import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:puzzle_hack/block.dart';
import 'package:puzzle_hack/constants.dart';
import 'package:puzzle_hack/state_provider.dart';

class Tiles extends StatefulWidget {
  const Tiles({ Key? key }) : super(key: key);

  @override
  _TilesState createState() => _TilesState();
}

class _TilesState extends State<Tiles> {
  
  late Size boardSize;
  late Offset center;
  late Offset init;
  late Offset offset;
  late List<Block> blocks;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<int> posList =  context.watch<PuzzleState>().positionList;
    List<int> priorityList = context.watch<PuzzleState>().priorityList;
    int emptyIndex = context.watch<PuzzleState>().emptyIndex;

    List<Block> main = [Block(index: 0), Block(index: 1), Block(index: 2), Block(index: 3), Block(index: 4), Block(index: 5), Block(index: 6), Block(index: 7)];
    for (int i = 0; i < posList.length; i++) {
      // print(priorityList.indexOf(priorityList[i]));
      main[posList.indexOf(posList[i])] = Block(index: posList[i]);
    }
    
    main.sort((e1, e2) => e1.index.compareTo(e2.index));

    int c = -1;
    print("updated");
    return Center(
      child: Container(
        width: 500,
        height: 500,
        child: Stack(
          children: [
            Block(index: 0),
          ],
        ),
      ),
    );
  }
}
