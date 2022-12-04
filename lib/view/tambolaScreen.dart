import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../ProviderState.dart';
import '../widgets/showTambolaGrid.dart';


class tambolaScreen extends StatefulWidget {
  const tambolaScreen({super.key, required this.title});
  final String title;

  @override
  State<tambolaScreen> createState() => _tambolaScreenState();
}

class _tambolaScreenState extends State<tambolaScreen> {
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
    var counter = Provider.of<providerState>(context, listen: false).getCounter;
    return Scaffold(
        body: SafeArea(
          child: Center(
            child: Column(
              children: [
                Flexible(flex: 1, child: Text(counter.toString())),
                Flexible(flex: 5, child: showTambolaGrid()),
                Flexible(
                    flex: 1,
                    child: OutlinedButton(
                      onPressed: () async {
                        var response = await Dio().get('http://10.0.2.2:3000/getTicket/5');
                        print("data:  ${response.data}");
                        print(response.data[0]);
                      },
                      child: Text("Click me"),
                    )),
              ],
            ),
          ),
        ));
  }
}