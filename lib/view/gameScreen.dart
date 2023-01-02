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
              child: FutureBuilder(
                future: Firestore.collection("games")
                    .doc(Provider.of<providerState>(context, listen: false)
                        .gameID)
                    .get(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData &&
                      snapshot.connectionState == ConnectionState.done) {
                    var data = snapshot.data.data();
                    var playerCounter = int.parse(data['playerCounter'])+1;
                    var ticket0 = data['ticket0'];
                    var row0 = ticket0["0"];
                    var row1 = ticket0["1"];
                    var row2 = ticket0["2"];



                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16, top: 32, left: 16, right: 16),
                      child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                    height: MediaQuery. of(context). size. height-72,
                                    width: MediaQuery. of(context). size. width-30,
                                    child: CustomScrollView(
                                      primary: false,
                                      slivers: <Widget>[
                                        SliverPadding(
                                          padding: const EdgeInsets.all(20),
                                          sliver: SliverGrid.count(
                                            crossAxisSpacing: 10,
                                            mainAxisSpacing: 10,
                                            crossAxisCount: 9,
                                            children: <Widget>[
                                              Container(
                                                padding: const EdgeInsets.all(8),
                                                color: Colors.green[100],
                                                child: Text(row0[0].toString()),
                                              ),
                                              Container(
                                                padding: const EdgeInsets.all(8),
                                                color: Colors.green[200],
                                                child: Text(row0[1].toString()),
                                              ),
                                              Container(
                                                padding: const EdgeInsets.all(8),
                                                color: Colors.green[300],
                                                child: Text(row0[2].toString()),
                                              ),
                                              Container(
                                                padding: const EdgeInsets.all(8),
                                                color: Colors.green[300],
                                                child: Text(row0[3].toString()),
                                              ),
                                              Container(
                                                padding: const EdgeInsets.all(8),
                                                color: Colors.green[300],
                                                child: Text(row0[4].toString()),
                                              ),
                                              Container(
                                                padding: const EdgeInsets.all(8),
                                                color: Colors.green[300],
                                                child: Text(row0[5].toString()),
                                              ),
                                              Container(
                                                padding: const EdgeInsets.all(8),
                                                color: Colors.green[300],
                                                child: Text(row0[6].toString()),
                                              ),
                                              Container(
                                                padding: const EdgeInsets.all(8),
                                                color: Colors.green[400],
                                                child: Text(row0[7].toString()),
                                              ),
                                              Container(
                                                padding: const EdgeInsets.all(8),
                                                color: Colors.green[500],
                                                child: Text(row0[8].toString()),
                                              ),
                                              Container(
                                                padding: const EdgeInsets.all(8),
                                                color: Colors.green[600],
                                                child: Text(row1[0].toString()),
                                              ),
                                              Container(
                                                padding: const EdgeInsets.all(8),
                                                color: Colors.green[600],
                                                child: Text(row1[1].toString()),
                                              ),
                                              Container(
                                                padding: const EdgeInsets.all(8),
                                                color: Colors.green[600],
                                                child: Text(row1[2].toString()),
                                              ),
                                              Container(
                                                padding: const EdgeInsets.all(8),
                                                color: Colors.green[600],
                                                child: Text(row1[3].toString()),
                                              ),
                                              Container(
                                                padding: const EdgeInsets.all(8),
                                                color: Colors.green[600],
                                                child: Text(row1[4].toString()),
                                              ),
                                              Container(
                                                padding: const EdgeInsets.all(8),
                                                color: Colors.green[600],
                                                child: Text(row1[5].toString()),
                                              ),
                                              Container(
                                                padding: const EdgeInsets.all(8),
                                                color: Colors.green[600],
                                                child: Text(row1[6].toString()),
                                              ),
                                              Container(
                                                padding: const EdgeInsets.all(8),
                                                color: Colors.green[600],
                                                child: Text(row1[7].toString()),
                                              ),
                                              Container(
                                                padding: const EdgeInsets.all(8),
                                                color: Colors.green[600],
                                                child: Text(row1[8].toString()),
                                              ),
                                              Container(
                                                padding: const EdgeInsets.all(8),
                                                color: Colors.green[600],
                                                child: Text(row2[0].toString()),
                                              ),
                                              Container(
                                                padding: const EdgeInsets.all(8),
                                                color: Colors.green[600],
                                                child: Text(row2[1].toString()),
                                              ),
                                              Container(
                                                padding: const EdgeInsets.all(8),
                                                color: Colors.green[600],
                                                child: Text(row2[2].toString()),
                                              ),
                                              Container(
                                                padding: const EdgeInsets.all(8),
                                                color: Colors.green[600],
                                                child: Text(row2[3].toString()),
                                              ),
                                              Container(
                                                padding: const EdgeInsets.all(8),
                                                color: Colors.green[600],
                                                child: Text(row2[4].toString()),
                                              ),
                                              Container(
                                                padding: const EdgeInsets.all(8),
                                                color: Colors.green[600],
                                                child: Text(row2[5].toString()),
                                              ),
                                              Container(
                                                padding: const EdgeInsets.all(8),
                                                color: Colors.green[600],
                                                child: Text(row2[6].toString()),
                                              ),
                                              Container(
                                                padding: const EdgeInsets.all(8),
                                                color: Colors.green[600],
                                                child: Text(row2[7].toString()),
                                              ),
                                              Container(
                                                padding: const EdgeInsets.all(8),
                                                color: Colors.green[600],
                                                child: Text(row2[8].toString()),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    )
                                ),
                                Container(
                                  child: Text(
                                    "ggg",
                                  ),
                                  height: 200,
                                  width: 200,
                                ),
                                Container(
                                  child: Text(
                                    "ggg",
                                  ),
                                  height: 200,
                                  width: 200,
                                ),
                                Container(
                                  child: Text(
                                    "ggg",
                                  ),
                                  height: 200,
                                  width: 200,
                                ),
                                Container(
                                  child: Text(
                                    "ggg",
                                  ),
                                  height: 200,
                                  width: 200,
                                ),
                                Container(
                                  child: Text(
                                    "ggg",
                                  ),
                                  height: 200,
                                  width: 200,
                                ),
                                Container(
                                  child: Text(
                                    "ggg",
                                  ),
                                  height: 200,
                                  width: 200,
                                ),
                                Container(
                                  child: Text(
                                    "ggg",
                                  ),
                                  height: 200,
                                  width: 200,
                                ),
                              ],
                            ),
                          )),
                    );
                  } else {
                    return Text("Error");
                  }
                },
              ),
            )
          ],
        ),
      ),
    ));
  }
}
