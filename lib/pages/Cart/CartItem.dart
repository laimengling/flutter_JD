import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../pages/Cart/CartNum.dart';
import '../../services/ScreenAdapter.dart';

class CartItem extends StatefulWidget {
  @override
  _CartItemState createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  @override
  Widget build(BuildContext context) {
    ScreenAdapter.init(context);
    return Container(
      child: Row(
        children: <Widget>[
         Container(
           width: ScreenAdapter.width(60),
           margin: EdgeInsets.all(5),
           child:  Checkbox(
             value: false,
             onChanged: (v){

             },
             activeColor: Colors.pink,
           ),
         ),
          Container(
            width: ScreenAdapter.width(150),
            child: Image.network('https://www.itying.com/images/flutter/list2.jpg', fit: BoxFit.cover,),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.fromLTRB(10, 10, 5, 5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    '松紧腰迷彩束脚休闲裤男士修身小脚裤夏季运动裤子男韩款潮流薄款',
                    maxLines: 2,
                    textAlign: TextAlign.left,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                    ),
                  ),
                  Text('￥20',textAlign: TextAlign.left),
                  Align(
                    child: CartNum(),
                    alignment: Alignment.bottomRight,
                  )
                ],
              ),
            ),
          )
        ],
      ),
      height: ScreenAdapter.height(240),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.black12,width: 1.0)
      ),
      margin: EdgeInsets.all(5),
    );
  }
}
