import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:truck_booking_app/cardGenerator.dart';
import 'package:provider/provider.dart';
import 'package:truck_booking_app/noOfTrucks_modal_screen.dart';
import 'package:truck_booking_app/weight_modal_screen.dart';
import 'backend_connection.dart';
import 'providerData.dart';
import 'dropDownGenerator.dart';
import 'modal_widget_screen.dart';
import 'truck_type_card_gen.dart';

String mapKey = "AIzaSyCTVVijIWofDrI6LpSzhUqJIF90X-iyZmE";

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
  Future<CardsModal> createCardOnApi() async {
    print(Provider.of<NewDataByShipper>(context, listen: false).loadingPoint);
    print(Provider.of<NewDataByShipper>(context, listen: false).unloadingPoint);
    print(Provider.of<NewDataByShipper>(context, listen: false).productType);
    print( Provider.of<NewDataByShipper>(context, listen: false).truckPreference);
    print(Provider.of<NewDataByShipper>(context, listen: false).noOfTrucks);
    print(Provider.of<NewDataByShipper>(context, listen: false).weight);
    print(Provider.of<NewDataByShipper>(context, listen: false).isCommentsEmpty );
    print( Provider.of<NewDataByShipper>(context, listen: false).comments);
    Map data = {
      "loadingPoint": Provider.of<NewDataByShipper>(context, listen: false).loadingPoint,
      "unloadingPoint": Provider.of<NewDataByShipper>(context, listen: false).unloadingPoint,
      "productType": Provider.of<NewDataByShipper>(context, listen: false).productType,
      "truckType": Provider.of<NewDataByShipper>(context, listen: false).truckPreference,
      "noOfTrucks": Provider.of<NewDataByShipper>(context, listen: false).noOfTrucks,
      "weight": Provider.of<NewDataByShipper>(context, listen: false).weight,
      "comment": Provider.of<NewDataByShipper>(context, listen: false).isCommentsEmpty ? '' : Provider.of<NewDataByShipper>(context, listen: false).comments
    };
    String body = json.encode(data);
    final String apiUrl = "http://10.0.2.2:49980/load";
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
              Navigator.pop(context);
            },
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
            onChanged: () {
              Form.of(primaryFocus.context).save();
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Container(
                      color: Color(0xFFF3F2F1),
                      child: ListView(
                        keyboardDismissBehavior:
                            ScrollViewKeyboardDismissBehavior.onDrag,
                        children: [
                          Container(
                            height: 72,
                            child: TextFormField(
                              controller: controller1,
                              onFieldSubmitted: (String value){ Provider.of<NewDataByShipper>(context,listen: false).updateLoadingPoint(newValue:value);} ,
                              onChanged: (newValue) {
                                Provider.of<NewDataByShipper>(context, listen: false).updateLoadingPoint(newValue: newValue);
                                fillCityName(newValue);
                              },
                              onSaved: (value){Provider.of<NewDataByShipper>(context, listen: false).updateLoadingPoint(newValue: value);},
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
                                Provider.of<NewDataByShipper>(context, listen: false).updateUnloadingPoint(newValue: newValue);
                              },
                              onSaved: (value){Provider.of<NewDataByShipper>(context, listen: false).updateUnloadingPoint(newValue: value);},

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

                          GestureDetector(
                            onTap: () {
                              showDialog(context: context, builder: (context)=> ProductTypeWidgetScreen());
                            },
                            child: Container(
                              height: 72,
                              child: DropDownGenerator(
                                dropdownValue: 'Product Type',
                                dropdownValues: [],
                                hintText: Provider.of<NewDataByShipper>(context).productType== null
                                    ? 'Product Type'
                                    :  Provider.of<NewDataByShipper>(context).productType,
                                notAllowedValue: 'Product Type',
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          GestureDetector(
                            onTap: () {
                              showDialog(context: context, builder: (context)=> TruckTypeWidgetScreen());
                            },
                            child: Container(
                              height: 72,
                              child: DropDownGenerator(
                                dropdownValue: 'Truck Preference',
                                dropdownValues: [],
                                hintText: Provider.of<NewDataByShipper>(context).truckPreference== null
                                    ? 'Truck Preference'
                                    :  Provider.of<NewDataByShipper>(context).truckPreference,
                                notAllowedValue: 'Truck Preference',
                              ),
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
                                  child: GestureDetector(
                                    onTap: () {
                                      showDialog(context: context, builder: (context)=>NoOfTrucksWidgetScreen());
                                    },
                                    child: Container(
                                      height: 72,
                                      child: DropDownGenerator(
                                        dropdownValue: 'No Of Trucks',
                                        dropdownValues: [],
                                        hintText: Provider.of<NewDataByShipper>(context).noOfTrucks== '1'
                                            ? '1'
                                            :  Provider.of<NewDataByShipper>(context).noOfTrucks,
                                        notAllowedValue:'No Of Trucks' ,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          GestureDetector(
                            onTap: () {
                              showDialog(context: context, builder: (context)=>WeightWidgetScreen());
                            },
                            child: Container(
                              height: 72,
                              child: DropDownGenerator(
                                dropdownValue: 'Weight(In Tons)',
                                dropdownValues: [],
                                hintText: Provider.of<NewDataByShipper>(context).weight== null
                                    ? 'Weight (In Tons)'
                                    :  Provider.of<NewDataByShipper>(context).weight,
                                notAllowedValue: 'Weight (In Tons)',
                              ),
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
                                Provider.of<NewDataByShipper>(context, listen: false).updateComments(newValue: newValue);
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
                      if (Provider.of<NewDataByShipper>(context, listen: false).productType == null){
                        showDialog(context: context, builder: (context) => ProductTypeWidgetScreen());
                      }
                      else if (Provider.of<NewDataByShipper>(context, listen: false).truckPreference == null){
                        showDialog(context: context, builder: (context) => TruckTypeWidgetScreen());
                      }
                      // else if (Provider.of<NewDataByShipper>(context, listen: false).noOfTrucks == null){
                      //   showDialog(context: context, builder: (context) => NoOfTrucksWidgetScreen());
                      // }
                      else if (Provider.of<NewDataByShipper>(context, listen: false).weight == null){
                        showDialog(context: context, builder: (context) => WeightWidgetScreen());
                      }
                      else{
                      if (Provider.of<NewDataByShipper>(context, listen: false).comments != null) {
                        if (Provider.of<NewDataByShipper>(context, listen: false).comments.isNotEmpty) {
                          if (Provider.of<NewDataByShipper>(context, listen: false).comments != '') {
                            Provider.of<NewDataByShipper>(context, listen: false).updateIsCommentsEmpty(newValue: false);
                          } else {
                            Provider.of<NewDataByShipper>(context, listen: false).updateIsCommentsEmpty(newValue: true);
                          }
                        } else {
                          Provider.of<NewDataByShipper>(context, listen: false).updateIsCommentsEmpty(newValue: true);
                        }
                      } else {
                        Provider.of<NewDataByShipper>(context, listen: false).updateIsCommentsEmpty(newValue: true);
                      }
                      try {
                        final createdCard = await createCardOnApi();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CardScreen(
                              userCity: widget.userCity,
                            ),
                          ),
                        );
                      } catch (e) {
                        print(e);
                      }}
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

// class AlertForNull extends StatefulWidget {
//   @override
//   _AlertForNullState createState() => _AlertForNullState();
// }
//
// class _AlertForNullState extends State<AlertForNull> {
//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(content: SingleChildScrollView(
//         child: ListBody(children: [
//
//         ],),),);
//   }
// }
