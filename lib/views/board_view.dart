// ignore_for_file: prefer_const_constructors

import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:puzzle_hack/controllers/board_controller.dart';
import 'package:puzzle_hack/views/block_view.dart';
import 'package:puzzle_hack/views/widgets/primary_button.dart';

class BoardView extends StatefulWidget {
  const BoardView({
    Key? key,
  }) : super(key: key);

  @override
  State<BoardView> createState() => _BoardViewState();
}

class _BoardViewState extends State<BoardView> {

  @override
  void initState() {
    super.initState();
  }

  List<BlockView> generateBlockViews() {
    List<BlockView> blockViews = [];
    for (int i = 0; i < 9; i++) {
      blockViews.add(BlockView(index: i));
    }
    return blockViews;
  }

  @override
  Widget build(BuildContext _) {
    return ChangeNotifierProvider(
        create: (_) => BoardController(),
        builder: (context, child) {
          if (context.watch<BoardController>().winState) {
            context.read<BoardController>().gameStarted = false;
            context.read<BoardController>().enabled = false;
            context.read<BoardController>().resetBoardController();
          }
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Flexible(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        flex: 3,
                        child: Container(
                          height: MediaQuery.of(context).size.width * 0.15,
                          width: MediaQuery.of(context).size.width * 0.15,
                          color:
                              Color.fromARGB(255, 36, 36, 36).withOpacity(1),
                          child: Center(
                              child: FlareActor("assets/title.flr",
                                  alignment: Alignment.center,
                                  fit: BoxFit.contain,
                                  animation: "title")),
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: Container(
                          color:
                              Color.fromARGB(255, 36, 36, 36).withOpacity(1),
                          child: Center(
                              child: PrimaryButton(
                            text: context.watch<BoardController>().gameStarted
                                ? "STOP"
                                : "START",
                            color: Color.fromARGB(255, 171, 171, 171),
                            onPressed: () {
                              context
                                  .read<BoardController>()
                                  .changeGameState();
                            },
                          )),
                        ),
                      ),
                    ],
                  )),
              Flexible(
                flex: 3,
                child: AbsorbPointer(
                  absorbing: !context.watch<BoardController>().enabled,
                  child: Container(
                    color: Color.fromARGB(255, 36, 36, 36).withOpacity(1),
                    width: 500,
                    height: 500,
                    child: GestureDetector(
                      onTapDown: (TapDownDetails details) async {
                        if (context.read<BoardController>().enabled) {
                          await context
                              .read<BoardController>()
                              .detectAndMove(details.localPosition);
                        }
                      },
                      child: Stack(
                        children: generateBlockViews(),
                      ),
                    ),
                  ),
                ),
              ),
              Flexible(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Flexible(
                        flex: 1,
                        child: Text(
                          "SUMMARY",
                          style: TextStyle(
                            fontSize: 22,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: Text(
                          "\nMoves: ${context.read<BoardController>().movesCount}\nCPs: ${context.read<BoardController>().cps}\n",
                          style: TextStyle(
                            fontSize: 18,
                            color: Color.fromARGB(255, 185, 185, 185),
                          ),
                        ),
                      ),
                    ],
                  )),
            ],
          );
        });
  }
}
