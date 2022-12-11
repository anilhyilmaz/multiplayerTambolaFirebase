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
      var response;
      FirebaseFirestore Firestore = FirebaseFirestore.instance;
      try {
        Provider.of<providerState>(context, listen: false).entryCode = createRoomID();
        print(Provider.of<providerState>(context, listen: false).entryCode);
        response = await Dio().get('http://10.0.2.2:3000/getTicket/2');
        gameid = await Firestore.collection("games").add({
          "owner":username.text,
          "entryCode": Provider.of<providerState>(context, listen: false).entryCode
        });
        Provider.of<providerState>(context, listen: false).gameID = gameid.id;
        print("0 ${response.data[0]}");
        print("1 ${response.data[1]}");
        for (int i = 0; i < 2; i++) {
          for (int j = 0; j < 3; j++) {
            await Firestore.collection("games")
                .doc(Provider.of<providerState>(context, listen: false).gameID)
                .update({"ticket${i}.${j}": response.data[i][j]});
          }
        }
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => LobbyScreen()));
        print("game created");
      } catch (e) {
        print(e.toString());
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
              controller: Provider.of<providerState>(context, listen: false).entryCode,
            ),
          ),
          OutlinedButton(
              onPressed: () {
                //search room code
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
