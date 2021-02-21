import 'package:flutter/material.dart';
import 'cardGenerator.dart';
import 'package:provider/provider.dart';
String productType;
String loadingPoint;
String unloadingPoint;
String truckPreference;
String noOfTrucks;
String weight;
bool isPending = true;

class ShipperNewEntryScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:  Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 50,),
                  child: Container(
                    child: Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(child: TextField(
                            onChanged: (newValue){loadingPoint = newValue;},
                            decoration: InputDecoration(
                              hintText: 'Loading Point',
                              hintStyle: TextStyle(fontSize: 20, color: Colors.grey),
                            ),
                            style:  TextStyle(fontSize: 20, color: Colors.black),
                          ),),
                          Expanded(child: TextField(
                            onChanged: (newValue){unloadingPoint = newValue;},
                            decoration: InputDecoration(
                              hintText: 'Unloading Point',
                              hintStyle: TextStyle(fontSize: 20, color: Colors.grey),
                            ),
                            style:  TextStyle(fontSize: 20, color: Colors.black),
                          ),),

                          Expanded(child: ProductType(dropdownValue: 'Product_Type', dropdownValues: ['Product_Type', 'Powder', 'Wire Bundles', 'Liquid'], a: 'one',),),

                          Expanded(child: ProductType(dropdownValue: 'Truck Preference', dropdownValues: ['Truck Preference', 'Open','Closed',], a: 'two',),),

                          Expanded(child: ProductType(dropdownValue: 'No. Of Trucks', dropdownValues: ['No. Of Trucks', '1', '2', '3', '4', '5',], a: 'three', ),),

                          Expanded(child: TextField(
                            onChanged: (newValue){weight = newValue;},
                            decoration: InputDecoration(
                              hintText: 'Weight (In Tons)',
                              hintStyle: TextStyle(fontSize: 20, color: Colors.grey),
                            ),
                            style:  TextStyle(fontSize: 20, color: Colors.black),
                          ),),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                height: 70,
                child: FlatButton(
                  onPressed: (){
                    print(loadingPoint);
                    print(unloadingPoint);
                    print(productType);
                    print(truckPreference);
                    print(noOfTrucks);
                    print(weight);
                    try{
                    Provider.of<TasksData>(context, listen: false).addTasks(productType, loadingPoint, unloadingPoint, truckPreference, noOfTrucks, weight, isPending);
                    print(TasksData().cards.length);
                    Navigator.pushNamed(context, '/cards');
                    }
                    catch(e){ print(e);}
                  },
                  color: Colors.redAccent,
                  child: Text('Submit My Request', style: TextStyle(fontSize: 25, ),),),),
            ],
          ),
        ),
      ),
    );
  }
}

class ProductType extends StatefulWidget {
  String dropdownValue;
  List<String> dropdownValues;

  String a;
  ProductType({this.dropdownValue, this.dropdownValues, this.a});
  @override
  _ProductTypeState createState() => _ProductTypeState();
}

class _ProductTypeState extends State<ProductType> {

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: widget.dropdownValue,
      elevation: 16,
      style: TextStyle(color: Colors.grey, fontSize: 18),
      onChanged: (String newValue) {
        setState(() {
          widget.dropdownValue = newValue;
          if (widget.a=='one'){
            productType = newValue;
          }

          else if (widget.a == 'two'){
            truckPreference = newValue;
          }
          else if (widget.a == 'three'){
            noOfTrucks = newValue;
          }
        });
      },
      items: widget.dropdownValues
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
