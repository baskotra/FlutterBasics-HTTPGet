import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:async';
import 'package:http/http.dart' as http;

void main() => runApp(new MaterialApp(
home: new HomePage(),
theme: new ThemeData(
   primarySwatch: Colors.blue,
)
));


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

final String url ="https://swapi.co/api/people"; //*Data to be fetched from here
List data;

@override
void initState(){
  super.initState();
  this.getJsonData();
}

Future<String> getJsonData() async{
  var response = await http.get(
    //TODO: Encode url to avoid empty spaces
    Uri.encodeFull(url),
    //TODO: To Accept only JSON format
    headers: {"Accept" : "Application/json"}
  );

  print(response.body);

  //* Whenever we get a response, we need to rebuilt our states
  setState(() {
    var convertDataToJson = jsonDecode(response.body);
    data = convertDataToJson['results'];
  });
  //*As future returns a string
  return "Success";
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text("Real Time Data Using HTTP GET method")
      ),
      body: new ListView.builder(
        itemCount: data==null? 0 : data.length,
        itemBuilder: (BuildContext context, int index){
          return new Container(
            child: new Center(child: new Column(
             crossAxisAlignment: CrossAxisAlignment.stretch,
             children: <Widget>[
               new Card(
                 child: new Container(
                   child: new Text(data[index]['name']),
                 ),
               )
             ], 
            ),)
          );
        },
      ),
      );
  }
}