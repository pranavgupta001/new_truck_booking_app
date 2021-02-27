import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  User user;

  HomeScreen({this.user});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Home Screen'),
        ),
        drawer: Container(
          child: Drawer(
            child: ListView(
              children: [
                Container(
                  height: 150,
                  child: DrawerHeader(
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 30,
                          child: Icon(Icons.home),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Text(user == null ? '+911234567891' : user.phoneNumber),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    FirebaseAuth.instance.signOut();
                    Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
                  },
                  child: ListTile(
                    title: Text('Sign Out'),
                    trailing: Icon(Icons.exit_to_app),
                  ),
                ),
              ],
            ),
          ),
        ),
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
