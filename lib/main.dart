import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:voyage/config/global.params.dart';
import 'package:voyage/firebase_options.dart';
import 'package:voyage/pages/authentification.page.dart';
import 'package:voyage/pages/contact.page.dart';
import 'package:voyage/pages/gallerie.page.dart';
import 'package:voyage/pages/home.page.dart';
import 'package:voyage/pages/inscription.page.dart';
import 'package:voyage/pages/meteo.page.dart';
import 'package:voyage/pages/parametres.page.dart';
import 'package:voyage/pages/pays.page.dart';

ThemeData theme = ThemeData.light();
FirebaseDatabase fire = FirebaseDatabase.instance;
DatabaseReference ref = fire.ref();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  GlobalParams.themeActuel.setMode(await _onGetMode());
  runApp(MyApp());
}
Future<String> _onGetMode() async {
  final snapshot = await ref.child('mode').get();
  if (snapshot.exists) {
    return snapshot.value.toString(); // Return the value
  } else {
    return "Day"; // Default mode
  }
}

class MyApp extends StatelessWidget {
  final routes = {
    '/inscription': (context) => InscriptionPage(),
    '/authentification': (context) => AuthentificationPage(),
    '/home': (context) => HomePage(),
    '/pays': (context) => Payspage(),
    '/meteo': (context) => MeteoPage(),
    '/gallerie': (context) => GalleriePage(),
    '/contact': (context) => ContactePage(),
    '/parametres': (context) => ParameterPage(),
  };


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: GlobalParams.themeActuel.getTheme(),
      routes: routes,
      debugShowCheckedModeBanner: false,
      home:  StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: ((context, snapshot) {
          if (snapshot.hasData) {
            return HomePage();
          } else {
            return InscriptionPage();
          }
        }),
      ),

    );


}


    }
