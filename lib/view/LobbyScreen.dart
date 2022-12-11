import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../ProviderState.dart';

class LobbyScreen extends StatefulWidget {
  const LobbyScreen({Key? key}) : super(key: key);

  @override
  State<LobbyScreen> createState() => _LobbyScreenState();
}

class _LobbyScreenState extends State<LobbyScreen> {
  @override
  Widget build(BuildContext context) {
    FirebaseFirestore Firestore = FirebaseFirestore.instance;
    var gameID =
        Provider.of<providerState>(context, listen: false).gameID;

    return Scaffold(
      appBar: AppBar(title: Text("Waiting Room")),
      body: (Center(
        child: StreamBuilder<Object>(
            stream: Firestore.collection("games").doc(gameID).snapshots(),
            builder: (context, snapshot) {
              if(!snapshot.hasData){
                return Text("Loading");
              }
              else{
                return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      entryCode(snapshot),
                      owner(snapshot),
                      players(snapshot),
                    ]);
              }
            }),
      )),
    );
  }

  entryCode(snapshot){
    return Text("Entry Code:" + snapshot.data!["entryCode"]);
  }
  owner(snapshot){
    return Text("Owner: " + snapshot.data!["owner"]);
  }
  players(snapshot){
    return Text("Players: ");
  }
}