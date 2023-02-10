import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tombalaonline/utils/RandomCode.dart';
import 'package:tombalaonline/view/LobbyScreen.dart';
import '../ProviderState.dart';
import 'package:firebase_database/firebase_database.dart';

class CreateOrJoinGame extends StatefulWidget {
  const CreateOrJoinGame({Key? key}) : super(key: key);

  @override
  State<CreateOrJoinGame> createState() => _CreateOrJoinGameState();
}

class _CreateOrJoinGameState extends State<CreateOrJoinGame> {
  @override
  Widget build(BuildContext context) {
    var username = Provider.of<providerState>(context, listen: false).username;
    var gameid, counter;
    final FirebaseDatabase database = FirebaseDatabase.instance;
    FirebaseFirestore Firestore = FirebaseFirestore.instance;

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
          "playerCounter": "0",
          "isgamefinished": false,
          "isgameStarted": false,
          "player0known": 0,
          "lastnumber": "",
          "owner":
              Provider.of<providerState>(context, listen: false).usernameText,
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
        await Provider.of<providerState>(context, listen: false).checkCode();
        await Future.delayed(Duration(seconds: 3));
        if(Provider.of<providerState>(context, listen: false).isvalidCode == true){
          await Future.delayed(Duration(milliseconds: 800), () async {
            await Provider.of<providerState>(context, listen: false).g();
          });
        }
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => LobbyScreen()));
      }
    }

    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text("createorjoingame".tr())),
      body: Center(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(hintText: "typeRoomCode".tr()),
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
              child:
                  Provider.of<providerState>(context, listen: false).checkedCode
                      ? Text("joinroom".tr())
                      : Text("validcode".tr())),
          OutlinedButton(
              onPressed: () {
                //create room
                creategame();
              },
              child: Text("createRoom".tr())),
        ],
      )),
    );
  }
}
