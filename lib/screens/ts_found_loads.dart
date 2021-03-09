import 'package:flutter/material.dart';
import 'package:truck_booking_app/screens/ts_find_load.dart';
import 'package:truck_booking_app/widgets/backend_connection.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:truck_booking_app/widgets/cardProperties.dart';

// ignore: must_be_immutable
class TsFoundLoadsScreen extends StatefulWidget {
  String searchedLoadingPoint;
  String searchedUnloadingPoint;

  TsFoundLoadsScreen({this.searchedLoadingPoint, this.searchedUnloadingPoint});

  @override
  _TsFoundLoadsScreenState createState() => _TsFoundLoadsScreenState();
}

class _TsFoundLoadsScreenState extends State<TsFoundLoadsScreen> {
  var jsonData;

  Future<List<CardsModal>> getCardsData() async {
    http.Response response = await http.get('http://10.0.2.2:52698/load');
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
    List<CardsModal> sortedCard = [];
    for (int i = 0; i < card.length; i++) {
      if (card[i].loadingPoint.toLowerCase().contains(widget.searchedLoadingPoint.toLowerCase()) &&
          card[i].unloadingPoint.toLowerCase().contains(widget.searchedUnloadingPoint.toLowerCase())) {
        sortedCard.add(card[i]);
      } else if (card[i].loadingPoint.toLowerCase().contains(widget.searchedLoadingPoint.toLowerCase()) &&
          (widget.searchedUnloadingPoint.trim() == '' || widget.searchedUnloadingPoint == null)) {
        sortedCard.add(card[i]);
      } else if (card[i].unloadingPoint.toLowerCase().contains(widget.searchedUnloadingPoint.toLowerCase()) &&
          (widget.searchedLoadingPoint == null || widget.searchedLoadingPoint.trim() == '')) {
        sortedCard.add(card[i]);
      }
    }
    return sortedCard;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color(0xFFF3F2F1),
        appBar: AppBar(
          backgroundColor: Colors.black87,
          title: Text('Matching Loads'),
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back_ios, size: 25),
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: FutureBuilder(
              future: getCardsData(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.data == null || snapshot.data.length == 0 ) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(
                        child: Text(
                          'No Matching Data found',
                          style: TextStyle(fontSize: 25),
                        ),
                      ),
                      SizedBox( height: 30,),
                      GestureDetector(onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => TsFindLoadScreen()));},
                          child: Container(
                              color: Color(0xFF043979),
                              padding: EdgeInsets.all(8),
                              child: Text('Re-Enter Details', style: TextStyle(fontSize: 25, color: Colors.white),)))
                    ],
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
                    isPending:
                        snapshot.data[index].status.toString().toLowerCase() ==
                                'pending'
                            ? true
                            : false,
                    comments: snapshot.data[index].comment,
                    isCommentsEmpty:
                        snapshot.data[index].comment == '' ? true : false,
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
