import 'package:flutter/material.dart';
import '../../model/ProductContentModel.dart';
import '../../services/ScreenAdapter.dart';

class CartNum extends StatefulWidget {
  ProductContentitem _productContent;
  CartNum(this._productContent,{Key key}):super(key: key);
  @override
  _CartNumState createState() => _CartNumState();
}

class _CartNumState extends State<CartNum> {
  var _productContent;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScreenAdapter.init(context);
    // 注意：给属性赋值
    this._productContent = widget._productContent;
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
            onTap: (){
              if(this._productContent.count>1){
                setState(() {
                  this._productContent.count--;
                });
              }
            },
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
            child: Text('${this._productContent.count}'),
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
            onTap: (){
              setState(() {
                this._productContent.count++;
              });
            },
          ),
        ],
      ),
    );
  }
}
