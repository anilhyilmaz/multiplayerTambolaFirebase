import 'package:flutter/material.dart';


class providerState extends ChangeNotifier{
  bool shouldshow = true;
  var gameID,entryCode,ticket;
  TextEditingController username = new TextEditingController();
  List tickets = [];

  bool gg(){
    return !shouldshow;
  }
}