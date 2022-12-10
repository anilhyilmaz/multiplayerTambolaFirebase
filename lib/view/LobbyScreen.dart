import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../ProviderState.dart';


class LobbyScreen extends StatefulWidget {
  const LobbyScreen({Key? key}) : super(key: key);

  @override
  State<LobbyScreen> createState() => _LobbyScreenState();
}

class _LobbyScreenState extends State<LobbyScreen> {

  @override
  Widget build(BuildContext context) {

    var createdRoomCode =
        Provider.of<providerState>(context, listen: false).createdRoomCode;
    FirebaseFirestore Firestore = FirebaseFirestore.instance;


    return Scaffold(appBar: AppBar(title: Text("Lobby")),body: Center(child: Column(
      children: [
        Text("Room Code: $createdRoomCode"),
        Text("Lobby"),
        Flexible(
          flex: 8,
          child: StreamBuilder(
              stream:
              Firestore.collection("games").doc(createdRoomCode).snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Text(
                    'Loading',
                  );
                } else {
                  return Column(
                    children: [
                      Text("${Provider.of<providerState>(context, listen: false).ticket}")
                    ],
                  );
                }
              }),
        ),
      ],
    )),);
  }
}
