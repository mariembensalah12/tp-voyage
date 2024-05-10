import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class MeteoDetailsPage extends StatefulWidget {
String ville="";
MeteoDetailsPage(this.ville);



  @override
  State<MeteoDetailsPage> createState() => _MeteoDetailsPageState();



}

class _MeteoDetailsPageState extends State<MeteoDetailsPage> {

  var meteoData;
  
  void initState(){
    super.initState();
    getMeteoData(widget.ville);

  }
  void getMeteoData(String ville) {
    print("Météo de la ville de " + ville);
    String url =
        "https://api.openweathermap.org/data/2.5/forecast?q=$ville&appid=831a931b642334b481cf86a773542bcb";
    http.get(Uri.parse(url)).then((resp) {
      setState(() {
        this.meteoData = json.decode(resp.body);
        print(this.meteoData);
      });
    }).catchError((err) {
      print(err);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text('page Meteo Details ${widget.ville}'),
        backgroundColor: Colors.blue,
      ),
      body: meteoData==null?
          Center(
            child: CircularProgressIndicator(),
          ):
            ListView.builder(
        itemCount: (meteoData==null ? 0 :meteoData['list'].length),
          itemBuilder: (context,index){
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
          color:Colors.blue,
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
              children: [
                CircleAvatar(
          backgroundImage: AssetImage(
            "images/${meteoData['list'][index]['weather'][0]['main'].toString().toLowerCase()}.png"
          ),
                ),
                Column(
                crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("${new DateFormat('E-dd/MM/yyyy').format(DateTime.fromMicrosecondsSinceEpoch(meteoData['list'][index]['dt']*1000000))}",
                style: TextStyle(
          fontSize: 22,fontWeight: FontWeight.bold
                ),),
              Text("${new DateFormat('HH:mm').format(DateTime.fromMicrosecondsSinceEpoch(meteoData['list'][index]['dt']*1000000)) }",
              style: TextStyle(
                fontSize: 22, fontWeight: FontWeight.bold
              ) ,)

              ],
                ),
              ],
              ),
                Text("${(meteoData['list'][index]['main']['temp']- 273.15).toStringAsFixed(1)}°C",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold))
              ],),

          ),
        );
    })
    );
  }

}
