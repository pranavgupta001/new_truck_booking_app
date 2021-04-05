import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:Liveasy/widgets/providerData.dart';

Color color_Unselected = Colors.white;
Color color_Selected = Colors.black45;
Color color_1 = color_Unselected;
Color color_2 = color_Unselected;
Color color_3 = color_Unselected;
Color color_4 = color_Unselected;
Color color_5 = color_Unselected;
Color color_6 = color_Unselected;
Color color_7 = color_Unselected;
Color color_8 = color_Unselected;
Color color_9 = color_Unselected;
Color color_10 = color_Unselected;
Color color_11 = color_Unselected;
Color color_12 = color_Unselected;

class ProductTypeWidgetScreen extends StatefulWidget {
  void clear_all(){
    color_1 = color_Unselected;
    color_2 = color_Unselected;
    color_3 = color_Unselected;
    color_4 = color_Unselected;
    color_5 = color_Unselected;
    color_6 = color_Unselected;
    color_7 = color_Unselected;
    color_8 = color_Unselected;
    color_9 = color_Unselected;
    color_10 = color_Unselected;
    color_11 = color_Unselected;
    color_12 = color_Unselected;
  }
  @override
  _ProductTypeWidgetScreenState createState() =>
      _ProductTypeWidgetScreenState();
}

class _ProductTypeWidgetScreenState extends State<ProductTypeWidgetScreen> {

