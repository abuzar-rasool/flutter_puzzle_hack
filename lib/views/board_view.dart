// ignore_for_file: prefer_const_constructors

import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:puzzle_hack/constants.dart';
import 'package:puzzle_hack/controllers/board_controller.dart';
import 'package:puzzle_hack/views/block_view.dart';
import 'package:puzzle_hack/views/widgets/primary_button.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

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
            return AlertDialog(
                backgroundColor: Color(0xff1a1a22).withOpacity(0.6),
                title: Text(
                  "Good Job! You Win!",
                  style: TextStyle(color: Colors.white),
                ),
                content: Text(
                  "You solved the puzzle! Tap the button to play again.",
                  style: TextStyle(color: Colors.white),
                ),
                actions: [
                  TextButton(
                    child: Text(
                      "Play Again",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      context.read<BoardController>().resetBoardController();
                      // Navigator.pop(context);
                    },
                  )
                ]);
            // context.read<BoardController>().resetBoardController();
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
                    scale: context.read<BoardController>().getBoardScale(context),
                    child: AbsorbPointer(
                      absorbing: !context.watch<BoardController>().enabled,
                      child: Container(
                        alignment: Alignment.center,
                        width: kBoardSize.width,
                        height: kBoardSize.height,
                        child: MouseRegion(
                          onHover: (event) => context.read<BoardController>().onHover(event.localPosition),
                          child: GestureDetector(
                            onTapDown: (TapDownDetails details) async {
                              if (context.read<BoardController>().enabled) {
                                await context.read<BoardController>().detectAndMove(details.localPosition);
                              }
                            },
                            child: Stack(
                              clipBehavior: Clip.none,
                              fit: StackFit.expand,
                              children: generateBlockViews(),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                // height: 80,
                padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.035, horizontal: 8),
                child: Wrap(
                  alignment: WrapAlignment.center,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  runAlignment: WrapAlignment.center,
                  children: [
                    SummaryButton(
                      textPrimary: "TOTAL",
                      textSecondary: "MOVES",
                      counts: context.read<BoardController>().movesCount.toString(),
                    ),
                    SizedBox(width: 20),
                    Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.contain,
                          image: NetworkImage(kImages['solved']),
                        ),
                      ),
                    ),
                    SizedBox(width: 20),
                    SummaryButton(
                      textPrimary: "CORRECT",
                      textSecondary: "POSITIONS",
                      counts: context.read<BoardController>().cps.toString(),
                    ),
                  ],
                ),
              ),
            ],
          );
        });
  }
}
