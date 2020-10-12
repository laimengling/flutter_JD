import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_jdshop/provider/Cart.dart';
import 'package:provider/provider.dart';
import '../../pages/Cart/CartNum.dart';
import '../../services/ScreenAdapter.dart';

class CartItem extends StatefulWidget  {
  Map itemData;
  CartItem(this.itemData, {Key key}): super(key: key);
  @override
  _CartItemState createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  Map _itemData;
  var cartProvider;

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    ScreenAdapter.init(context);
    this.cartProvider = Provider.of<Cart>(context);
    // 注意：给属性的赋值，不置于initState的原因：组件构建一次，数据置于initState，组件构建多次，数据发生变化，数据赋值置于build
    this._itemData = widget.itemData;
    return Container(
      height: ScreenAdapter.height(240),
      margin: EdgeInsets.fromLTRB(5, 5, 5, 0),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.black12,width: 1.0)
      ),
      child: Row(
        children: <Widget>[
         Container(
           width: ScreenAdapter.width(60),
           child:  Checkbox(
             value: _itemData['checked'],
             onChanged: (v){
               setState(() {
                 _itemData['checked'] = v;
               });
               this.cartProvider.itemChange();
             },
             activeColor: Colors.pink,
           ),
         ),
          Container(
            width: ScreenAdapter.width(150),
            child: Image.network('${_itemData['pic']}', fit: BoxFit.cover,),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.fromLTRB(10, 10, 5, 5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    '${_itemData['title']}',
                    maxLines: 2,
                    textAlign: TextAlign.left,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: ScreenAdapter.height(5)),
                  Text(
                    '${_itemData['selectedAttr']}',
                    maxLines: 2,
                    textAlign: TextAlign.left,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: ScreenAdapter.height(10),),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('￥${_itemData['price']}',textAlign: TextAlign.left, style: TextStyle(color: Colors.red)),
                       CartNum(_itemData)
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
