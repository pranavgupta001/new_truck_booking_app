
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providerData.dart';
class DropDownGenerator extends StatefulWidget {
  String dropdownValue;
  List<String> dropdownValues;
  String notAllowedValue;
  String dropDownNumber;
  String hintText = ' ';
  DropDownGenerator(
      {this.dropdownValue,
        this.dropdownValues,
        this.dropDownNumber,
        this.notAllowedValue,
        this.hintText});

  @override
  _DropDownGeneratorState createState() => _DropDownGeneratorState();
}

class _DropDownGeneratorState extends State<DropDownGenerator> {
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: widget.dropdownValue,
      hint: Text(
        '${widget.hintText}',
        style: TextStyle(color: Colors.grey),
      ),
      iconDisabledColor: Colors.black54,
      elevation: 16,
      style: TextStyle(color: Colors.grey, fontSize: 18),
      onChanged: (String newValue) {
        setState(() {
          widget.dropdownValue = newValue;
          if (widget.dropDownNumber == 'three') {
            Provider.of<NewDataByShipper>(context, listen: false).updateNoOfTrucks(newValue: newValue);
          } else if (widget.dropDownNumber == 'four') {
            Provider.of<NewDataByShipper>(context, listen: false).updateWeight(newValue: newValue);
          }
        });
      },
      items:
      widget.dropdownValues.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      validator: (String value) {
        if (widget.notAllowedValue == null) {
          return null;
        }
        if (value != widget.notAllowedValue) {
          return null;
        } else {
          if (widget.dropDownNumber == 'one') {
            return 'Product Type is Required';
          } else if (widget.dropDownNumber == 'four') {
            return 'weight is Required';
          }
          return null;
        }
      },
    );
  }
}
