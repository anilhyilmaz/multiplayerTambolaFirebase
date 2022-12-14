import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../ProviderState.dart';

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
            FutureBuilder(
              future: Firestore.collection("games")
                  .doc(
                      Provider.of<providerState>(context, listen: false).gameID)
                  .get(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData &&
                    snapshot.connectionState == ConnectionState.done) {
                  var data = snapshot.data.data();
                  List<int> playerCounterList = [];
                  List<int> one = [1];
                  var playerCounter = int.parse(data['playerCounter']) + 1;
                  for (int i = 0; i < playerCounter; i++) {
                    playerCounterList.add(i);
                  }

                  return Column(
                    children: [
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Expanded(
                            child: Row(
                          children: [
                            for (var i in playerCounterList)
                              Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [Ticket(data, i)]),
                          ],
                        )),
                      ),
                  lastNumberWidget(),
                    ],
                  );
                } else {
                  return const Text("Error");
                }
              },
            )
          ],
        ),
      ),
    ));
  }

  Widget lastNumberWidget() {
    return StreamBuilder<Object>(
        stream: Firestore.collection("games")
            .doc(Provider.of<providerState>(context, listen: false).gameID)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return const Text("Loading");
          } else {
            return Row(children: [
              Padding(
                padding: const EdgeInsets.only(left: 32, right: 16),
                child: GestureDetector(
                    child: Text("Pick Number"),
                    onTap: () async => {
                          print("f"),
                          Provider.of<providerState>(context, listen: false)
                              .RandomNumbers(),
                          print(
                              Provider.of<providerState>(context, listen: false)
                                  .lastNumber),
                          await Firestore.collection("games")
                              .doc(Provider.of<providerState>(context,
                                      listen: false)
                                  .gameID)
                              .update({
                            "lastnumber": Provider.of<providerState>(context,
                                    listen: false)
                                .lastNumber
                          }),
                        }),
              ),
              Expanded(
                child: Text("Numbers: ${snapshot.data!["lastnumber"]} "),
              )
            ]);
          }
        });
  }

  Widget Ticket(var data, var i) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding:
              const EdgeInsets.only(right: 16, left: 16, top: 4, bottom: 16),
          child: Container(
            padding: EdgeInsets.only(left: 16, right: 16, top: 8),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                border: Border.all(color: Colors.blueAccent)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  child: Text(data['player$i']),
                ),
                Container(
                    alignment: Alignment.center,
                    height: MediaQuery.of(context).size.height - 120,
                    width: MediaQuery.of(context).size.width,
                    child: CustomScrollView(
                      slivers: <Widget>[
                        SliverPadding(
                          padding: const EdgeInsets.only(
                              left: 16, right: 32, top: 12, bottom: 0),
                          sliver: SliverGrid.count(
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            crossAxisCount: 9,
                            children: <Widget>[
                              Container(
                                padding: const EdgeInsets.all(8),
                                color: Colors.white,
                                child: Center(
                                  child: Text(
                                      data['ticket$i']["0"][0] == 0
                                          ? ""
                                          : data['ticket$i']["0"][0].toString(),
                                      textAlign: TextAlign.center),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.all(8),
                                color: Colors.orange,
                                child: Center(
                                  child: Text(data['ticket$i']["0"][1] == 0
                                      ? ""
                                      : data['ticket$i']["0"][1].toString()),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.all(8),
                                color: Colors.white,
                                child: Center(
                                  child: Text(data['ticket$i']["0"][2] == 0
                                      ? ""
                                      : data['ticket$i']["0"][2].toString()),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.all(8),
                                color: Colors.orange,
                                child: Center(
                                  child: Text(
                                    data['ticket$i']["0"][3] == 0
                                        ? ""
                                        : data['ticket$i']["0"][3].toString(),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                              Container(
                                  padding: const EdgeInsets.all(8),
                                  color: Colors.white,
                                  child: Center(
                                    child: Text(data['ticket$i']["0"][4] == 0
                                        ? ""
                                        : data['ticket$i']["0"][4].toString()),
                                  )),
                              Container(
                                padding: const EdgeInsets.all(8),
                                color: Colors.orange,
                                child: Center(
                                  child: Text(data['ticket$i']["0"][5] == 0
                                      ? ""
                                      : data['ticket$i']["0"][5].toString()),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.all(8),
                                color: Colors.white,
                                child: Center(
                                    child: Text(data['ticket$i']["0"][6] == 0
                                        ? ""
                                        : data['ticket$i']["0"][6].toString())),
                              ),
                              Container(
                                padding: const EdgeInsets.all(8),
                                color: Colors.orange,
                                child: Center(
                                    child: Text(data['ticket$i']["0"][7] == 0
                                        ? ""
                                        : data['ticket$i']["0"][7].toString())),
                              ),
                              Container(
                                padding: const EdgeInsets.all(8),
                                color: Colors.white,
                                child: Center(
                                    child: Text(data['ticket$i']["0"][8] == 0
                                        ? ""
                                        : data['ticket$i']["0"][8].toString())),
                              ),
                              Container(
                                padding: const EdgeInsets.all(8),
                                color: Colors.orange,
                                child: Center(
                                    child: Text(data['ticket$i']["1"][0] == 0
                                        ? ""
                                        : data['ticket$i']["1"][0].toString())),
                              ),
                              Container(
                                padding: const EdgeInsets.all(8),
                                color: Colors.white,
                                child: Center(
                                    child: Text(data['ticket$i']["1"][1] == 0
                                        ? ""
                                        : data['ticket$i']["1"][1].toString())),
                              ),
                              Container(
                                padding: const EdgeInsets.all(8),
                                color: Colors.orange,
                                child: Center(
                                    child: Text(data['ticket$i']["1"][2] == 0
                                        ? ""
                                        : data['ticket$i']["1"][2].toString())),
                              ),
                              Container(
                                padding: const EdgeInsets.all(8),
                                color: Colors.white,
                                child: Center(
                                    child: Text(data['ticket$i']["1"][3] == 0
                                        ? ""
                                        : data['ticket$i']["1"][3].toString())),
                              ),
                              Container(
                                padding: const EdgeInsets.all(8),
                                color: Colors.orange,
                                child: Center(
                                    child: Text(data['ticket$i']["1"][4] == 0
                                        ? ""
                                        : data['ticket$i']["1"][4].toString())),
                              ),
                              Container(
                                padding: const EdgeInsets.all(8),
                                color: Colors.white,
                                child: Center(
                                    child: Text(data['ticket$i']["1"][5] == 0
                                        ? ""
                                        : data['ticket$i']["1"][5].toString())),
                              ),
                              Container(
                                padding: const EdgeInsets.all(8),
                                color: Colors.orange,
                                child: Center(
                                    child: Text(data['ticket$i']["1"][6] == 0
                                        ? ""
                                        : data['ticket$i']["1"][6].toString())),
                              ),
                              Container(
                                padding: const EdgeInsets.all(8),
                                color: Colors.white,
                                child: Center(
                                    child: Text(data['ticket$i']["1"][7] == 0
                                        ? ""
                                        : data['ticket$i']["1"][7].toString())),
                              ),
                              Container(
                                padding: const EdgeInsets.all(8),
                                color: Colors.orange,
                                child: Center(
                                    child: Text(data['ticket$i']["1"][8] == 0
                                        ? ""
                                        : data['ticket$i']["1"][8].toString())),
                              ),
                              Container(
                                padding: const EdgeInsets.all(8),
                                color: Colors.white,
                                child: Center(
                                    child: Text(data['ticket$i']["2"][0] == 0
                                        ? ""
                                        : data['ticket$i']["2"][0].toString())),
                              ),
                              Container(
                                padding: const EdgeInsets.all(8),
                                color: Colors.orange,
                                child: Center(
                                    child: Text(data['ticket$i']["2"][1] == 0
                                        ? ""
                                        : data['ticket$i']["2"][1].toString())),
                              ),
                              Container(
                                padding: const EdgeInsets.all(8),
                                color: Colors.white,
                                child: Center(
                                    child: Text(data['ticket$i']["2"][2] == 0
                                        ? ""
                                        : data['ticket$i']["2"][2].toString())),
                              ),
                              Container(
                                padding: const EdgeInsets.all(8),
                                color: Colors.orange,
                                child: Center(
                                    child: Text(data['ticket$i']["2"][3] == 0
                                        ? ""
                                        : data['ticket$i']["2"][3].toString())),
                              ),
                              Container(
                                padding: const EdgeInsets.all(8),
                                color: Colors.white,
                                child: Center(
                                    child: Text(data['ticket$i']["2"][4] == 0
                                        ? ""
                                        : data['ticket$i']["2"][4].toString())),
                              ),
                              Container(
                                padding: const EdgeInsets.all(8),
                                color: Colors.orange,
                                child: Center(
                                    child: Text(data['ticket$i']["2"][5] == 0
                                        ? ""
                                        : data['ticket$i']["2"][5].toString())),
                              ),
                              Container(
                                padding: const EdgeInsets.all(8),
                                color: Colors.white,
                                child: Center(
                                    child: Text(data['ticket$i']["2"][6] == 0
                                        ? ""
                                        : data['ticket$i']["2"][6].toString())),
                              ),
                              Container(
                                padding: const EdgeInsets.all(8),
                                color: Colors.orange,
                                child: Center(
                                    child: Text(data['ticket$i']["2"][7] == 0
                                        ? ""
                                        : data['ticket$i']["2"][7].toString())),
                              ),
                              Container(
                                padding: const EdgeInsets.all(8),
                                color: Colors.white,
                                child: Center(
                                    child: Text(data['ticket$i']["2"][8] == 0
                                        ? ""
                                        : data['ticket$i']["2"][8].toString())),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
