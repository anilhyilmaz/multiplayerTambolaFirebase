import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class providerState extends ChangeNotifier {
  bool shouldshow = true;
  var gameID, entryCode, ticket,playerknown;
  var counter;
  late int playerCounter;
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


  ggg() async {
    var len;
    FirebaseFirestore Firestore = FirebaseFirestore.instance;
    var gamesSnapshots = Firestore.collection("games").snapshots();
    await gamesSnapshots.forEach((element) async {
      len = element.docs.length;
      for (int i = 0; i < len; i++) {
        if (joinGameCodeTextEditing
            .text ==
            await element.docs[i].data()["entryCode"]) {
          print("uyuştu");
          print(element.docs[i].data()["entryCode"]);
          gameID = element.docs[i].id;
          counter = await int.parse(element.docs[i].data()["playerCounter"]);
        }
      }
    });
    notifyListeners();
  }

}
