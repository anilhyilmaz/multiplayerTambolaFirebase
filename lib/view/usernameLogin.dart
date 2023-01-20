import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tombalaonline/view/CreateOrJoinGame.dart';
import 'package:country_icons/country_icons.dart';
import '../ProviderState.dart';

class usernameLogin extends StatefulWidget {
  const usernameLogin({Key? key}) : super(key: key);

  @override
  State<usernameLogin> createState() => _usernameLoginState();
}

class _usernameLoginState extends State<usernameLogin> {
  @override
  Widget build(BuildContext context) {
    var username = Provider.of<providerState>(context, listen: false).username;

    return Scaffold(
      appBar: AppBar(title: const Text("Username"), actions: [
        GestureDetector(
          onTap: () {
            _languageSettings();
          },
          child: const Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(
              Icons.settings_outlined,
            ),
          ),
        ),
      ]),
      body: Center(
          child: Wrap(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  onChanged: (value) {
                    if (value.isEmpty && value.length > 10) {
                      Provider.of<providerState>(context, listen: false)
                          .showinfo = true;
                    } else {
                      setState(() {
                        Provider.of<providerState>(context, listen: false)
                            .showinfo = false;
                      });
                    }
                    print(Provider.of<providerState>(context, listen: false)
                        .showinfo);
                  },
                  decoration: const InputDecoration(hintText: "Type username"),
                  textAlign: TextAlign.center,
                  controller: username,
                ),
              ),
              Container(
                child: Provider.of<providerState>(context, listen: false)
                            .showinfo ==
                        true
                    ? const Text("Must be bigger than 3 letters")
                    : const Text(""),
              ),
              OutlinedButton(
                  onPressed: () {
                    if (username.text.length < 4) {
                      _showDialog();
                    } else {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const CreateOrJoinGame()));
                    }
                  },
                  child: Text("Type username")),
            ],
          )
        ],
      )),
    );
  }

  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: const Text("Uyarı"),
          content: const Text(
              "Kullanıcı adınız 1 karakterden kısa ve 10 karakterden uzun olamaz."),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            OutlinedButton(
              child: new Text("Kapat"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _languageSettings() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: const Text("Settings"),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              new Image.asset('icons/flags/png/gb.png',
                  package: 'country_icons'),
              new Image.asset('icons/flags/png/tr.png',
                  package: 'country_icons'),
            ],
          ),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            OutlinedButton(
              child: new Text("Kapat"),
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
