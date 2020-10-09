import 'package:flutter/material.dart';
import '../../services/ScreenAdapter.dart';

class CartNum extends StatefulWidget {
  @override
  _CartNumState createState() => _CartNumState();
}

class _CartNumState extends State<CartNum> {
  @override
  Widget build(BuildContext context) {
    ScreenAdapter.init(context);
    return Container(
      width: ScreenAdapter.width(164),
      child: Row(
        children: <Widget>[
          InkWell(
            child: Container(
              width: ScreenAdapter.width(50),
              height: ScreenAdapter.height(50),
              padding: EdgeInsets.only(top: 1.0),
              child: Text('-',textAlign: TextAlign.center,),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black12)
              ),
            ),
            onTap: (){},
          ),
          Container(
            width: ScreenAdapter.width(60),
            height: ScreenAdapter.height(50),
            decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(color: Colors.black12),
                  bottom: BorderSide(color: Colors.black12),
                )
            ),
            alignment: Alignment.center,
            child: Text('1'),
          ),
          InkWell(
            child: Container(
              width: ScreenAdapter.width(50),
              height: ScreenAdapter.height(50),
              padding: EdgeInsets.only(top: 1.0),
              child: Text('+',textAlign: TextAlign.center,),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black12)
              ),
            ),
            onTap: (){},
          ),
        ],
      ),
    );
  }
}
