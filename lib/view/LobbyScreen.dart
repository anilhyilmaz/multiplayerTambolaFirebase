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

    var createdRoomCode =
        Provider.of<providerState>(context, listen: false).createdRoomCode;

    return Scaffold(appBar: AppBar(title: Text("Lobby")),body: Center(child: Column(
      children: [
        Text("Room Code: $createdRoomCode"),
        Text("Lobby"),
      ],
    )),);
  }
}
