import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:truck_booking_app/screens/mapScreen.dart';
import 'package:truck_booking_app/screens/ts_find_load.dart';
import 'package:truck_booking_app/widgets/LoadingPointSeachScreen.dart';
import 'widgets/providerData.dart';
import 'package:truck_booking_app/screens/shipper_login_screen.dart';
import 'package:truck_booking_app/screens/choice_screen.dart';
import 'package:truck_booking_app/screens/transporter_login_screen.dart';
import 'package:truck_booking_app/screens/shipper_new_entry.dart';
import 'package:truck_booking_app/screens/cardGenerator.dart';
import 'package:truck_booking_app/screens/shipper_home_Screen.dart';
import 'package:truck_booking_app/screens/ts_home_screen.dart';
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
                  '/home': (context) => ShipperHomeScreen(
                        user: FirebaseAuth.instance.currentUser,
                      ),
                  '/tsHome' : (context) => TsHomeScreen( user: FirebaseAuth.instance.currentUser,),
                  '/findLoad' : (context) => TsFindLoadScreen(),
                  '/maps' : (context) => MapScreen(),
                  '/product' : (context) => LoadingPointSearchScreen(),
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
