





import 'package:flutter/material.dart';
import 'package:voyage/menu/drawer.widget.dart';
import 'package:voyage/pages/Gallerie-Details.dart';

class GalleriePage extends StatelessWidget{
  TextEditingController txt_keyword=new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: MyDrawer(),
        appBar: AppBar(
          title: Text('Page gallerie'),
          backgroundColor: Colors.blue,
        ),
        body: Column(
            children: [
              Container(
                padding: EdgeInsets.all(10),
                child: TextFormField(
                  controller: txt_keyword,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.location_city),
                      hintText: "keyword",
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
                  _onGetGallerieDetails(context);


                },
                  child: Text("chercher"),

                ),
              ),]
        )


    );
  }
  void  _onGetGallerieDetails(BuildContext context){
    String v =txt_keyword.text;
    Navigator.push(context ,
        MaterialPageRoute(builder:
            (context)=>GallerieDetailspage(v))
    );
    txt_keyword.text="";

  }

}