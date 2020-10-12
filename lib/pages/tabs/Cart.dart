import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../pages/Cart/CartItem.dart';
import 'package:flutter_jdshop/services/ScreenAdapter.dart';
import '../../provider/Cart.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage>{

  var cartProvider;
  bool isEdit = false;

  @override
  Widget build(BuildContext context) {
    ScreenAdapter.init(context);
    this.cartProvider = Provider.of<Cart>(context);
    this.cartProvider.isCheckAll();
    return Scaffold(
      appBar: AppBar(
        title: Text('购物车',textAlign: TextAlign.center,),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.launch,color: Colors.black,),
            onPressed: (){
              setState(() {
                this.isEdit = !this.isEdit;
              });
            },
          )
        ],
      ),
      body: cartProvider.cartList.length> 0?Stack(
        children: <Widget>[
          ListView(
            children: <Widget>[
              Column(
                children: cartProvider.cartList.map<Widget>((e){
                      return CartItem(e);
                }).toList(),
              ),
              SizedBox(height: ScreenAdapter.height(100),)
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
                color: Colors.white,
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
                          value: cartProvider.isCheckedAll,
                          onChanged: (v) {
                            // 全选
                            this.cartProvider.checkAll(v);
                          },
                          activeColor: Colors.pink,
                        ),
                        Text("全选")
                      ],
                    ),
                  ),
                  !this.isEdit?Align(
                    alignment: Alignment.center,
                    child: Text(
                        "￥${this.cartProvider.allPrice}",
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ): Align(
                    alignment: Alignment.center,
                  ),
                 this.isEdit == true? Align(
                   alignment: Alignment.centerRight,
                   child: RaisedButton(
                     child: Text("删除",style: TextStyle(
                         color: Colors.white
                     )),
                     color:Colors.red,
                     onPressed: (){
                       this.cartProvider.removeSelectedItem();
                     },
                   ),
                 ): Align(
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
      ): Center(child: Text('购物车空空……'),),
    );
  }
//
//  @override
//  bool get wantKeepAlive => true;
}
