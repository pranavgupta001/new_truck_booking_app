import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoder/geocoder.dart';
import 'package:location_permissions/location_permissions.dart';
import 'file:///C:/Users/chira/flutter_app/test1_truck_booking_app/lib/screens/shipper_new_entry.dart';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'cardGenerator.dart';

class HomeScreen extends StatefulWidget {
  User user;
  String userCity ='';
  HomeScreen({this.user, this.userCity});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String city = '';

  void getCurrentLocation() async {

    if (widget.userCity == '' || widget.userCity == null){

    PermissionStatus permission =
        await LocationPermissions().requestPermissions();
    PermissionStatus permission1 =
        await LocationPermissions().checkPermissionStatus();
    print(permission1);
    print(permission);

    var position = await Geolocator().getCurrentPosition();
    final coordinates = new Coordinates(position.latitude, position.longitude);
    var addresses =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var first = addresses.first;
    print(first.addressLine);
    http.Response tokenGet = await http.post('https://outpost.mapmyindia.com/api/security/oauth/token?grant_type=client_credentials&client_id=33OkryzDZsJmp0siGnK04TeuQrg3DWRxswnTg_VBiHew-2D1tA3oa3fthrGnx4vwbwlbF_xT2T4P9dykuS1GUNmbRb8e5CUgz-RgWDyQspeDCXkXK5Nagw==&client_secret=lrFxI-iSEg9xHXNZXiqUoprc9ZvWP_PDWBDw94qhrze0sUkn7LBDwRNFscpDTVFH7aQT4tu6ycN0492wqPs-ewpjObJ6xuR7iRufmSVcnt9fys5dp0F5jlHLxBEj7oqq');
    print(tokenGet.statusCode);
    print(tokenGet.body);
    var body = jsonDecode(tokenGet.body);
    var token = body["access_token"];
    http.Response response = await http.get('https://atlas.mapmyindia.com/api/places/geocode?address=${first.addressLine}',
      headers: {HttpHeaders.authorizationHeader: "$token"},);
    print(response.statusCode);
    print(response.body);
    var adress = jsonDecode(response.body);
    print(adress);
    var cityName = adress["copResults"]["city"];
    print(cityName);
    city = cityName;
    // http.Response response1 = await http.get('https://atlas.mapmyindia.com/api/places/search/json?query=alwar',
    //   headers: {HttpHeaders.authorizationHeader: 'Bearer $token'},);
    // print(response1.statusCode);
    // print(response1.body);
    // var adressa = jsonDecode(response1.body);
    // print(adressa);
  }
  else { city = widget.userCity;}}

  @override
  void initState() {
    super.initState();
    getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: Scaffold(
        backgroundColor: Color(0xFFF3F2F1),
        appBar: AppBar(
          title: Text('Home Screen'),
        ),
        drawer: Container(
          width: 250,
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
                        Text(
                          widget.user == null
                              ? '+911234567891'
                              : widget.user.phoneNumber,
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    FirebaseAuth.instance.signOut();
                    Navigator.pushNamedAndRemoveUntil(
                        context, '/', (route) => false);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: ListTile(
                      title: Text(
                        'Sign Out',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      trailing: Icon(
                        Icons.exit_to_app,
                        size: 30,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '           Welcome To \n The Truck Booking App',
                style: TextStyle(
                    fontSize: 30,
                    color: Colors.black,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 30,
              ),
              SizedBox(
                height: 200,
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey, width: 1),
                  borderRadius: BorderRadius.circular(19),
                ),
                padding: EdgeInsets.only(bottom: 10, top: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(19),
                      ),
                      child: FlatButton(
                        onPressed: () {},
                        child: Hero(
                          tag: 'home',
                          child: Icon(
                            Icons.home,
                            size: 40,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(19),
                      ),
                      child: FlatButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ShipperNewEntryScreen(
                                        userCity: city,
                                      ),),);
                        },
                        child: Hero(
                          tag: 'add',
                          child: Icon(
                            Icons.add,
                            color: Colors.black,
                            size: 40,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(19),
                      ),
                      child: FlatButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CardScreen(
                                    userCity: city,
                                  )));
                        },
                        child: Hero(
                          tag: 'list',
                          child: Icon(
                            Icons.list,
                            color: Colors.black,
                            size: 40,
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
