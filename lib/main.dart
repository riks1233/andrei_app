import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter apiwka',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter apiwka'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String apiAddress = '10.0.2.2:8000';
  String _delta = '0';

  Future<http.Response> apiFetch() async {
    // http.Response res = await http.get(apiLink);
    http.Response res = await http.get(
      new Uri.http(apiAddress, "/"),
      headers: {"Accept":"application/json"}
    );
    return res;
  }

  void getDelta() async {
    http.Response res = await apiFetch();
    var resJson = jsonDecode(res.body);

    // Dumb selection of START and PAUSE events
    DateTime startTime = DateTime.parse(resJson[0]['registeredAt']);
    DateTime endTime = DateTime.parse(resJson[1]['registeredAt']);

    String deltaTime = endTime.difference(startTime).toString();
    if (deltaTime.contains('.')) {
      deltaTime = deltaTime.split('.')[0];
    }
    setState(() {
      _delta = deltaTime;
    });
    print('Received delta: $_delta');
  }

  @override
  void initState() {
    getDelta();
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Delta: $_delta',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.refresh),
        onPressed: () => getDelta(),
      ),
    );
  }
}
