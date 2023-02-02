import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tombalaonline/ProviderState.dart';
import 'package:tombalaonline/view/usernameLogin.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:google_mobile_ads/google_mobile_ads.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp(); //initilization of Firebase
  await EasyLocalization.ensureInitialized();
  MobileAds.instance.initialize();
  runApp(
    EasyLocalization(
      supportedLocales: [
        Locale("tr", "TR"),
        Locale("en", "US"),
      ],
      saveLocale: true,
      path: "assets/lang",
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<providerState>(
      create: (BuildContext context) => providerState(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        home: usernameLogin(),
      ),
    );
  }
}
