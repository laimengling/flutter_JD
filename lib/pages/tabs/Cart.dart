import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../provider/CheckOut.dart';
import '../../services/CartServices.dart';
import '../../services/UserServices.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import '../../pages/Cart/CartItem.dart';
import '../../services/ScreenAdapter.dart';
import '../../provider/Cart.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage>{

  var cartProvider;
  var checkOutProvider;
  bool isEdit = false;

  // 结算操作
  doCheckOut() async{
    bool isLogin = await UserServices.getUserLoginState();
    var checkOutData = await CartServices.getCheckOutData();
    this.checkOutProvider.changeCheckOutListData(checkOutData);
    if(checkOutData.length > 0) {
      if(isLogin){
        Navigator.pushNamed(context, '/checkOut');
      } else {
        Fluttertoast.showToast(
          msg: '还未登录，不可结算',
          backgroundColor: Colors.black,
          textColor: Colors.white,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
        );
      }
    } else {
      Fluttertoast.showToast(
        msg: '购物车还没有选中的数据',
        backgroundColor: Colors.black,
        textColor: Colors.white,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    ScreenAdapter.init(context);
    this.cartProvider = Provider.of<Cart>(context);
    this.cartProvider.isCheckAll();
    this.checkOutProvider = Provider.of<CheckOut>(context);
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
                     onPressed: this.doCheckOut,
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
