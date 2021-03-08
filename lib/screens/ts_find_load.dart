import 'package:flutter/material.dart';
import 'package:truck_booking_app/widgets/backend_connection.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
var controller1 = TextEditingController();
var controller2 = TextEditingController();
var controller3 = TextEditingController();
String loadingPoint;
String unloadingPoint;
String apikey = 'AIzaSyCI8bvNwE05B7Cp03Rvc-QsMX9QjY-EsS4';

class TsFindLoadScreen extends StatefulWidget {
  @override
  _TsFindLoadScreenState createState() => _TsFindLoadScreenState();
}

final GlobalKey<FormState> formKey = GlobalKey<FormState>();

class _TsFindLoadScreenState extends State<TsFindLoadScreen> {
  var jsonData;

  Future<List<CardsModal>> getCardsData() async {
    http.Response response = await http.get('http://10.0.2.2:51636/load');
    jsonData = await jsonDecode(response.body);
    print(response.statusCode);
    print(jsonData);
    List<CardsModal> card = [];
    for (var json in jsonData) {
      CardsModal cardsModal = new CardsModal();
      cardsModal.loadingPoint = json["loadingPoint"];
      cardsModal.unloadingPoint = json["unloadingPoint"];
      cardsModal.productType = json["productType"];
      cardsModal.truckType = json["truckType"];
      cardsModal.noOfTrucks = json["noOfTrucks"];
      cardsModal.weight = json["weight"];
      cardsModal.comment = json["comment"];
      cardsModal.status = json["status"];
      card.add(cardsModal);
    }
    return card;
  }
  @override
  Widget build(BuildContext context) {
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
              'Find Load',
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
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 0 ),
                      child: Container(
                        color: Color(0xFFF3F2F1),
                        child: ListView(
                          keyboardDismissBehavior:
                              ScrollViewKeyboardDismissBehavior.onDrag,
                          children: [
                            Container(
                              height: 72,
                              child: TextFormField(
                                autofocus: true,
                                // onFieldSubmitted: (String value) {
                                //   loadingPoint = value;
                                // },
                                onChanged: (newValue) {
                                  loadingPoint = newValue.trim();
                                },
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
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              height: 72,
                              child: TextFormField(
                                autofocus: true,
                                onChanged: (newValue) {
                                  unloadingPoint = newValue.trim();
                                },
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
                            SizedBox(
                              height: 30,
                            ),
                            Container(
                              height: 50,
                              child: FlatButton(
                                onPressed: () async {
                                  if (!formKey.currentState.validate()) {
                                    return;
                                  }
                                  print(loadingPoint);
                                  print(unloadingPoint);
                                },
                                color: Color(0xFF043979),
                                child: Text(
                                  'Find',
                                  style: TextStyle(fontSize: 25, color: Colors.white),
                                ),
                              ),
                            ),
                            SizedBox(height: 15,),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // FutureBuilder(
                  //     future: getCardsData(),
                  //     builder: (BuildContext context, AsyncSnapshot snapshot) {
                  //       if (snapshot.data == null) {
                  //         return Container(
                  //           child: Center(
                  //               child: SpinKitDoubleBounce(
                  //                 color: Colors.red,
                  //                 size: 40,
                  //               )
                  //           ),
                  //         );
                  //       }
                  //       return Container(
                  //         height: 200,
                  //         child: ListView.builder(
                  //           reverse: false,
                  //           padding: EdgeInsets.symmetric(
                  //             horizontal: 10,
                  //           ),
                  //           itemCount: snapshot.data.length,
                  //           itemBuilder: (context, index) => DetailCard(
                  //             loadingPoint: snapshot.data[index].loadingPoint,
                  //             unloadingPoint: snapshot.data[index].unloadingPoint,
                  //             productType: snapshot.data[index].productType,
                  //             truckPreference: snapshot.data[index].truckType,
                  //             noOfTrucks: snapshot.data[index].noOfTrucks,
                  //             weight: snapshot.data[index].weight,
                  //             isPending: snapshot.data[index].status.toString().toLowerCase() == 'pending'
                  //                 ? true
                  //                 : false,
                  //             comments: snapshot.data[index].comment,
                  //             isCommentsEmpty:
                  //             snapshot.data[index].comment == '' ? true : false,
                  //           ),
                  //         ),
                  //       );
                  //     }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
