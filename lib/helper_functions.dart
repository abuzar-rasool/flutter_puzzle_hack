import 'dart:math';

import 'package:flutter/material.dart';

class HelperFunctions{
  static Color randomColor(){
    return Color.fromARGB(255, Random().nextInt(255), Random().nextInt(255), Random().nextInt(255));
  }
}