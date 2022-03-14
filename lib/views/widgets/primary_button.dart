import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final String? text;
  final Color? color;
  final VoidCallback? onPressed;
  
  const PrimaryButton({Key? key, @required this.text, @required this.color, @required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed!,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Text(text!, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
        decoration: BoxDecoration(
          color: color!,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(255, 32, 26, 56).withOpacity(1),
              spreadRadius: 1,
              blurRadius: 3,
              offset: const Offset(0, 0), // changes position of shadow
            ),
          ],
        ),
      ),
    );
  }
}