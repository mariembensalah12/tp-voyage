import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class AuthentificationPage extends StatelessWidget {

  TextEditingController txt_login=new TextEditingController();
  TextEditingController txt_password=new TextEditingController();
  late SharedPreferences prefs;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Authentification Page"),backgroundColor: Colors.blue,),
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
              _onAuthentifier(context, txt_login.text, txt_password.text);
            },
              child: Text("Login"),

            ),
          ),
          TextButton(onPressed: (){
            Navigator.pop(context);
            Navigator.pushNamed(context, '/inscription');
          }, child: Text("Nouvelle utilisateur"))
        ],
      )
    );
  }

  Future<void> _onAuthentifier(
      BuildContext context, String login, String password) async {
    try {
      UserCredential userCredential =
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: login,
        password: password,
      );
      // User is authenticated, navigate to home page
      Navigator.pop(context);
      Navigator.pushNamed(context, '/home');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found' || e.code == 'wrong-password') {
        const snackBar = SnackBar(
          content: Text('Identifiant ou mot de passe incorrect'),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else {
        print("Error: $e");
      }
    } catch (e) {
      print("Error: $e");
    }
  }}
