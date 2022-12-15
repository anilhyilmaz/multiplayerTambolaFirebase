import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../ProviderState.dart';
import '../widgets/showTambolaGrid.dart';


class gameScreen extends StatefulWidget {
  const gameScreen({super.key});

  @override
  State<gameScreen> createState() => _gameScreenState();
}

class _gameScreenState extends State<gameScreen> {

  FirebaseFirestore Firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Center(
            child: Column(
              children: [
                Center(
                  child: StreamBuilder<Object>(
                      stream: Firestore.collection("games").doc(Provider.of<providerState>(context, listen: false).gameID).snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return Text("Loading");
                        } else {
                          return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                showTambolaGrid(),
                                // Flexible(
                                //   flex: 1,
                                //   child: showTambolaGrid(),
                                // ),
                              ]);
                        }
                      }),
                )
              ],
            ),
          ),
        ));
  }
}