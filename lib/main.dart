import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:truck_booking_app/providerData.dart';
import 'shipper_login_screen.dart';
import 'choice_screen.dart';
import 'transporter_login_screen.dart';
import 'shipper_new_entry.dart';
import 'cardGenerator.dart';
import 'home_Screen.dart';

void main() => runApp(FlashChat());

class FlashChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Firebase.initializeApp(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return loading();
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return ChangeNotifierProvider<NewDataByShipper>(
              create: (context) => NewDataByShipper(),
              child: MaterialApp(
                initialRoute:
                    FirebaseAuth.instance.currentUser == null ? '/' : '/home',
                routes: {
                  '/': (context) => ChoiceScreen(),
                  '/login1': (context) => ShipperLoginScreen(),
                  '/login2': (context) => TransporterLoginScreen(),
                  '/newEntry': (context) => ShipperNewEntryScreen(),
                  '/cards': (context) => CardScreen(),
                  '/home': (context) => HomeScreen(
                        user: FirebaseAuth.instance.currentUser,
                      ),
                },
              ),
            );
          }
          return loading();
        });
  }
}

class loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.lightBlueAccent,
        body: Center(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'OOPS!!\n Some Error With The App, \nEither Wait OR Please Try Again Later',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Icon(
                  Icons.error,
                  size: 70,
                  color: Colors.red,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
