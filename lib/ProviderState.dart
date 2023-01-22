import 'dart:math';

import 'package:flutter/material.dart';

class providerState extends ChangeNotifier {
  bool shouldshow = true;
  var gameID, entryCode, ticket, playerCounter, playerknown;
  TextEditingController username = new TextEditingController();
  TextEditingController joinGameCodeTextEditing = new TextEditingController();
  List tickets = [];
  List names = [""];
  var Numbers = [];
  int lastNumber = 0;
  bool showinfo = true;
  late String usernameText;

  RandomNumbers() {
    lastNumber = 1 + Random().nextInt(99 - 1);
    print("len:  ${Numbers.length}");
    if (Numbers.contains(lastNumber)) {
      RandomNumbers();
    }
    Numbers.add(lastNumber);
    notifyListeners();
  }
}
