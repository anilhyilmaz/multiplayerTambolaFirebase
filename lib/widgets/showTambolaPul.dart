import 'package:flutter/material.dart';



showTambolaPul(int height, int width) {
  return Container(
    height: height.toDouble(),
    width: width.toDouble(),
    child: Stack(alignment: Alignment.center, children: [
      Image.asset("assets/tombalaNumber.png"),
      SizedBox(
        height: (height - 50).toDouble(),
        width: (width - 50).toDouble(),
        child: Center(
          child: Image.asset("assets/0.png"),
        ),
      )
    ]),
  );
}