import 'package:flutter/material.dart';
import 'package:truck_booking_app/widgets/backend_connection.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:truck_booking_app/widgets/cardProperties.dart';
var controller1 = TextEditingController();
var controller2 = TextEditingController();
var controller3 = TextEditingController();
String loadingPoint;
String unloadingPoint;

class FindLoadScreen extends StatefulWidget {
  @override
  _FindLoadScreenState createState() => _FindLoadScreenState();
}

final GlobalKey<FormState> formKey = GlobalKey<FormState>();

class _FindLoadScreenState extends State<FindLoadScreen> {
  var jsonData;

  Future<List<CardsModal>> getCardsData() async {
    http.Response response = await http.get('http://localhost:50186/load');
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
                          Flexible(
                            child: Container(
                              height: 230,
                              child: FutureBuilder(
                                  future: getCardsData(),
                                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                                    if (snapshot.data == null) {
                                      return Container(
                                        child: Center(
                                          child: Icon(
                                            Icons.error,
                                            color: Colors.red,
                                            size: 50,
                                          ),
                                        ),
                                      );
                                    }
                                    return ListView.builder(
                                      reverse: false,
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 10,
                                      ),
                                      itemCount: snapshot.data.length,
                                      itemBuilder: (context, index) => DetailCard(
                                        loadingPoint: snapshot.data[index].loadingPoint,
                                        unloadingPoint: snapshot.data[index].unloadingPoint,
                                        productType: snapshot.data[index].productType,
                                        truckPreference: snapshot.data[index].truckType,
                                        noOfTrucks: snapshot.data[index].noOfTrucks,
                                        weight: snapshot.data[index].weight,
                                        isPending: snapshot.data[index].status == 'pending'
                                            ? true
                                            : false,
                                        comments: snapshot.data[index].comment,
                                        isCommentsEmpty:
                                        snapshot.data[index].comment == '' ? true : false,
                                      ),
                                    );
                                  }),
                            ),
                          ),
                        ],
                      ),
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
