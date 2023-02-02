import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import '../ProviderState.dart';
import '../utils/ad_helper.dart';
import 'lastNumberTicketScreen.dart';

class gameScreen extends StatefulWidget {
  const gameScreen({super.key});

  @override
  State<gameScreen> createState() => _gameScreenState();
}

class _gameScreenState extends State<gameScreen> {
  FirebaseFirestore Firestore = FirebaseFirestore.instance;
  var playerCounter;
  final AdSize adSize = AdSize(height: 300, width: 50);
  BannerAd? _bannerAd;


  Future<InitializationStatus> _initGoogleMobileAds() {
    // TODO: Initialize Google Mobile Ads SDK
    return MobileAds.instance.initialize();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    _initGoogleMobileAds();
    BannerAd(
      adUnitId: AdHelper.bannerAdUnitId,
      request: AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          setState(() {
            _bannerAd = ad as BannerAd;
          });
        },
        onAdFailedToLoad: (ad, err) {
          print('Failed to load a banner ad: ${err.message}');
          ad.dispose();
        },
      ),
    ).load();
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
                  if(data['playerCounter'] == 0){
                    playerCounter = data['playerCounter'] + 1;
                  }
                  else{
                    playerCounter = int.parse(data['playerCounter']) + 1;
                  }
                  for (int i = 0; i < playerCounter; i++) {
                    playerCounterList.add(i);
                  }

                  return Column(
                    children: [
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Wrap(children: [Row(
                          children: [
                            for (var i in playerCounterList)
                              Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [Ticket(data, i)]),
                          ],
                        )],),
                      ),
                      const lastNumberTicketScreen(),
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

  Widget Ticket(var data, var i) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding:
              const EdgeInsets.only(right: 16, left: 16,bottom: 6),
          child: Container(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 8),
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                border: Border.all(color: Colors.blueAccent)),
            child: Column(
              children: [
                Row(children: [
                  Row(children: [
                    Text("${"owner".tr()}: ${data['player$i']}"),
                  ]),
                  Row(
                    children: [
                      const Icon(
                        Icons.check,
                        color: Colors.pink,
                        size: 24.0,
                        semanticLabel:
                            'Text to announce in accessibility modes',
                      ),
                      StreamBuilder<Object>(
                          stream: Firestore.collection("games").doc(Provider.of<providerState>(context, listen: false).gameID).snapshots(),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return const Text("Loading");
                            } else {
                              return playerknownWidget(snapshot,i);
                            }
                          }),
                    ],
                  )
                ]),
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



  playerknownWidget(snapshot, i){
    return Text(snapshot.data!["player${i}known"].toString());
  }
}
