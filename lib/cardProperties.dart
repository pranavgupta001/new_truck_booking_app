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
    return Card(
      color: Color(0xFFF3F2F1),
      elevation: 5,
      child: Container(
        margin: EdgeInsets.all(8),
        padding: EdgeInsets.only(right: 8, top: 10, bottom: 8, left: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    border: Border.symmetric(
                      horizontal: BorderSide(
                        color: Colors.grey,
                        width: 0.5,
                      ),
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/tanker.jpeg'),
                            // colorFilter: ColorFilter.mode(
                            //     Colors.white.withOpacity(0.8), BlendMode.dstATop),
                          ),
                        ),
                      ),
                      // CircleAvatar(
                      //   radius: 25,
                      //   backgroundColor: Colors.black45,
                      //   // child: Icon(
                      //   //   Icons.upload_rounded,
                      //   //   color: Colors.white,
                      //   // ),
                      // ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        '$loadingPoint - $unloadingPoint',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  'Product Type: $productType',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                SizedBox(
                  height: 3,
                ),
                Text(
                  'Truck Type: $truckPreference',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                SizedBox(
                  height: 3,
                ),
                Text(
                  'Trucks Required: $noOfTrucks',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                SizedBox(
                  height: 3,
                ),
                Text(
                  'Weight : $weight ',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                SizedBox(
                  height: 3,
                ),
                isCommentsEmpty
                    ? Container()
                    : Container(
                        child: Text(
                        'Comments : $comments ',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      )),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
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
          ],
        ),
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
