import 'dart:io';
import 'package:truck_booking_app/widgets/LoadingPointSeachScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:truck_booking_app/screens/cardGenerator.dart';
import 'package:provider/provider.dart';
import 'package:truck_booking_app/widgets/weight_modal_screen.dart';
import 'package:truck_booking_app/widgets/noOfTrucks_modal_screen.dart';
import 'package:truck_booking_app/widgets/backend_connection.dart';
import 'package:truck_booking_app/widgets/providerData.dart';
import 'package:truck_booking_app/widgets/dropDownGenerator.dart';
import 'package:truck_booking_app/widgets/product_type_modal_screen.dart';
import 'package:truck_booking_app/widgets/truck_type_modal_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
String mapKey = "AIzaSyCTVVijIWofDrI6LpSzhUqJIF90X-iyZmE";

var controller1 = TextEditingController();
var controller2 = TextEditingController();
var controller3 = TextEditingController();

// ignore: must_be_immutable
class ShipperNewEntryScreen extends StatefulWidget {
  String userCity = '';
  User user;
  ShipperNewEntryScreen({this.user, this.userCity});
  @override
  _ShipperNewEntryScreenState createState() => _ShipperNewEntryScreenState();
}

class _ShipperNewEntryScreenState extends State<ShipperNewEntryScreen> {
  @override

