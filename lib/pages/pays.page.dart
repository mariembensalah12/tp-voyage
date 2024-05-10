


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:voyage/menu/drawer.widget.dart';
import 'package:voyage/pages/pays-details.page.dart';

class Payspage extends StatelessWidget{

  TextEditingController txt_pays=new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: MyDrawer(),
        appBar: AppBar(
          title: Text('Page Pays'),
          backgroundColor: Colors.blue,
        ),
        body: Column(
            children: [
              Container(
                padding: EdgeInsets.all(10),
                child: TextFormField(
                  controller: txt_pays,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.location_city),
                      hintText: "Pays",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(width: 5)
                      )
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: ElevatedButton(onPressed: (){
                  _onGetPaysDetails(context);

                },
                  child: Text("chercher"),

                ),
              ),]
        )


    );
  }
  void _onGetPaysDetails(BuildContext context){
    String v =txt_pays.text;
    Navigator.push(context,
        MaterialPageRoute(builder:
            (context)=>PaysDetailspage(v))
    );
    txt_pays.text="";
  }

}