import 'package:flutter/material.dart';


class providerState extends ChangeNotifier{
  bool shouldshow = true;
  var gameID,entryCode,ticket,playerCounter;
  TextEditingController username = new TextEditingController();
  TextEditingController joinGameCodeTextEditing = new TextEditingController();
  List tickets = [];
  List names = [""];

  bool gg(){
    return !shouldshow;
  }
}