import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
          }, child: Text("Create room")),
        ],
      )),
    );
  }
}
