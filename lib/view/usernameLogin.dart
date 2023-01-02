import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tombalaonline/view/CreateOrJoinGame.dart';

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
    bool showinfo = true;

    return Scaffold(
      appBar: AppBar(title: Text("Username")),
      body: Center(
          child: Wrap(children: [Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  onChanged: (value) {
                    if(value.length < 4){
                      showinfo;
                    }
                    else{
                      showinfo = false;
                    }
                    print(showinfo);
                  },
                  decoration: InputDecoration(hintText: "Type username"),
                  textAlign: TextAlign.center,
                  controller: username,
                ),
              ),

              Container(
                child: showinfo == true
                    ? Text("Must be bigger than 3 letters")
                    : Text(""),
              ),
              OutlinedButton(onPressed:() {

                if(username.text.length < 4){
                  print("olmaz");
                }
                else{
                  Navigator
                      .of(context)
                      .pushReplacement(new MaterialPageRoute(builder: (BuildContext context) => CreateOrJoinGame()));
                }
              }, child: Text("Type username")),
            ],
          )],)),
    );
  }
}
