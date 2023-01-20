import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../ProviderState.dart';

class lastNumberTicketScreen extends StatefulWidget {
  const lastNumberTicketScreen({Key? key}) : super(key: key);

  @override
  State<lastNumberTicketScreen> createState() => _lastNumberTicketScreenState();
}

class _lastNumberTicketScreenState extends State<lastNumberTicketScreen> {
  @override
  Widget build(BuildContext context) {
    FirebaseFirestore Firestore = FirebaseFirestore.instance;
    var a;

    return StreamBuilder<Object>(
        stream: Firestore.collection("games")
            .doc(Provider.of<providerState>(context, listen: false).gameID)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return const Text("Loading");
          } else {
            return Wrap(
              children: [
                Row(children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 32, right: 16),
                    child: GestureDetector(
                        child: Text("Pick Number"),
                        onTap: () async => {
                              Provider.of<providerState>(context, listen: false)
                                  .RandomNumbers(),
                              print(Provider.of<providerState>(context,
                                      listen: false)
                                  .lastNumber),
                              await Firestore.collection("games")
                                  .doc(Provider.of<providerState>(context,
                                          listen: false)
                                      .gameID)
                                  .update({
                                "lastnumber": Provider.of<providerState>(
                                        context,
                                        listen: false)
                                    .lastNumber
                              }),
                              ////////////////////////////////////////////////////////////

                              for (int j = 0;
                                  j < int.parse(snapshot.data!["playerCounter"]) + 1;
                                  j++)
                                {
                                  print(await snapshot.data["ticket$j"]),
                                  a = await snapshot.data["ticket$j"],
                                for (var key in a.keys) {
                                for (var value in a[key]) {
                                  if(value == Provider.of<providerState>(context, listen: false).lastNumber){
                                    Provider.of<providerState>(context, listen: false).playerknown = await snapshot.data["player${j}known"],
                                    Provider.of<providerState>(context, listen: false).playerknown++,
                                    print("bildi $j"),
                                    await Firestore.collection("games")
                                        .doc(Provider.of<providerState>(context, listen: false).gameID)
                                        .update({
                                      "player${j}known":
                                      Provider.of<providerState>(context, listen: false).playerknown
                                    })
                                  }
                                }
                                }
                                }
                            }),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text("Numbers: ${snapshot.data!["lastnumber"]} "),
                  )
                ])
              ],
            );
          }
        });
  }
}
