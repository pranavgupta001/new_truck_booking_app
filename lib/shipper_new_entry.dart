import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:truck_booking_app/backend_connection.dart';
import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:geocoder/geocoder.dart';
import 'package:location_permissions/location_permissions.dart';
import 'package:truck_booking_app/cardGenerator.dart';
import 'package:truck_booking_app/home_Screen.dart';

String mapKey = "AIzaSyCTVVijIWofDrI6LpSzhUqJIF90X-iyZmE";
String productType;
String loadingPoint;
String unloadingPoint;
String truckPreference;
String noOfTrucks = '1';
String weight;
bool isPending = true;
String comments;
bool isCommentsEmpty = true;
var controller1 = TextEditingController();
var controller2 = TextEditingController();
var controller3 = TextEditingController();

class ShipperNewEntryScreen extends StatefulWidget {
  String userCity = '';
  User user;

  ShipperNewEntryScreen({this.user, this.userCity});

  @override
  _ShipperNewEntryScreenState createState() => _ShipperNewEntryScreenState();
}

class _ShipperNewEntryScreenState extends State<ShipperNewEntryScreen> {
  @override
  String city = ' ';

  void fillCityName(String cityName) async {
    if (cityName.length > 1) {
      String autoCompleteUrl =
          'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$cityName&key=$mapKey&sessiontoken=1234567890';
      var res = await http.get(autoCompleteUrl);
      var jsonData = await jsonDecode(res.body);
      print(res.statusCode);
      print(jsonData);
    }
  }

