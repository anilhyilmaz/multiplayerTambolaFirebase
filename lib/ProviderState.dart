import 'dart:math';

import 'package:flutter/material.dart';


class providerState extends ChangeNotifier{
  bool shouldshow = true;
  var gameID,entryCode,ticket,playerCounter;
  TextEditingController username = new TextEditingController();
  TextEditingController joinGameCodeTextEditing = new TextEditingController();
  List tickets = [];
  List names = [""];
  var Numbers = [];

  RandomNumbers() {
    num randomminmax = 1 + Random().nextInt(99-1);
    Numbers.add(randomminmax);
    notifyListeners();
  }
}