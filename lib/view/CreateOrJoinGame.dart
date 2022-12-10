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
    var gameRoomCode =
        Provider.of<providerState>(context, listen: false).gameRoomCode;
    FirebaseFirestore Firestore = FirebaseFirestore.instance;


    return Scaffold(
      appBar: AppBar(centerTitle: true,title: Text("Create or Join Game")),
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
              controller: gameRoomCode,
            ),
          ),
          OutlinedButton(onPressed:() {
            //search room code
          }, child: Text("Join room")),
          OutlinedButton(onPressed:() {
            //create room
            creategame();
            // Navigator
            //     .of(context)
            //     .pushReplacement(new MaterialPageRoute(builder: (BuildContext context) => LobbyScreen()));
          }, child: Text("Create room")),
        ],
      )),
    );
  }
  creategame() async {
      var len,id,room,response,roomId;
      FirebaseFirestore Firestore = FirebaseFirestore.instance;
      try {
        id = createRoomID();
        print(id);
        Provider.of<providerState>(context, listen: false).gameRoomCode = id;
        response = await Dio().get('http://10.0.2.2:3000/getTicket/2');
        room = await Firestore.collection("games").add({"roomCode":id});
        roomId = room.id;
        print("0 ${response.data[0]}");
        print("1 ${response.data[1]}");
        for(int i=0;i<2;i++) {
          //Provider.of<providerState>(context, listen: false).tickets.add(response.data[i]);
          for (int j = 0; j < 2; j++) {
            await Firestore.collection("games").doc(roomId).update(
                {"ticket${i}.${j}": response.data[i][j]});
          }
        }
        //var gamesSnapshots = await Firestore.collection("games").snapshots();
        // gamesSnapshots.forEach((element) {
        //   len = element.docs.length;
        // });
        // gamesSnapshots.forEach((element) async {
        //   for(int i=0;i<len;i++){
        //     if(id == await element.docs[i].data()["id"]){
        //       print(element.docs[i].data()["id"]);
        //       Provider
        //           .of<providerState>(context, listen: false)
        //           .id = await element.docs[i].data()["id"];
        //       Navigator.of(context).pushReplacement(MaterialPageRoute(
        //           builder: (BuildContext context) =>  LobbyScreen()));
        //       print("game created");
        //
        //     }
        //   }
        // });
      } catch (e) {
        print(e.toString());
      }
  }
}

