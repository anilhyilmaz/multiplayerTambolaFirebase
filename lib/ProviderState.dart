import 'dart:math';

import 'package:flutter/material.dart';


class providerState extends ChangeNotifier{
  bool shouldshow = true;
  var gameID,entryCode,ticket,playerCounter,playerknown;
  TextEditingController username = new TextEditingController();
  TextEditingController joinGameCodeTextEditing = new TextEditingController();
  List tickets = [];
  List names = [""];
  var Numbers = [];
  int lastNumber = 0;

  RandomNumbers() {
    lastNumber = 1 + Random().nextInt(99-1);
    for(int i=0;i<Numbers.length;i++){
      if(Numbers.contains(lastNumber)){
        lastNumber = 1 + Random().nextInt(99-1);
      }
      else{
        break;
      }
      Numbers.add(lastNumber);
    }
    notifyListeners();
  }
}