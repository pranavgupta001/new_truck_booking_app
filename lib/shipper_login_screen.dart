import 'package:flutter/material.dart';

class ShipperLoginScreen extends StatelessWidget {
  String mobileNum;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(body: Container(
        padding: EdgeInsets.symmetric(horizontal: 55, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              onChanged: (value){mobileNum = value;
              print(mobileNum);},
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, backgroundColor: Colors.black12,),
              decoration: InputDecoration(
                  hintText: 'Enter Mobile Number',
                  hintStyle: TextStyle(color: Colors.blueGrey, fontSize: 20)
              ),
            ),
            SizedBox(height: 20,),
            FlatButton(
              color: Colors.lightBlueAccent,
              onPressed: (){ Navigator.pushNamed(context, '/newEntry'); },
              child: Text('Verify', style: TextStyle(fontSize: 25, ),
              ),
            ),
          ],
        ),
      ),
      ),
    );
  }
}