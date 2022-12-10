import 'package:flutter/material.dart';


class providerState extends ChangeNotifier{
  var _count = 2;
  bool shouldshow = true;
  var gameRoomCode;
  TextEditingController username = new TextEditingController();
  var createdRoomCode,id,ticket;
  List tickets = [];

  int get getCounter {
    return _count;
  }
  bool gg(){
    return !shouldshow;
  }
}