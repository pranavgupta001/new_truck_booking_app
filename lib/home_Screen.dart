import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.lightBlueAccent,
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '           Welcome To \n The Truck Booking App',
                style: TextStyle(fontSize: 25, color: Colors.yellowAccent),
              ),
              SizedBox(
                height: 30,
              ),
              SizedBox(
                height: 250,
              ),
              Container(
                padding: EdgeInsets.only(bottom: 10, left: 21),
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.redAccent,
                        borderRadius: BorderRadius.circular(19),
                      ),
                      child: FlatButton(
                        onPressed: () {},
                        child: Hero(
                          tag: 'home',
                          child: Icon(
                            Icons.home,
                            size: 70,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 5,
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
                            size: 70,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 5,
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
                            size: 70,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