  void invert_all_colour(int cardNumber) {
    if (cardNumber == 1 && color_1 == color_Unselected) {
      color_1 = color_Selected;
      color_2 = color_Unselected;
      color_3 = color_Unselected;
      color_4 = color_Unselected;
      color_5 = color_Unselected;
      color_6 = color_Unselected;
      color_7 = color_Unselected;
      color_8 = color_Unselected;
      color_9 = color_Unselected;
      color_10 = color_Unselected;
      color_11 = color_Unselected;
      color_12 = color_Unselected;
      Provider.of<NewDataByShipper>(context, listen: false)
          .updateProductType(newValue: 'Packaged/ Consumer boxes');
    } else if (cardNumber == 2 && color_2 == color_Unselected) {
      color_2 = color_Selected;
      color_1 = color_Unselected;
      color_3 = color_Unselected;
      color_4 = color_Unselected;
      color_5 = color_Unselected;
      color_6 = color_Unselected;
      color_7 = color_Unselected;
      color_8 = color_Unselected;
      color_9 = color_Unselected;
      color_10 = color_Unselected;
      color_11 = color_Unselected;
      color_12 = color_Unselected;
      Provider.of<NewDataByShipper>(context, listen: false)
          .updateProductType(newValue: 'Food and agriculture');
    } else if (cardNumber == 3 && color_3 == color_Unselected) {
      color_3 = color_Selected;
      color_2 = color_Unselected;
      color_1 = color_Unselected;
      color_4 = color_Unselected;
      color_5 = color_Unselected;
      color_6 = color_Unselected;
      color_7 = color_Unselected;
      color_8 = color_Unselected;
      color_9 = color_Unselected;
      color_10 = color_Unselected;
      color_11 = color_Unselected;
      color_12 = color_Unselected;
      Provider.of<NewDataByShipper>(context, listen: false)
          .updateProductType(newValue: 'Machine/Auto Parts');
    } else if (cardNumber == 4 && color_4 == color_Unselected) {
      color_4 = color_Selected;
      color_2 = color_Unselected;
      color_3 = color_Unselected;
      color_1 = color_Unselected;
      color_5 = color_Unselected;
      color_6 = color_Unselected;
      color_7 = color_Unselected;
      color_8 = color_Unselected;
      color_9 = color_Unselected;
      color_10 = color_Unselected;
      color_11 = color_Unselected;
      color_12 = color_Unselected;
      Provider.of<NewDataByShipper>(context, listen: false)
          .updateProductType(newValue: 'Electronic goods');
    } else if (cardNumber == 5 && color_5 == color_Unselected) {
      color_5 = color_Selected;
      color_2 = color_Unselected;
      color_3 = color_Unselected;
      color_4 = color_Unselected;
      color_1 = color_Unselected;
      color_6 = color_Unselected;
      color_7 = color_Unselected;
      color_8 = color_Unselected;
      color_9 = color_Unselected;
      color_10 = color_Unselected;
      color_11 = color_Unselected;
      color_12 = color_Unselected;
      Provider.of<NewDataByShipper>(context, listen: false)
          .updateProductType(newValue: 'Chemical / Powder');
    } else if (cardNumber == 6 && color_6 == color_Unselected) {
      color_6 = color_Selected;
      color_2 = color_Unselected;
      color_3 = color_Unselected;
      color_4 = color_Unselected;
      color_5 = color_Unselected;
      color_1 = color_Unselected;
      color_7 = color_Unselected;
      color_8 = color_Unselected;
      color_9 = color_Unselected;
      color_10 = color_Unselected;
      color_11 = color_Unselected;
      color_12 = color_Unselected;
      Provider.of<NewDataByShipper>(context, listen: false)
          .updateProductType(newValue: 'Scrap');
    } else if (cardNumber == 7 && color_7 == color_Unselected) {
      color_7 = color_Selected;
      color_2 = color_Unselected;
      color_3 = color_Unselected;
      color_4 = color_Unselected;
      color_5 = color_Unselected;
      color_6 = color_Unselected;
      color_1 = color_Unselected;
      color_8 = color_Unselected;
      color_9 = color_Unselected;
      color_10 = color_Unselected;
      color_11 = color_Unselected;
      color_12 = color_Unselected;
      Provider.of<NewDataByShipper>(context, listen: false)
          .updateProductType(newValue: 'Construction material');
    } else if (cardNumber == 8 && color_8 == color_Unselected) {
      color_8 = color_Selected;
      color_2 = color_Unselected;
      color_3 = color_Unselected;
      color_4 = color_Unselected;
      color_5 = color_Unselected;
      color_6 = color_Unselected;
      color_7 = color_Unselected;
      color_1 = color_Unselected;
      color_9 = color_Unselected;
      color_10 = color_Unselected;
      color_11 = color_Unselected;
      color_12 = color_Unselected;
      Provider.of<NewDataByShipper>(context, listen: false)
          .updateProductType(newValue: 'Petroleum / Paint');
    } else if (cardNumber == 9 && color_9 == color_Unselected) {
      color_9 = color_Selected;
      color_2 = color_Unselected;
      color_3 = color_Unselected;
      color_4 = color_Unselected;
      color_5 = color_Unselected;
      color_6 = color_Unselected;
      color_7 = color_Unselected;
      color_8 = color_Unselected;
      color_1 = color_Unselected;
      color_10 = color_Unselected;
      color_11 = color_Unselected;
      color_12 = color_Unselected;
      Provider.of<NewDataByShipper>(context, listen: false)
          .updateProductType(newValue: 'Tyre');
    } else if (cardNumber == 10 && color_10 == color_Unselected) {
      color_10 = color_Selected;
      color_2 = color_Unselected;
      color_3 = color_Unselected;
      color_4 = color_Unselected;
      color_5 = color_Unselected;
      color_6 = color_Unselected;
      color_7 = color_Unselected;
      color_8 = color_Unselected;
      color_9 = color_Unselected;
      color_1 = color_Unselected;
      color_11 = color_Unselected;
      color_12 = color_Unselected;
      Provider.of<NewDataByShipper>(context, listen: false)
          .updateProductType(newValue: 'Battery');
    } else if (cardNumber == 11 && color_11 == color_Unselected) {
      color_11 = color_Selected;
      color_2 = color_Unselected;
      color_3 = color_Unselected;
      color_4 = color_Unselected;
      color_5 = color_Unselected;
      color_6 = color_Unselected;
      color_7 = color_Unselected;
      color_8 = color_Unselected;
      color_9 = color_Unselected;
      color_10 = color_Unselected;
      color_1 = color_Unselected;
      color_12 = color_Unselected;
      Provider.of<NewDataByShipper>(context, listen: false)
          .updateProductType(newValue: 'Cylinders');
    } else if (cardNumber == 12 && color_12 == color_Unselected) {
      color_12 = color_Selected;
      color_2 = color_Unselected;
      color_3 = color_Unselected;
      color_4 = color_Unselected;
      color_5 = color_Unselected;
      color_6 = color_Unselected;
      color_7 = color_Unselected;
      color_8 = color_Unselected;
      color_9 = color_Unselected;
      color_10 = color_Unselected;
      color_11 = color_Unselected;
      color_1 = color_Unselected;
      Provider.of<NewDataByShipper>(context, listen: false)
          .updateProductType(newValue: 'Alcoholic Beveragers');
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.only(left: 3, right: 3, top: 3, bottom: 3),
      insetPadding: EdgeInsets.only(
        left: 0,
        right: 0,
      ),
      content: SingleChildScrollView(
        child: ListBody(
          children: [
            Container(
              height: 50,
              child: Center(
                child: Text('Select Product Type'),
              ),
              color: Color(0xFFF3F2F1),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  buildProductTypeCard(
                      context: context,
                      CardName: 'Packaged/Consumer boxes',
                      CardNumber: 1,
                      CardColor: color_1),
                  buildProductTypeCard(
                      context: context,
                      CardName: 'Food and\nagriculture',
                      CardNumber: 2,
                      CardColor: color_2),
                  buildProductTypeCard(
                      context: context,
                      CardName: 'Machine/\nAuto Parts',
                      CardNumber: 3,
                      CardColor: color_3),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  buildProductTypeCard(
                      context: context,
                      CardName: 'Electronic goods',
                      CardNumber: 4,
                      CardColor: color_4),
                  buildProductTypeCard(
                      context: context,
                      CardName: 'Chemical /\nPowder',
                      CardNumber: 5,
                      CardColor: color_5),
                  buildProductTypeCard(
                      context: context,
                      CardName: 'Scrap',
                      CardNumber: 6,
                      CardColor: color_6),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  buildProductTypeCard(
                      context: context,
                      CardName: 'Construction material',
                      CardNumber: 7,
                      CardColor: color_7),
                  buildProductTypeCard(
                      context: context,
                      CardName: 'Petroleum / Paint',
                      CardNumber: 8,
                      CardColor: color_8),
                  buildProductTypeCard(
                      context: context,
                      CardName: 'Tyre',
                      CardNumber: 9,
                      CardColor: color_9),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  buildProductTypeCard(
                      context: context,
                      CardName: 'Battery',
                      CardNumber: 10,
                      CardColor: color_10),
                  buildProductTypeCard(
                      context: context,
                      CardName: 'Cylinders',
                      CardNumber: 11,
                      CardColor: color_11),
                  buildProductTypeCard(
                      context: context,
                      CardName: 'Alcoholic\nBeverages',
                      CardNumber: 12,
                      CardColor: color_12),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  GestureDetector buildProductTypeCard(
      {BuildContext context,
      String CardName,
      int CardNumber,
      Color CardColor}) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
        setState(() {
          invert_all_colour(CardNumber);
        });
      },
      child: Container(
        color: CardColor,
        height: 100,
        width: 100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                      'assets/productTypeImages/material$CardNumber.jpeg'),
                ),
              ),
            ),
            Text(
              '$CardName',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
