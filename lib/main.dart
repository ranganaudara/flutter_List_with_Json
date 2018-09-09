import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title:'httpReq',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {

  String url = 'https://randomuser.me/api/?results=15';
  
  List data;

  Future<String> makeRequest() async {
    var response = await http.get(
      Uri.encodeFull(url),
      headers: {"Accept":"application/json"}
    );

    setState(() {
      var extractdata = json.decode(response.body);
      data = extractdata["results"];
    });
    
  }

  @override
  void initState() {
    this.makeRequest();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text('Contact List')
      ),
      body: new ListView.builder(
        itemCount: data == null? 0 : data.length,
        itemBuilder: (BuildContext context, i) {
          return new ListTile(
            title: new Text(data[i]["name"]["first"]),
            subtitle: new Text(data[i]["phone"],),
            leading: new CircleAvatar(
              backgroundImage: new NetworkImage(data[i]['picture']['thumbnail'])
            )
          );
        }
      )  
    );
  }
}