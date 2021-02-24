import 'package:flutter/material.dart';
import 'package:truck_booking_app/backend_connection.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'cardProperties.dart';

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
//
// Future<List<CardsModal>> getCardsData() async {
//   var Url = 'http://localhost:58464/load';
//   var response = await http.post(Url);
//   String responseString = response.body;
//   var jsonData = json.decode(responseString);
//   List<CardsModal> card = [];
//   for (var json in jsonData) {
//     print(json);
//     CardsModal cardsModal = new CardsModal();
//     cardsModal.loadingPoint = json["loadingPoint"];
//     cardsModal.unloadingPoint = json["unloadingPoint"];
//     cardsModal.productType = json["productType"];
//     cardsModal.truckType = json["truckType"];
//     cardsModal.noOfTrucks = json["noOfTrucks"];
//     cardsModal.weight = json["weight"];
//     cardsModal.comment = json["comment"];
//     cardsModal.status = json["status"];
//     card.add(cardsModal);
//   }
//   return card;
// }
//

class CardScreen extends StatefulWidget {
  @override
  _CardScreenState createState() => _CardScreenState();
}

class _CardScreenState extends State<CardScreen> {
  var jsonData;

  Future<List<CardsModal>> getCardsData() async {
    http.Response response = await http.get('http://10.0.2.2:58464/load');
    jsonData = await jsonDecode(response.body);
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
      home: Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text('Available Requests'),
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
                          child: Icon(Icons.error),
                        ),
                      );
                    }
                    return ListView.builder(
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
