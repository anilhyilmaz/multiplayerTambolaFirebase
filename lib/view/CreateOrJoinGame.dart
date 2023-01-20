import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tombalaonline/utils/RandomCode.dart';
import 'package:tombalaonline/view/LobbyScreen.dart';
import '../ProviderState.dart';

class CreateOrJoinGame extends StatefulWidget {
  const CreateOrJoinGame({Key? key}) : super(key: key);

  @override
  State<CreateOrJoinGame> createState() => _CreateOrJoinGameState();
}

class _CreateOrJoinGameState extends State<CreateOrJoinGame> {
  @override
  Widget build(BuildContext context) {
    var username = Provider.of<providerState>(context, listen: false).username;
    var gameid;

    creategame() async {
      FirebaseFirestore Firestore = FirebaseFirestore.instance;
      try {
        Provider.of<providerState>(context, listen: false).entryCode =
            createRoomID();
        print(Provider.of<providerState>(context, listen: false).entryCode);
        // response = await Dio().get('http://10.0.2.2:3000/getTicket/2');
        gameid = await Firestore.collection("games").add({
          "player0": username.text,
          "entryCode":
              Provider.of<providerState>(context, listen: false).entryCode,
          "playerCounter":0,
          "isgameStarted":false,
          "player0known":0,
          "lastnumber":"",
        });
        Provider.of<providerState>(context, listen: false).gameID = gameid.id;
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => LobbyScreen()));
        print("game created");
      } catch (e) {
        print(e.toString());
      }
    }
    joingame() async {
      if (mounted) {
        print("joined");
        var len,counter;
        FirebaseFirestore Firestore = FirebaseFirestore.instance;
        var gamesSnapshots = Firestore.collection("games").snapshots();
        await gamesSnapshots.forEach((element) async {
          len = element.docs.length;
          for (int i = 0; i < len; i++) {
            if (Provider.of<providerState>(context, listen: false)
                    .joinGameCodeTextEditing
                    .text ==
                await element.docs[i].data()["entryCode"]) {
              print("uyuştu");
              print(element.docs[i].data()["entryCode"]);
              Provider.of<providerState>(context, listen: false).gameID =
                  element.docs[i].id;
              counter = await element.docs[i].data()["playerCounter"];
              counter++;
              await Firestore.collection("games")
                  .doc(Provider.of<providerState>(context, listen: false).gameID)
                  .update({"player${counter}known":0,
                "player${counter}":Provider.of<providerState>(context, listen: false).username.text,
                "playerCounter":"${counter}"
              });
              print("eklendi");
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (BuildContext context) => LobbyScreen()));
            }
            else{
              print("uyuşmadı");
            }
          }
        });
      }
    }

    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text("Create or Join Game")),
      body: Center(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(hintText: "Type room code"),
              textAlign: TextAlign.center,
              controller: Provider.of<providerState>(context, listen: false)
                  .joinGameCodeTextEditing,
            ),
          ),
          OutlinedButton(
              onPressed: () {
                //search room code
                joingame();
              },
              child: Text("Join room")),
          OutlinedButton(
              onPressed: () {
                //create room
                creategame();
              },
              child: Text("Create room")),
        ],
      )),
    );
  }
}
