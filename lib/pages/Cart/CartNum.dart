import 'package:flutter/material.dart';
import '../../services/ScreenAdapter.dart';
import '../../provider/Cart.dart';
import 'package:provider/provider.dart';
class CartNum extends StatefulWidget {
  Map itemData;
  CartNum(this.itemData, {Key key}): super(key: key);

  @override
  _CartNumState createState() => _CartNumState();
}

class _CartNumState extends State<CartNum> {

  Map _itemData;
  var cartProvider;
  @override
  void initState() {
    super.initState();
    this._itemData = widget.itemData;
  }

  @override
  Widget build(BuildContext context) {
    ScreenAdapter.init(context);
    this.cartProvider = Provider.of<Cart>(context);
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
              if(this._itemData['count'] > 1){
                setState(() {
                  this._itemData['count']--;
                });
              }
              this.cartProvider.changeItemCount();
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
            child: Text('${_itemData['count']}'),
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
                this._itemData['count'] ++;
              });
              this.cartProvider.changeItemCount();
            },
          ),
        ],
      ),
    );
  }
}
