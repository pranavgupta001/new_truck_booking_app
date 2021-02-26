import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
class ChoiceScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.lightBlueAccent,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 20,
            ),
            child: Container(
              child: Column(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Shipper',
                            style: TextStyle(fontSize: 25),
                          ),
                        ),
                        Expanded(
                          child: FlatButton(
                              onPressed: () async{
                                WidgetsFlutterBinding.ensureInitialized();
                                await Firebase.initializeApp();
                                Navigator.pop(context);
                                Navigator.pushNamed(context, '/login1');
                              },
                              child: Text(
                                'Register',
                                style: TextStyle(fontSize: 25),
                              )),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Transporter',
                            style: TextStyle(fontSize: 25),
                          ),
                        ),
                        Expanded(
                          child: FlatButton(
                              onPressed: () async {
                                WidgetsFlutterBinding.ensureInitialized();
                                await Firebase.initializeApp();
                                Navigator.pop(context);
                                Navigator.pushNamed(context, '/login2');
                              },
                              child: Text(
                                'Register',
                                style: TextStyle(fontSize: 25),
                              )),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