  void initState() {
    super.initState();
    controller1.clear();
    controller2.clear();
    controller3.clear();
    if(widget.userCity != '' && widget.userCity != null){
    controller1 = TextEditingController(text: widget.userCity);}
  }
  Future<List<LoactionCardsModal>> fillCityName(String cityName) async {
    if (cityName.length > 1) {
      http.Response tokenGet = await http.post('https://outpost.mapmyindia.com/api/security/oauth/token?grant_type=client_credentials&client_id=33OkryzDZsJmp0siGnK04TeuQrg3DWRxswnTg_VBiHew-2D1tA3oa3fthrGnx4vwbwlbF_xT2T4P9dykuS1GUNmbRb8e5CUgz-RgWDyQspeDCXkXK5Nagw==&client_secret=lrFxI-iSEg9xHXNZXiqUoprc9ZvWP_PDWBDw94qhrze0sUkn7LBDwRNFscpDTVFH7aQT4tu6ycN0492wqPs-ewpjObJ6xuR7iRufmSVcnt9fys5dp0F5jlHLxBEj7oqq');
      var body = jsonDecode(tokenGet.body);
      var token = body["access_token"];
      http.Response response1 = await http.get('https://atlas.mapmyindia.com/api/places/search/json?query=$cityName&pod=CITY',
        headers: {HttpHeaders.authorizationHeader: 'Bearer $token'},);
      print(response1.statusCode);
      var adress = (jsonDecode(response1.body));
      adress = adress["suggestedLocations"];
      List<LoactionCardsModal> card = [];
      for ( var json in adress) {
        LoactionCardsModal loactionCardsModal = new LoactionCardsModal();
        loactionCardsModal.placeName = json["placeName"];
        loactionCardsModal.placeAddress = json["placeAddress"];
        card.add(loactionCardsModal);
      }
      card = card..sort((a,b) => a.placeName.toString().compareTo(b.placeName.toString()));
      return card;
    }
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
    final String apiUrl = "http://10.0.2.2:52698/load";
    final response = await http.post(apiUrl,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: body);
    Provider.of<NewDataByShipper>(context,listen: false).clearAll();
    ProductTypeWidgetScreen().clear_all();
    TruckTypeWidgetScreen().clear_all();
    WeightWidgetScreen().clear_all();
    print(response.statusCode);
    if (response.statusCode == 200) {
      final String responseString = response.body;
      return cardsModalFromJson(responseString);
    } else {
      return null;
    }
  }
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var LocationCards1;
  var LocationCards2;
  DateTime date = DateTime.now();
  void getDate(BuildContext context) async {
    DateTime pickedDate = await showDatePicker(
        context: context, initialDate: date, firstDate: DateTime.now(), lastDate: DateTime(DateTime.now().year, DateTime.now().month, 31));
    if(pickedDate !=null){
      setState(() {
        date = pickedDate;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    if (Provider.of<NewDataByShipper>(context).loadingPoint != null){
      controller1 = TextEditingController(text:(Provider.of<NewDataByShipper>(context).loadingPoint));}
    if (Provider.of<NewDataByShipper>(context).unloadingPoint != null){
      controller2 = TextEditingController(text:(Provider.of<NewDataByShipper>(context).unloadingPoint));}
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: GestureDetector(
        onTap: (){FocusScope.of(context).unfocus();},
        child: Scaffold(
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
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Expanded(
                                    child: TextFormField(
                                      keyboardType: TextInputType.streetAddress,
                                      controller: controller1,
                                      onChanged: (newValue) {
                                        if(newValue.length > 2){print(newValue);
                                        setState(() {
                                          LocationCards1 = fillCityName(newValue);
                                        });}
                                        else{
                                          setState(() {
                                            LocationCards1 = null;
                                          });
                                        }
                                      },
                                      onFieldSubmitted: (String value){ Provider.of<NewDataByShipper>(context, listen: false).updateLoadingPoint(newValue:value.trim());} ,
                                     decoration: InputDecoration(
                                        hintText: 'Loading Point',
                                        hintStyle:
                                            TextStyle(fontSize: 20, color: Colors.grey),
                                      ),
                                      validator: (String value) {
                                        if (value.trim().isEmpty) {
                                          return 'Loading Point is Required';
                                        } else
                                          return null;
                                      },
                                      style:
                                          TextStyle(fontSize: 20, color: Colors.black),
                                    ),
                                  ),
                                  Container(
                                    child: GestureDetector(onTap:(){setState(() {
                                      Provider.of<NewDataByShipper>(context,listen: false).updateLoadingPoint(newValue: null);
                                      LocationCards1 = null;
                                      controller1 = TextEditingController(text: null);
                                    });} ,child: Icon(Icons.clear,size: 25, color: Colors.black26,)),
                                  )
                                ],
                              ),
                            ),
                            LocationCards1 == null ? Container(): SizedBox(height: 20,),
                            LocationCards1 != null ? Container(
                              height: 150,
                              child: FutureBuilder(
                                future: LocationCards1,
                                builder: (BuildContext context,  AsyncSnapshot snapshot ){
                                  if (snapshot.data == null) {
                                    return Container(
                                      child: Center(
                                        child: SpinKitDoubleBounce(
                                          color: Colors.blue,
                                          size: 20,
                                        ),),
                                    );
                                  }
                                  return ListView.builder(
                                      reverse: false,
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 10,
                                      ),
                                      itemCount: snapshot.data.length,
                                      itemBuilder: (context, index) => buildCard(
                                          placeName: snapshot.data[index].placeName,
                                          placeAddress: snapshot.data[index].placeAddress,
                                          CardType: 'loading',
                                          context: context)
                                  );}),) : Container(),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              height: 72,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Expanded(
                                    child: TextFormField(
                                      keyboardType: TextInputType.streetAddress,
                                      controller: controller2,
                                      onChanged: (newValue) {
                                        if(newValue.length > 2){print(newValue);
                                        setState(() {
                                          LocationCards2 = fillCityName(newValue);
                                        });}
                                        else{
                                          setState(() {
                                            LocationCards2 = null;
                                          });
                                        }
                                      },
                                      onFieldSubmitted: (String value){ Provider.of<NewDataByShipper>(context, listen: false).updateUnloadingPoint(newValue:value.trim());} ,
                                      decoration: InputDecoration(
                                        hintText: 'Unloading Point',
                                        hintStyle:
                                        TextStyle(fontSize: 20, color: Colors.grey),
                                      ),
                                      validator: (String value) {
                                        if (value.trim().isEmpty) {
                                          return 'Unloading Point is Required';
                                        } else
                                          return null;
                                      },
                                      style:
                                      TextStyle(fontSize: 20, color: Colors.black),
                                    ),
                                  ),
                                  Container(
                                    child: GestureDetector(onTap:(){setState(() {
                                      Provider.of<NewDataByShipper>(context,listen: false).updateUnloadingPoint(newValue: null);
                                      LocationCards2 = null;
                                      controller2= TextEditingController(text: null);
                                    });} ,child: Icon(Icons.clear, size: 25, color: Colors.black26,)),
                                  )
                                ],
                              ),
                            ),
                            LocationCards2 == null ? Container(): SizedBox(height: 20,),
                            LocationCards2 != null ? Container(
                              height: 150,
                              child: FutureBuilder(
                                  future: LocationCards2,
                                  builder: (BuildContext context,  AsyncSnapshot snapshot ){
                                    if (snapshot.data == null) {
                                      return Container(
                                        child: Center(
                                          child: SpinKitDoubleBounce(
                                            color: Colors.blue,
                                            size: 20,
                                          ),),
                                      );
                                    }
                                    return ListView.builder(
                                        reverse: false,
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 10,
                                        ),
                                        itemCount: snapshot.data.length,
                                        itemBuilder: (context, index) => buildCard(
                                            placeName: snapshot.data[index].placeName,
                                            placeAddress: snapshot.data[index].placeAddress,
                                            CardType: 'unloading',
                                            context: context,)
                                    );}),) : Container(),
                            SizedBox(
                              height: 10,
                            ),

                            GestureDetector(
                              onTap: () {
                                FocusScope.of(context).unfocus();
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
                                FocusScope.of(context).unfocus();
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
                                        FocusScope.of(context).unfocus();
                                        showDialog(context: context, builder: (context)=> NoOfTrucksWidgetScreen());
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
                            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    FocusScope.of(context).unfocus();
                                    showDialog(context: context, builder: (context)=>WeightWidgetScreen());
                                  },
                                  child: Container(
                                    height: 72,
                                    width: 180,
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
                                SizedBox(width: 5,),
                                GestureDetector(
                                  onTap: () {
                                    getDate(context);
                                  },
                                  child: Container(
                                    height: 72,
                                    width: 120,
                                    child: DropDownGenerator(
                                      dropdownValue: 'Select Date',
                                      dropdownValues: [],
                                      hintText: '${date.day.toString()}-${date.month.toString()}-${date.year.toString()}',
                                      notAllowedValue: 'Select Date',
                                    ),
                                  ),
                                ),
                              ],
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
                        if (Provider.of<NewDataByShipper>(context,listen: false).loadingPoint == null){
                          print('loading Point Null');
                          throw 'Loading Point Null';
                        }
                        if (Provider.of<NewDataByShipper>(context,listen: false).unloadingPoint == null){
                          print('Unloading Point Null');
                          throw 'Unloading Point Null';
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
      ),
    );
  }
  GestureDetector buildCard({BuildContext context, String placeName, String placeAddress, String CardType}) {
    return GestureDetector(
      onTap: (){
        setState(() {
          if (CardType == 'loading'){
          LocationCards1 = null;
          Provider.of<NewDataByShipper>(context,listen: false).updateLoadingPoint(newValue: '$placeName ($placeAddress)');}
          else if (CardType =='unloading'){
            LocationCards2 = null;
            Provider.of<NewDataByShipper>(context,listen: false).updateUnloadingPoint(newValue: '$placeName ($placeAddress)');}
        });
      },
      child: Container(
        color: Color(0xFFF3F2F1),
        padding: EdgeInsets.all(3),
        child: Text('$placeName ($placeAddress)', style: TextStyle(fontSize: 15),),
      ),
    );
  }
}