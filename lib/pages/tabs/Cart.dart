import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../pages/Cart/CartItem.dart';
import 'package:flutter_jdshop/pages/widget/JdButton.dart';
import 'package:flutter_jdshop/services/ScreenAdapter.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> with AutomaticKeepAliveClientMixin{

  // 全选
  _chooseAll() {

  }

  @override
  Widget build(BuildContext context) {
    ScreenAdapter.init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('购物车页面',textAlign: TextAlign.center,),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.launch,color: Colors.black,)
          )
        ],
      ),
      body: Stack(
        children: <Widget>[
          ListView(
            children: <Widget>[
               CartItem(),
              CartItem(), CartItem(), CartItem(),

            ],
          ),
          Positioned(
            width: ScreenAdapter.width(750),
            height: ScreenAdapter.height(100),
            bottom: 0,
            child: Container(
              width: ScreenAdapter.width(750),
              height: ScreenAdapter.height(100),
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: Colors.black12
                  )
                )
              ),
              child: Stack(
                children: <Widget>[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: <Widget>[
                        Checkbox(
                          value: false,
                        ),
                        Text("全选")
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: RaisedButton(
                      child: Text("结算",style: TextStyle(
                          color: Colors.white
                      )),
                      color:Colors.red,

                      onPressed: (){

                      },
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

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
