import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class providerState extends ChangeNotifier {
  bool shouldshow = true, checkedCode = false;
  bool isvalidCode = false;
  var gameID, entryCode, ticket, playerknown;
  late int counter;
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

  checkCode() async {
    var len;
    FirebaseFirestore Firestore = FirebaseFirestore.instance;
    var gamesSnapshots = Firestore.collection("games").snapshots();
    gamesSnapshots.forEach((element) async {
      len = element.docs.length;
      for (int i = 0; i < len; i++) {
        if (joinGameCodeTextEditing.text ==
                await element.docs[i].data()["entryCode"] &&
            element.docs[i].data()["isgameStarted"] == false) {
          print("uyuştu");
          isvalidCode = true;
          print(await element.docs[i].data()["entryCode"]);
          gameID = await element.docs[i].id;
          counter = await int.parse(element.docs[i].data()["playerCounter"]);
        } else {
          print("invalid");
        }
      }
    });
    notifyListeners();
  }

  g() {
    FirebaseFirestore Firestore = FirebaseFirestore.instance;
    print(counter.toString());
    counter++;
    print(counter.toString());
    print(gameID);
    Firestore.collection("games").doc(gameID).update({
      "player${counter}known": 0,
      "player${counter}": username.text,
      "playerCounter": "${counter}"
    });
    print("eklendi");
    notifyListeners();
  }
}
