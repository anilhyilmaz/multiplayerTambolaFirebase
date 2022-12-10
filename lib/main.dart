import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tombalaonline/ProviderState.dart';
import 'package:tombalaonline/view/usernameLogin.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp(); //initilization of Firebase
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<providerState>(
      create: (BuildContext context) => providerState(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: usernameLogin(),
      ),
    );
  }
}

