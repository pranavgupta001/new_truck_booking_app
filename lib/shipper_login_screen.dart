import 'package:flutter/material.dart';

class ShipperLoginScreen extends StatelessWidget {
  String mobileNum;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 55, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(
                    onChanged: (value) {
                      mobileNum = value;
                      print(mobileNum);
                    },
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      backgroundColor: Colors.black12,
                    ),
                    decoration: InputDecoration(
                        hintText: 'Enter Mobile Number',
                        hintStyle:
                            TextStyle(color: Colors.blueGrey, fontSize: 20)),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  FlatButton(
                    color: Colors.lightBlueAccent,
                    onPressed: () {
                      Navigator.pushNamed(context, '/home');
                    },
                    child: Text(
                      'Verify',
                      style: TextStyle(
                        fontSize: 25,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 200,
            ),
            Container(
              padding: EdgeInsets.only(
                bottom: 10,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.redAccent,
                      borderRadius: BorderRadius.circular(19),
                    ),
                    child: FlatButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/home');
                      },
                      child: Hero(
                        tag: 'home',
                        child: Icon(
                          Icons.home,
                          size: 40,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.redAccent,
                      borderRadius: BorderRadius.circular(19),
                    ),
                    child: FlatButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/newEntry');
                      },
                      child: Hero(
                        tag: 'add',
                        child: Icon(
                          Icons.add,
                          size: 40,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.redAccent,
                      borderRadius: BorderRadius.circular(19),
                    ),
                    child: FlatButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/cards');
                      },
                      child: Hero(
                        tag: 'list',
                        child: Icon(
                          Icons.list,
                          size: 40,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
