import 'package:flutter/material.dart';
import 'package:puzzle_hack/views/board_view.dart';
import 'package:responsive_framework/responsive_framework.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) { 
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "HammersmithOne"
      ),
      builder: (context, widget) => ResponsiveWrapper.builder(
          Scaffold(
            backgroundColor: Color.fromARGB(255, 36, 36, 36),
            body:
              BoardView()),
          maxWidth: 2000,
          minWidth: 450,
          defaultScale: true,
          backgroundColor: const Color.fromARGB(255, 36, 36, 36),
          breakpoints: [
            const ResponsiveBreakpoint.resize(480, name: MOBILE),
            const ResponsiveBreakpoint.autoScale(1000, name: TABLET),
            const ResponsiveBreakpoint.autoScale(1740, name: DESKTOP),
            const ResponsiveBreakpoint.autoScale(2460, name: "4K"),
          ],
      )
    );
  }
}
