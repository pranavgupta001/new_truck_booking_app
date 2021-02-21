import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CardTile{
  String productType;
  String loadingPoint;
  String unloadingPoint;
  String truckPreference;
  String noOfTrucks;
  String weight;
  bool isPending;
  CardTile({this.loadingPoint, this.unloadingPoint, this.productType, this.truckPreference, this.noOfTrucks, this.weight, this.isPending = true});
}
class DetailCard extends StatelessWidget {
  String productType;
  String loadingPoint;
  String unloadingPoint;
  String truckPreference;
  String noOfTrucks;
  String weight;
  bool isPending;
  DetailCard({this.loadingPoint, this.unloadingPoint, this.productType, this.truckPreference, this.noOfTrucks, this.weight, this.isPending});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      color: Colors.lightGreenAccent,
      padding: EdgeInsets.only(left: 15, top: 5, bottom: 5, right: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('From $loadingPoint To $unloadingPoint', style: TextStyle(fontSize: 18,),),
              Text('Product Type: $productType Truck Preference: $truckPreference', style:TextStyle(fontSize: 18,),),
              Text('Trucks Required: $noOfTrucks        Weight : $weight tons', style:TextStyle(fontSize: 18,),),

            ],
          ),
          Container(
              color: isPending ? Colors.red : Colors.green,
              padding: EdgeInsets.all(3),
              child: Text(isPending? 'Pending' : 'Approved', style:TextStyle(fontSize: 18, color: Colors.white),  textAlign: TextAlign.right,)),
        ],
      ),
    );
  }
}


class TasksData extends ChangeNotifier{
  List<CardTile> cards = [
    CardTile(loadingPoint: 'alw', unloadingPoint: 'del', productType: 'powder', truckPreference: 'open', noOfTrucks: 'two', weight: '24', isPending: true,  ),
  ];

  void addTasks(  String productType,
  String loadingPoint,
  String unloadingPoint,
  String truckPreference,
  String noOfTrucks,
  String weight,
  bool isPending,){
    cards.add(CardTile( loadingPoint: loadingPoint, unloadingPoint: unloadingPoint,productType: productType, truckPreference: truckPreference, noOfTrucks: noOfTrucks, weight: weight, isPending: isPending,));
    notifyListeners();
  }
}

class CardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Center(child: Text('Available Requests')),
        ),
        body: Padding(
          padding: EdgeInsets.all(15),
          child: Consumer<TasksData>(
            builder: (context, tasksData, child) =>  ListView.builder(
              itemCount: tasksData.cards.length,
              itemBuilder: (context, index) => DetailCard(loadingPoint: tasksData.cards[index].loadingPoint , unloadingPoint: tasksData.cards[index].unloadingPoint, productType: tasksData.cards[index].productType, truckPreference: tasksData.cards[index].truckPreference, noOfTrucks: tasksData.cards[index].noOfTrucks, weight: tasksData.cards[index].weight, isPending: tasksData.cards[index].isPending,),
            ),
          ),
        ),
      ),
    );
  }
}


