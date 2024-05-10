import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class InscriptionPage extends StatelessWidget {
  TextEditingController txt_login=new TextEditingController();
  TextEditingController txt_password=new TextEditingController();
  late SharedPreferences prefs;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Inscription Page"),backgroundColor: Colors.blue,),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            child: TextFormField(
              controller: txt_login,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.person),
                hintText: "Identifiant",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(width: 5)
                )
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: TextFormField(
              controller: txt_password,
              obscureText: true,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.abc),
                  hintText: "Mot de passe",
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
              _onInscrire(context);


            },
                child: Text("Insription"),

            ),
          ),
          TextButton(onPressed: (){
            Navigator.pop(context);
            Navigator.pushNamed(context, '/authentification');
          }, child: Text("j'ai déja un campte"))
        ],
      )
    );
  }

  Future<void> _onInscrire(BuildContext context) async {
    try {
      final credential =
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: txt_login.text,
        password: txt_password.text,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }
}