  void initState() {
    super.initState();
    controller1.clear();
    controller2.clear();
    controller3.clear();
    controller1 = TextEditingController(text: widget.userCity);
  }

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color(0xFFF3F2F1),
        appBar: AppBar(
          backgroundColor: Colors.black,
          leading: GestureDetector(
            onTap: () {
                 Navigator.pop(context);},
            child: Icon(Icons.arrow_back_ios, size: 25),
          ),
          title: Text(
            'Shipping Details',
            textAlign: TextAlign.center,
          ),
        ),
        body: SafeArea(
          child: Form(
            key: formKey,
            autovalidateMode: AutovalidateMode.always,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: 20,
                      right: 20,
                      top: 20,
                      bottom: 20,
                    ),
                    child: Container(
                      color: Color(0xFFF3F2F1),
                      child: ListView(
                        keyboardDismissBehavior:
                            ScrollViewKeyboardDismissBehavior.manual,
                        children: [
                          Container(
                            height: 72,
                            child: TextFormField(
                              controller: controller1,
                              onChanged: (newValue) {
                                loadingPoint = newValue;
                                fillCityName(newValue);
                              },
                              decoration: InputDecoration(
                                hintText: 'Loading Point',
                                hintStyle:
                                    TextStyle(fontSize: 20, color: Colors.grey),
                              ),
                              validator: (String value) {
                                if (value.isEmpty) {
                                  return 'Loading Point is Required';
                                } else
                                  return null;
                              },
                              style:
                                  TextStyle(fontSize: 20, color: Colors.black),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: 72,
                            child: TextFormField(
                              controller: controller2,
                              onChanged: (newValue) {
                                unloadingPoint = newValue;
                              },
                              decoration: InputDecoration(
                                hintText: 'Unloading Point',
                                hintStyle:
                                    TextStyle(fontSize: 20, color: Colors.grey),
                              ),
                              validator: (String value) {
                                if (value.isEmpty) {
                                  return 'Unloading Point is Required';
                                } else
                                  return null;
                              },
                              style:
                                  TextStyle(fontSize: 20, color: Colors.black),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: 72,
                            child: DropDownGenerator(
                              dropdownValue: 'Product Type',
                              dropdownValues: [
                                'Product Type',
                                'Powder',
                                'Wire Bundles',
                                'Liquid'
                              ],
                              dropDownNumber: 'one',
                              notAllowedValue: 'Product Type',
                            ),
                          ),
                          GestureDetector(
                              onTap: (){ showModalBottomSheet(context: context, builder: (context) => ProductTypeWidgetScreen(),);},
                              child: Container(height: 72, child: DropDownGenerator(
                                dropdownValue: 'Product Type',
                                dropdownValues: [],
                                hintText: productType == null? 'Product Type' : productType ,
                                notAllowedValue: 'Product Type',
                              ),),),
                          //FlatButton(child: Container(color: Colors.lightBlueAccent, height: 72),  onPressed:(){ showModalBottomSheet(context: context, builder: (context) => ProductTypeWidgetScreen(),);}),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: 72,
                            child: TruckPreferenceDropDown(
                              dropdownValue: 'Truck Preference',
                              notAllowedValue: 'Truck Preference',
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: 72,
                            child: Row(
                              children: [
                                Text(
                                  'No. Of Trucks                                 ',
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.grey),
                                ),
                                Expanded(
                                  child: DropDownGenerator(
                                    dropdownValue: '1',
                                    dropdownValues: [
                                      '1',
                                      '2',
                                      '3',
                                      '4',
                                      '5',
                                    ],
                                    dropDownNumber: 'three',
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: 72,
                            child: DropDownGenerator(
                              dropdownValue: 'Weight (In Tons)',
                              dropdownValues: [
                                'Weight (In Tons)',
                                '10 ton',
                                '20 ton'
                              ],
                              dropDownNumber: 'four',
                              notAllowedValue: 'Weight (In Tons)',
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: 72,
                            child: TextField(
                              controller: controller3,
                              onChanged: (newValue) {
                                comments = newValue;
                              },
                              decoration: InputDecoration(
                                hintText: 'Comments',
                                hintStyle:
                                    TextStyle(fontSize: 20, color: Colors.grey),
                              ),
                              style:
                                  TextStyle(fontSize: 20, color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 70,
                  child: FlatButton(
                    onPressed: () async {
                      if (!formKey.currentState.validate()) {
                        return;
                      }
                      if (comments != null) {
                        if (comments.isNotEmpty) {
                          if (comments != '') {
                            isCommentsEmpty = false;
                          } else {
                            isCommentsEmpty = true;
                          }
                        } else {
                          isCommentsEmpty = true;
                        }
                      } else {
                        isCommentsEmpty = true;
                      }
                      try {
                        final createdCard = await createCardOnApi();
                        print(createdCard);
                        Navigator.push(context, MaterialPageRoute(builder: (context) => CardScreen(userCity: widget.userCity,),),);
                      } catch (e) {
                        print(e);
                      }
                    },
                    color: Color(0xFF043979),
                    child: Text(
                      'Submit',
                      style: TextStyle(fontSize: 25, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Future<CardsModal> createCardOnApi() async {
  Map data = {
    "loadingPoint": loadingPoint,
    "unloadingPoint": unloadingPoint,
    "productType": productType,
    "truckType": truckPreference,
    "noOfTrucks": noOfTrucks,
    "weight": weight,
    "comment": isCommentsEmpty ? '' : comments
  };
  String body = json.encode(data);
  final String apiUrl = "http://10.0.2.2:63444/load";
  final response = await http.post(apiUrl,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: body);
  if (response.statusCode == 201) {
    final String responseString = response.body;
    return cardsModalFromJson(responseString);
  } else {
    return null;
  }
}

class DropDownGenerator extends StatefulWidget {
  String dropdownValue;
  List<String> dropdownValues;
  String notAllowedValue;
  String dropDownNumber;
  String hintText = ' ';

  DropDownGenerator(
      {this.dropdownValue,
      this.dropdownValues,
      this.dropDownNumber,
      this.notAllowedValue,
      this.hintText});

  @override
  _DropDownGeneratorState createState() => _DropDownGeneratorState();
}

class _DropDownGeneratorState extends State<DropDownGenerator> {
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: widget.dropdownValue,
      hint: Text('${widget.hintText}', style: TextStyle(color: Colors.grey),),
      iconDisabledColor: Colors.black54,
      elevation: 16,
      style: TextStyle(color: Colors.grey, fontSize: 18),
      onChanged: (String newValue) {
        setState(() {
          widget.dropdownValue = newValue;
          if (widget.dropDownNumber == 'one') {
            productType = newValue;
          } else if (widget.dropDownNumber == 'three') {
            noOfTrucks = newValue;
          } else if (widget.dropDownNumber == 'four') {
            weight = newValue;
          }
        });
      },
      items:
          widget.dropdownValues.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      validator: (String value) {
        if (widget.notAllowedValue == null) {
          return null;
        }
        if (value != widget.notAllowedValue) {
          return null;
        } else {
          if (widget.dropDownNumber == 'one') {
            return 'Product Type is Required';
          } else if (widget.dropDownNumber == 'four') {
            return 'weight is Required';
          }
          return null;
        }
      },
    );
  }
}

class TruckPreferenceDropDown extends StatefulWidget {
  String dropdownValue;
  String notAllowedValue;

  TruckPreferenceDropDown(
      {this.dropdownValue, this.notAllowedValue});

  @override
  _TruckPreferenceDropDownState createState() =>
      _TruckPreferenceDropDownState();
}

class _TruckPreferenceDropDownState extends State<TruckPreferenceDropDown> {
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      isExpanded: true,
      value: widget.dropdownValue,
      elevation: 16,
      style: TextStyle(color: Colors.grey, fontSize: 18),
      onChanged: (String newValue) {
        setState(() {
          widget.dropdownValue = newValue;
          truckPreference = newValue;
        });
      },
      items: [
        DropdownMenuItem<String>(
          value: 'Truck Preference',
          child: Container(
            child: Row(
              children: [
                Text('Truck Preference'),
              ],
            ),
          ),
        ),
        DropdownMenuItem<String>(
          value: 'Container',
          child: Container(
            child: Row(
              children: [
                Text('Container'),
                Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/container.jpeg'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        DropdownMenuItem<String>(
          value: 'Hyva',
          child: Container(
            child: Row(
              children: [
                Text('Hyva'),
                Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/hyva.jpeg'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        DropdownMenuItem<String>(
          value: 'LCV',
          child: Container(
            child: Row(
              children: [
                Text('LCV'),
                Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/lcv.jpeg'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        DropdownMenuItem<String>(
          value: 'Tanker',
          child: Container(
            child: Row(
              children: [
                Text('Tanker'),
                Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/tanker.jpeg'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        DropdownMenuItem<String>(
          value: 'Trailer',
          child: Container(
            child: Row(
              children: [
                Text('Trailer'),
                Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/trailer.jpeg'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        DropdownMenuItem<String>(
          value: 'Truck',
          child: Container(
            child: Row(
              children: [
                Text('Truck'),
                Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/truck.jpeg'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
      validator: (String value) {
        if (widget.notAllowedValue == null) {
          return null;
        }
        if (value != widget.notAllowedValue) {
          return null;
        } else {
          return 'Truck Preference is Required';
        }
      },
    );
  }
}

class ProductTypeWidgetScreen extends StatefulWidget {
  @override
  _ProductTypeWidgetScreenState createState() => _ProductTypeWidgetScreenState();
}

class _ProductTypeWidgetScreenState extends State<ProductTypeWidgetScreen> {
  Color colorUnselected = Colors.white;

  Color colorSelected = Colors.lightBlueAccent;
  Color color1;
  Color color2;
  Color color3;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 800,
      color : Color(0xff757575),
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(topRight: Radius.circular(20), topLeft: Radius.circular(20),),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 50,
              child: Center(child: Text('Select Product Type'),),
              color: Color(0xFFF3F2F1),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: (){
                    setState(() {
                      productType = 'Packaged/ Consumer boxes';
                      color1 = colorSelected;
                      Navigator.pop(context);
                    });

                  },
                  child: Container(
                    color: color1,
                    height: 100,
                    width: 100,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(height: 40, width: 40, decoration: BoxDecoration(image:DecorationImage(image: AssetImage('assets/productTypeImages/material1.jpeg'),),),),
                        Text('Packaged/ \n Consumer boxes', textAlign: TextAlign.center,),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    Navigator.pop(context);
                    setState(() {
                      colorUnselected = colorSelected;
                    });

                  },
                  child: Container(
                    color: colorUnselected,
                    height: 100,
                    width: 100,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(height: 40, width: 40, decoration: BoxDecoration(image:DecorationImage(image: AssetImage('assets/productTypeImages/material1.jpeg'),),),),
                        Text('Food and \n agriculture',textAlign: TextAlign.center,),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    Navigator.pop(context);
                    setState(() {
                      colorUnselected = colorSelected;
                    });
                  },
                  child: Container(
                    color: colorUnselected,
                    height: 100,
                    width: 100,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(height: 40, width: 40, decoration: BoxDecoration(image:DecorationImage(image: AssetImage('assets/productTypeImages/material1.jpeg'),),),),
                        Text('Machine/\nAuto Parts',textAlign: TextAlign.center,),
                      ],
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
