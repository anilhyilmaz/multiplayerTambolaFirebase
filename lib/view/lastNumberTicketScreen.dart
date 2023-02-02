import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';

import '../ProviderState.dart';
import '../utils/ad_helper.dart';

class lastNumberTicketScreen extends StatefulWidget {
  const lastNumberTicketScreen({Key? key}) : super(key: key);

  @override
  State<lastNumberTicketScreen> createState() => _lastNumberTicketScreenState();
}

class _lastNumberTicketScreenState extends State<lastNumberTicketScreen> {
  final AdSize adSize = AdSize(height: 200, width: 10);
  BannerAd? _bannerAd;

  Future<InitializationStatus> _initGoogleMobileAds() {
    // TODO: Initialize Google Mobile Ads SDK
    return MobileAds.instance.initialize();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
    FirebaseFirestore Firestore = FirebaseFirestore.instance;

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
                  Expanded(
                    flex: 4,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 32, right: 16),
                      child: snapshot.data!["owner"] ==
                              Provider.of<providerState>(context, listen: false)
                                  .usernameText
                          ? OutlinedButton(
                              child: Text("picknumber".tr()),
                              onPressed: () async => {
                                    if (snapshot.data["isgamefinished"] == true)
                                      {},
                                    if (snapshot.data["isgamefinished"] ==
                                        false)
                                      {
                                        randomGenerateAndUpdate(),
                                        controlTicket(snapshot),
                                        /////////////////////////////////////////////
                                      },
                                  })
                          : null,
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Text(
                        "${"lastNumber".tr()}${snapshot.data!["lastnumber"]}"),
                  ),
                  if (_bannerAd != null)
                    Expanded(
                        flex: 7,
                        child: Align(
                          child: Container(
                            width: _bannerAd!.size.width.toDouble(),
                            height: _bannerAd!.size.height.toDouble(),
                            child: AdWidget(ad: _bannerAd!),
                          ),
                        )),
                ])
              ],
            );
          }
        });
  }

  randomGenerateAndUpdate() async {
    FirebaseFirestore Firestore = FirebaseFirestore.instance;
    Provider.of<providerState>(context, listen: false).RandomNumbers();
    print(Provider.of<providerState>(context, listen: false).lastNumber);
    await Firestore.collection("games")
        .doc(Provider.of<providerState>(context, listen: false).gameID)
        .update({
      "lastnumber":
          Provider.of<providerState>(context, listen: false).lastNumber
    });
  }

  controlTicket(snapshot) async {
    FirebaseFirestore Firestore = FirebaseFirestore.instance;
    var a;
    bool isGameFinished = false;
    var playerCounter;
    ////////////////////////////////////////////////////////////
    //this code controls of last numbers for tickets
    if (snapshot.data!["playerCounter"] == 0) {
      playerCounter = snapshot.data!["playerCounter"] + 1;
    } else {
      playerCounter = int.parse(snapshot.data!["playerCounter"]) + 1;
    }
    for (int j = 0; j < playerCounter; j++) {
      a = await snapshot.data["ticket$j"];
      for (var key in a.keys) {
        for (var value in a[key]) {
          if (15 == await snapshot.data["player${j}known"]) {
            print("game finished");
            await Firestore.collection("games")
                .doc(Provider.of<providerState>(context, listen: false).gameID)
                .update({"isgamefinished": true});
            if (!isGameFinished) {
              _gamefinishDialog();
              isGameFinished = true;
            }
          } else if (value ==
              Provider.of<providerState>(context, listen: false).lastNumber) {
            Provider.of<providerState>(context, listen: false).playerknown =
                await snapshot.data["player${j}known"];
            Provider.of<providerState>(context, listen: false).playerknown++;
            print("bildi $j");
            await Firestore.collection("games")
                .doc(Provider.of<providerState>(context, listen: false).gameID)
                .update({
              "player${j}known":
                  Provider.of<providerState>(context, listen: false).playerknown
            });
            if (15 == await snapshot.data["player${j}known"]) {
              await Firestore.collection("games")
                  .doc(
                      Provider.of<providerState>(context, listen: false).gameID)
                  .update({"isgamefinished": true});
              gameFinished();
            }
          }
        }
      }
    }
  }

  gameFinished() {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Text("Warning".tr()),
          content: Text("gameover".tr()),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            OutlinedButton(
              child: new Text("close".tr()),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _gamefinishDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Text("Warning".tr()),
          content: Text("gameover".tr()),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            OutlinedButton(
              child: Text("close".tr()),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
