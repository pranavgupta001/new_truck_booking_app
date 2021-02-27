import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

class ChoiceScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text(
              'Register Now!!',
              style: TextStyle(fontSize: 15),
            ),
          ),
        ),
        backgroundColor: Colors.lightBlueAccent,
        body: SafeArea(
          child: Container(
            padding: EdgeInsets.only(top: 50, left: 10, right: 10, bottom: 200),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Card(
                  elevation: 10,
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        CircleAvatar(child: Icon(Icons.person)),
                        Text(
                          'Shipper',
                          style: TextStyle(fontSize: 25, color: Colors.green),
                        ),
                        FlatButton(
                          color: Colors.lightBlueAccent,
                          onPressed: () async {
                            WidgetsFlutterBinding.ensureInitialized();
                            await Firebase.initializeApp();
                            Navigator.pop(context);
                            Navigator.pushNamed(context, '/login1');
                          },
                          child: Text(
                            'Register',
                            style: TextStyle(fontSize: 25),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Card(
                  elevation: 10,
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CircleAvatar(child: Icon(Icons.construction)),
                        Text(
                          'Transporter',
                          style: TextStyle(fontSize: 25, color: Colors.green),
                        ),
                        FlatButton(
                          color: Colors.lightBlueAccent,
                          onPressed: () async {
                            WidgetsFlutterBinding.ensureInitialized();
                            await Firebase.initializeApp();
                            Navigator.pop(context);
                            Navigator.pushNamed(context, '/login2');
                          },
                          child: Text(
                            'Register',
                            style: TextStyle(fontSize: 25),
                          ),
                        ),
                      ],
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

// Card(
//   child: Column(
//     mainAxisAlignment: MainAxisAlignment.center,
//     crossAxisAlignment: CrossAxisAlignment.center,
//     children: [
//       Row(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: [
//           Container(
//             color: Colors.white,
//             padding: EdgeInsets.all(10),
//             child: Text(
//               'Shipper',
//               style: TextStyle(fontSize: 25),
//             ),
//           ),
//           Container(
//             color: Colors.white,
//             padding: EdgeInsets.all(10),
//             child: FlatButton(
//
//                 onPressed: () async{
//                   WidgetsFlutterBinding.ensureInitialized();
//                   await Firebase.initializeApp();
//                   Navigator.pop(context);
//                   Navigator.pushNamed(context, '/login1');
//                 },
//                 child: Text(
//                   'Register',
//                   style: TextStyle(fontSize: 25),
//                 )),
//           ),
//         ],
//       ),
//       SizedBox(
//         height: 20,
//       ),
//       Row(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: [
//           Container(
//             color: Colors.white,
//             padding: EdgeInsets.all(10),
//             child: Text(
//               'Transporter',
//               style: TextStyle(fontSize: 25),
//             ),
//           ),
//           Container(
//             color: Colors.white,
//             padding: EdgeInsets.all(10),
//             child: FlatButton(
//                 onPressed: () async {
//                   WidgetsFlutterBinding.ensureInitialized();
//                   await Firebase.initializeApp();
//                   Navigator.pop(context);
//                   Navigator.pushNamed(context, '/login2');
//                 },
//                 child: Text(
//                   'Register',
//                   style: TextStyle(fontSize: 25),
//                 )),
//           ),
//         ],
//       )
//     ],
//   ),
// ),
