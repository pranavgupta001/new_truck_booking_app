import 'package:flutter/material.dart';

class ChoiceScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:  Scaffold(
        backgroundColor: Colors.lightBlueAccent,

        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20,),
            child: Container(
              child: Column(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(child: Text('Shipper', style: TextStyle(fontSize: 25),),
                        ),
                        Expanded(child: FlatButton(
                            onPressed: (){
                              Navigator.pushNamed(context, '/login1');
                            },
                            child: Text('Register', style: TextStyle(fontSize: 25),)),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(child: Text('Transporter', style: TextStyle(fontSize: 25),),
                        ),
                        Expanded(child: FlatButton(onPressed: (){
                          Navigator.pushNamed(context, '/login2');
                        }, child: Text('Register', style: TextStyle(fontSize: 25),)),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
