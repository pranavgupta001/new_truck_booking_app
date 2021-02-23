import 'package:flutter/material.dart';
class DetailCard extends StatelessWidget {
  String productType;
  String loadingPoint;
  String unloadingPoint;
  String truckPreference;
  String noOfTrucks;
  String weight;
  bool isPending;
  String comments;
  bool isCommentsEmpty;

  DetailCard(
      {this.loadingPoint,
        this.unloadingPoint,
        this.productType,
        this.truckPreference,
        this.noOfTrucks,
        this.weight,
        this.isPending,
        this.comments,
        this.isCommentsEmpty});

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
              Text(
                'From $loadingPoint To $unloadingPoint',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              Text(
                'Product Type: $productType Truck Preference: $truckPreference',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              Text(
                'Trucks Required: $noOfTrucks        Weight : $weight ',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              isCommentsEmpty
                  ? Container()
                  : Text(
                'Comments : $comments ',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ],
          ),
          Container(
              color: isPending ? Colors.red : Colors.green,
              padding: EdgeInsets.all(3),
              child: Text(
                isPending ? 'Pending' : 'Approved',
                style: TextStyle(fontSize: 18, color: Colors.white),
                textAlign: TextAlign.right,
              )),
        ],
      ),
    );
  }
}



//
//
// class TasksData extends ChangeNotifier {
//   List<CardTile> cards = [];
//
//   void addTasks(
//       String productType,
//       String loadingPoint,
//       String unloadingPoint,
//       String truckPreference,
//       String noOfTrucks,
//       String weight,
//       bool isPending,
//       String comments,
//       bool isCommentsEmpty,
//       ) {
//     cards.add(CardTile(
//         loadingPoint: loadingPoint,
//         unloadingPoint: unloadingPoint,
//         productType: productType,
//         truckPreference: truckPreference,
//         noOfTrucks: noOfTrucks,
//         weight: weight,
//         isPending: isPending,
//         comments: comments,
//         isCommentsEmpty: isCommentsEmpty));
//     notifyListeners();
//   }
// }
// //
// class MyAlertDialog extends StatelessWidget {
//   final String title;
//   final String content;
//   final List<Widget> actions;
//
//   MyAlertDialog({
//     this.title,
//     this.content,
//     this.actions = const [],
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       title: Text(
//         this.title,
//         style: Theme.of(context).textTheme.title,
//       ),
//       actions: this.actions,
//       content: Text(
//         this.content,
//         style: Theme.of(context).textTheme.body1,
//       ),
//     );
//   }
// }
