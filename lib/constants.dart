
import 'package:flutter/material.dart';

const Size imageSize = Size(150, 95);
const Size boardSize = Size(500, 500);
const center =  Offset(250, 250);
Offset init = Offset(center.dx - imageSize.width / 2, center.dy - imageSize.height / 2);
Offset offset = Offset(imageSize.width - 2, imageSize.height - 9);


List<Offset> blockOffsets = [
      // first row
      Offset(init.dx, init.dy - offset.dy),
      Offset(init.dx + offset.dx / 2, init.dy - offset.dy / 2),
      Offset(init.dx + offset.dx, init.dy),
      //second row
      Offset(init.dx - offset.dx / 2, init.dy - offset.dy / 2),
      Offset(init.dx, init.dy),
      Offset(init.dx + offset.dx / 2, init.dy + offset.dy / 2),
      //thrid row
      Offset(init.dx - offset.dx, init.dy),
      Offset(init.dx - offset.dx / 2, init.dy + offset.dy / 2),
      Offset(init.dx, init.dy + offset.dy),
    ];