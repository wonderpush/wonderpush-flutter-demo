import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:wonderpush_flutter_plugin/wonderpush_flutter_plugin.dart';
import 'package:wonderpush_flutter_plugin_example/event_list.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  String _name = 'UNKOWN';

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion, name;

    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      platformVersion = await WonderpushFlutterPlugin.platformVersion;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    try {
      name = await WonderpushFlutterPlugin.name;
    } on PlatformException {
      name = 'Failed to get name';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
      _name = name;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text("$_name"),
          ),
          body: Container(
            color: Color.fromRGBO(221, 221, 221, 1.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: Text('Running on: $_platformVersion\n'),
                // ),
                Expanded(
                  flex: 1,
                  child: EventList(),
                )
              ],
            ),
          )),
    );
  }
}
