import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'home_Screen.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class ShipperLoginScreen extends StatefulWidget {
  @override
  _ShipperLoginScreenState createState() => _ShipperLoginScreenState();
}

class _ShipperLoginScreenState extends State<ShipperLoginScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String mobileNum;
  User user;
  final _codeController = TextEditingController();

  FirebaseAuth _auth = FirebaseAuth.instance;

  bool _disableButton = true;

  Future<bool> loginUser(String phone, BuildContext context) async {
    _auth.verifyPhoneNumber(
      phoneNumber: phone,
      timeout: Duration(seconds: 60),
      verificationCompleted: (AuthCredential credential) async {
        Navigator.of(context).pop();
        UserCredential result = await _auth.signInWithCredential(credential);
        User user = result.user;
        print(user);
        if (user != null) {
          setState(() {
            showProgressHud = false;
          });
          Navigator.pop(context);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => HomeScreen(
                        user: user,
                      )));
        } else {
          setState(() {
            showProgressHud = false;
          });
          print("Error");
        }

        //This callback would gets called when verification is done auto maticlly
      },
      verificationFailed: (FirebaseAuthException exception) {
        print(exception);
      },
      codeSent: (String verificationId, [int forceResendingToken]) {
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) {
              return AlertDialog(
                title: Text('Type Your Code Here '),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    TextField(
                      keyboardType: TextInputType.phone,
                      controller: _codeController,
                    ),
                  ],
                ),
                actions: <Widget>[
                  FlatButton(
                    child: Text("Confirm"),
                    textColor: Colors.white,
                    color: Colors.blue,
                    onPressed: () async {setState(() {
                      showProgressHud = true;
                    });
                      try {
                        final code = _codeController.text.trim();
                        AuthCredential credential =
                            PhoneAuthProvider.credential(
                                verificationId: verificationId, smsCode: code);
                        print(credential);
                        var result =
                            await _auth.signInWithCredential(credential);

                        user = result.user;
                        print(user);
                      } catch (e) {
                        print(e);
                        throw e;
                      }

                      if (user != null) {
                        setState(() {
                          showProgressHud = false;
                        });
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomeScreen(
                                      user: user,
                                    )));
                      } else {
                        print("Error");
                      }
                    },
                  )
                ],
              );
            });
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        print(verificationId);
      },
    );
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool showProgressHud = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        key: _scaffoldKey,
        body: ModalProgressHUD(
          inAsyncCall: showProgressHud,
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 55, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextFormField(
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'Please Enter Mobile Number';
                          } else if (value.length != 10) {
                            return 'Please Enter A Valid Mobile Number';
                          } else
                            return null;
                        },
                        autofocus: true,
                        keyboardType: TextInputType.phone,
                        onChanged: (value) {
                          mobileNum = value;
                          print(mobileNum);
                          if (value.length != 10) {
                            setState(() {
                              _disableButton = true;
                            });
                          } else {
                            setState(() {
                              _disableButton = false;
                            });
                          }
                        },
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          backgroundColor: Colors.black12,
                        ),
                        decoration: InputDecoration(
                            hintText: 'Enter Mobile Number',
                            hintStyle: TextStyle(
                                color: Colors.blueGrey, fontSize: 20)),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      RaisedButton(
                        color: Colors.lightBlueAccent,
                        onPressed: _disableButton
                            ? null
                            : () {
                                if (!formKey.currentState.validate()) {
                                  return;
                                } else {
                                  setState(() {
                                    showProgressHud = true;
                                  });
                                  loginUser('+91$mobileNum', (context));
                                }
                              },
                        child: Text(
                          'Verify',
                          style: TextStyle(
                            fontSize: 25,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 200,
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
        ),
      ),
    );
  }
}
