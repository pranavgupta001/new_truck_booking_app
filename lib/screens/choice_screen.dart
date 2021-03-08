import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

class ChoiceScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: GestureDetector(
        onTap: (){FocusScope.of(context).unfocus();},
        child: Scaffold(
          backgroundColor: Color(0xFFF3F2F1),
          appBar: AppBar(
            backgroundColor: Colors.black54,
            title: Center(
              child: Text(
                'Register Now!!',
                style: TextStyle(fontSize: 15),
              ),
            ),
          ),
          body: SafeArea(
            child: Container(
              padding: EdgeInsets.only(left: 10, right: 10,),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Card(
                    color: Colors.white,
                    elevation: 2,
                    shadowColor: Color(0xFFFAECEC),
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        children: [
                          CircleAvatar(child: Icon(Icons.person, color: Colors.white,),backgroundColor: Colors.black87,),
                          SizedBox(height: 5,),
                          Text(
                            'Shipper',
                            style: TextStyle(fontSize: 25, color: Colors.black),
                          ),
                          SizedBox(height: 5,),
                          FlatButton(
                            color: Color(0xFF6264A7),
                            onPressed: () async {
                              WidgetsFlutterBinding.ensureInitialized();
                              await Firebase.initializeApp();
                              // Navigator.pop(context);
                              Navigator.pushNamed(context, '/login1');
                            },
                            child: Text(
                              'Register',
                              style: TextStyle(fontSize: 25, ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // SizedBox(height: 100,),
                  Container(
                    child: FlatButton(
                      child: Text('Cards', style: TextStyle(color: Colors.black87,fontSize: 30),),
                      onPressed: (){Navigator.pushNamed(context, '/tsHome');},
                    ),
                  ),
                  Card(
                    color: Colors.white,
                    elevation: 2,
                    shadowColor: Color(0xFFFAECEC),
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CircleAvatar(child: Icon(Icons.construction,color: Colors.white,),backgroundColor: Colors.black87,   ),
                          SizedBox(height: 5,),
                          Text(
                            'Transporter',
                            style: TextStyle(fontSize: 25, color: Colors.black),
                          ),
                          SizedBox(height: 5,),
                          FlatButton(
                            color: Color(0xFF6264A7),
                            onPressed: () async {
                              WidgetsFlutterBinding.ensureInitialized();
                              await Firebase.initializeApp();
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
