import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'shipper_login_screen.dart';
import 'choice_screen.dart';
import 'transporter_login_screen.dart';
import 'shipper_new_entry.dart';
import 'cardGenerator.dart';
void main() => runApp(FlashChat());

class FlashChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TasksData(),
      child: MaterialApp(
        initialRoute: '/',
        routes: {
          '/' : (context) => ChoiceScreen(),
          '/login1' : (context) => ShipperLoginScreen(),
          '/login2' : (context) => TransporterLoginScreen(),
          '/newEntry' : (context) => ShipperNewEntryScreen(),
          '/cards' : (context) => CardScreen(),
        },
      ),
    );
  }
}
