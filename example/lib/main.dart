import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';

import 'package:juno_direct_checkout/juno_direct_checkout.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }
  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      var map = <String, dynamic>{
        "prod": false,
        "public_token": "YOUR_PUBLIC_TOKEN_SANDBOX"
      };
      print(await JunoDirectCheckout.init(map));
      var card = <String, dynamic>{
        "prod": false,
        "public_token": "YOUR_PUBLIC_TOKEN_SANDBOX",
        "cardNumber": "5362 6820 0316 4890",
        "holderName": "Teste",
        "securityCode": "111",
        "expirationMonth": "6",
        "expirationYear": "2022"
      };
      platformVersion = await JunoDirectCheckout.getCardHash(card);
      print(platformVersion);
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Text('Card Hash: $_platformVersion\n'),
        ),
      ),
    );
  }
}
