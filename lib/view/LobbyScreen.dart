import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tombalaonline/view/gameScreen.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../ProviderState.dart';
import '../utils/ad_helper.dart';

class LobbyScreen extends StatefulWidget {
  const LobbyScreen({Key? key}) : super(key: key);

  @override
  State<LobbyScreen> createState() => _LobbyScreenState();
}

Timer? timer;

class _LobbyScreenState extends State<LobbyScreen> {
  var outsnapshot;
  final AdSize adSize = AdSize(height: 300, width: 50);
  BannerAd? _bannerAd;
  @override
  void initState() {
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
    super.initState();
    timer = Timer.periodic(
        Duration(seconds: 5), (Timer t) => checkIfGameStarted(outsnapshot));
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  Future<InitializationStatus> _initGoogleMobileAds() {
    // TODO: Initialize Google Mobile Ads SDK
    return MobileAds.instance.initialize();
  }



  @override
  Widget build(BuildContext context) {
    FirebaseFirestore Firestore = FirebaseFirestore.instance;
    var gameID = Provider.of<providerState>(context, listen: false).gameID;

    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text("lobbyscreen".tr())),
      body: (Center(
        child: Flexible(
          child: StreamBuilder<Object>(
              stream: Firestore.collection("games").doc(gameID).snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Text("Loading");
                } else {
                  return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Flexible(
                          flex: 1,
                          child: entryCode(snapshot),
                        ),
                        Flexible(
                          flex: 1,
                          child: owner(snapshot),
                        ),
                        Flexible(
                          flex: 1,
                          child: playersCounter(snapshot),
                        ),
                        Flexible(
                            flex: 1,
                            child: OutlinedButton(
                                onPressed: () async {
                                  startgame(snapshot);
                                },
                                child: Text("startgame".tr()))),
                        if (_bannerAd != null)
                          Flexible(flex: 2,child: Align(
                            child: Container(
                              width: _bannerAd!.size.width.toDouble(),
                              height: _bannerAd!.size.height.toDouble(),
                              child: AdWidget(ad: _bannerAd!),
                            ),
                          ),)
                      ]);
                }
              }),
        ),
      )),
    );
  }

  entryCode(snapshot) {
    outsnapshot = snapshot;
    return Text("entryCode".tr() + ":" + "${snapshot.data!["entryCode"]}");
  }

  owner(snapshot) {
    return Text("owner".tr() + ":" + "${snapshot.data!["player0"]}");
  }

  playersCounter(snapshot) {
    return Text(snapshot.data!["playerCounter"].toString() +
        " " +
        "playerWaiting".tr());
  }

  checkIfGameStarted(outsnapshot) {
    var started = outsnapshot.data!["isgameStarted"];
    started == true
        ? Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => const gameScreen()))
        : null;
  }

  startgame(snapshot) async {
    if(snapshot.data!["owner"] == Provider.of<providerState>(context, listen: false).usernameText){
      print("dogru");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('snackbartrue'.tr()),
      ));
      //create start game
      var response, counter;
      FirebaseFirestore Firestore = FirebaseFirestore.instance;
      ///////////////////////////
      if (snapshot.data["playerCounter"] == 0) {
        counter = snapshot.data!["playerCounter"];
      } else {
        counter = int.parse(snapshot.data!["playerCounter"]);
      }
      /////////////////////
      counter++;
      response = await Dio()
          .get("https://tombalaapiweb.onrender.com/getTicket/$counter");
      print(response);
      for (int i = 0; i < counter; i++) {
        for (int j = 0; j < 3; j++) {
          await Firestore.collection("games")
              .doc(Provider.of<providerState>(context, listen: false).gameID)
              .update({"ticket${i}.${j}": response.data[i][j]});
        }
      }
      await Firestore.collection("games")
          .doc(Provider.of<providerState>(context, listen: false).gameID)
          .update({"isgameStarted": true});
      // Navigator.of(context).pushReplacement(
      //     MaterialPageRoute(builder: (BuildContext context) => gameScreen()))
    }
    else{
      print("yanlış");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('snackbarwrong'.tr()),
      ));
    }
  }


  // playerList(snapshot) {
  //   var counter;
  //   if (snapshot.data!["playerCounter"] == 0) {
  //     return Text("oyun yok");
  //   } else {
  //     counter = int.parse(snapshot.data!["playerCounter"]);
  //     // return ListView.builder(itemCount:counter,itemBuilder:(context,index){
  //     //   return Text("Player $index : ${snapshot.data!["player${index+1}"]}");
  //     // });
  //   }
  // }
}
