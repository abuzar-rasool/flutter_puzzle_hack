// ignore_for_file: prefer_const_constructors

import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:puzzle_hack/constants.dart';
import 'package:puzzle_hack/controllers/board_controller.dart';
import 'package:puzzle_hack/views/block_view.dart';
import 'package:puzzle_hack/views/widgets/primary_button.dart';
import 'package:responsive_framework/responsive_row_column.dart';
import 'package:responsive_framework/responsive_value.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:responsive_framework/utils/responsive_utils.dart';

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
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => BoardController(context: context),
        builder: (context, child) {
          if (!context.watch<BoardController>().dataLoaded) {
            return Center(
              child: Hero(
                tag: 'logo',
                child: SizedBox(
                  width: MediaQuery.of(context).size.height * 0.30,
                  child: Center(child: FlareActor("assets/title.flr", alignment: Alignment.center, fit: BoxFit.contain, animation: "title")),
                ),
              ),
            );
          }
          if (context.watch<BoardController>().winState) {
            context.read<BoardController>().gameStarted = false;
            context.read<BoardController>().enabled = false;
            context.read<BoardController>().resetBoardController();
          }
          return Column(
            children: [
              Flexible(
                flex: 1,
                child: Hero(
                  tag: "logo",
                  child: SizedBox(
                    width: MediaQuery.of(context).size.height * 0.30,
                    child: Center(child: FlareActor("assets/title.flr", alignment: Alignment.center, fit: BoxFit.contain, animation: "title")),
                  ),
                ),
              ),
              Flexible(
                flex: 3,
                child: Center(
                  child: Transform.scale(
                    scale: context.watch<BoardController>().getBoardScale(context),
                    child: AbsorbPointer(
                      absorbing: !context.watch<BoardController>().enabled,
                      child: Container(
                        alignment: Alignment.center,
                        width: kBoardSize.width,
                        height: kBoardSize.height,
                        child: GestureDetector(
                          onTapDown: (TapDownDetails details) async {
                            if (context.read<BoardController>().enabled) {
                              await context.read<BoardController>().detectAndMove(details.localPosition);
                            }
                          },
                          child: Stack(
                            children: generateBlockViews(),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Flexible(
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
