import 'package:flutter/material.dart';
import 'package:truck_booking_app/backend_connection.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:truck_booking_app/home_Screen.dart';
import 'package:truck_booking_app/shipper_new_entry.dart';
import 'cardProperties.dart';

String mapKey = "AIzaSyCTVVijIWofDrI6LpSzhUqJIF90X-iyZmE";

class CardTile {
  String productType;
  String loadingPoint;
  String unloadingPoint;
  String truckPreference;
  String noOfTrucks;
  String weight;
  bool isPending;
  String comments;
  bool isCommentsEmpty;

  CardTile(
      {this.loadingPoint,
      this.unloadingPoint,
      this.productType,
      this.truckPreference,
      this.noOfTrucks,
      this.weight,
      this.isPending = true,
      this.comments,
      this.isCommentsEmpty});
}

class CardScreen extends StatefulWidget {
  String userCity = '';

  CardScreen({this.userCity});

  @override
  _CardScreenState createState() => _CardScreenState();
}

class _CardScreenState extends State<CardScreen> {
  var jsonData;

  Future<List<CardsModal>> getCardsData() async {
    http.Response response = await http.get('http://10.0.2.2:49980/load');
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
          backgroundColor: Colors.black87,
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back_ios, size: 25),
          ),
          title: Text(
            'Available Requests',
            textAlign: TextAlign.center,
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
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
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomeScreen(
                                      userCity: widget.userCity,
                                    ),),);
                      },
                      child: Hero(
                        tag: 'home',
                        child: Icon(
                          Icons.home,
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
                            builder: (context) => ShipperNewEntryScreen(
                              userCity: widget.userCity,
                            ),
                          ),
                        );
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
                                      userCity: widget.userCity,
                                    )));
                      },
                      child: Hero(
                        tag: 'list',
                        child: Icon(
                          Icons.list,
                          size: 40,
                          color: Colors.blue,
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
