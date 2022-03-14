import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class SummaryButton extends StatelessWidget {
  final String? textPrimary;
  final String? textSecondary;
  final String? counts;
  final VoidCallback? onPressed;

  SummaryButton({Key? key, @required this.textPrimary, @required this.textSecondary, @required this.counts, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onPressed ?? () {},
        child: Neumorphic(
            style: NeumorphicStyle(
              shape: NeumorphicShape.concave,
              boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
              depth: 3,
              lightSource: LightSource.topLeft,
              intensity: 2,
              // color:Color(0xff1a1a22).withOpacity(0.32),
              color: Colors.transparent,
              shadowDarkColor: Colors.transparent.withOpacity(0.55),
              shadowLightColor: Color.fromRGBO(Colors.transparent.red - 1, Colors.transparent.green - 1, Colors.transparent.blue - 1, 0.3),
            ),
            child: Container(
              width: 180,
              height: 60,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(child: Text(textPrimary!, style: const TextStyle(color: Colors.white, fontSize: 12))),
                      Flexible(child: Text(textSecondary!, style: const TextStyle(color: Colors.white, fontSize: 20))),
                    ],
                  ),
                  Flexible(child: Text(counts!, style: const TextStyle(color: Colors.white, fontSize: 22)))
                ],
              ),
            )));
  }
}
