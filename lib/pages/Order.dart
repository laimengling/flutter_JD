import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_jdshop/config/Config.dart';
import 'package:flutter_jdshop/model/OrderModel.dart';
import 'package:flutter_jdshop/services/ScreenAdapter.dart';
import 'package:flutter_jdshop/services/UserServices.dart';
import 'package:flutter_jdshop/services/SignServices.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Order extends StatefulWidget {
  @override
  _OrderState createState() => _OrderState();
}

class _OrderState extends State<Order> {

  List orderList = []; // 订单列表

  @override
  void initState() {
    super.initState();
    this.getOrderList(); // 获取订单数据
  }

  void getOrderList() async{
    List userInfo = await UserServices.getUserInfo();
    var tempJson = {
      'uid': userInfo[0]['_id'],
      'salt': userInfo[0]['salt'],
    };
    var sign = SignServices.getSign(tempJson);
    var api = "${Config.domain}api/orderList?uid=${userInfo[0]['_id']}&sign=${sign}";
    print(api);
    var response = await Dio().get(api);
    if(response.data['success']) {
      var orderModel = new OrderModel.fromJson(response.data);
     setState(() {
       this.orderList = orderModel.result;
     });
     print(this.orderList.length);
    } else {
      Fluttertoast.showToast(
        msg: '获取订单列表数据失败',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    }
  }

  _getOrderItem (index) {
    return this.orderList[index].orderItem.map<Widget>((item){
      return Container(
        margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Row(
          children: <Widget>[
            Container(
              width:ScreenAdapter.width(150),
              child: Image.network('${item.productImg}'),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Text('${item.productTitle}'),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Text('x${item.productCount}'),
            )
          ],
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    ScreenAdapter.init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('我的订单'),
      ),
      body: Stack(
        children: <Widget>[
          // Card 卡片组件可以使用
          Container(
            padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
            margin: EdgeInsets.only(top: 20),
            child: ListView.builder(
                itemBuilder: (context, index){
                  return Container(
                    padding: EdgeInsets.fromLTRB(0 , 0, 0, 10),
                    margin: EdgeInsets.only(top: 10),
                    color: Colors.white,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        InkWell(
                          child: Container(
                            child: Text('订单编号：${this.orderList[index].uid}', textAlign: TextAlign.left),
                            padding: EdgeInsets.fromLTRB(10, 10, 0, 10),
                          ),
                          onTap: () {
                            Navigator.pushNamed(context, '/orderInfo',arguments: {
                              'orderItem': this.orderList[index]
                            });
                          },
                        ),
                        Divider(),
                        Column(
                          children: _getOrderItem(index),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                child: Text('合计：￥${this.orderList[index].allPrice}元'),
                              ),
                              InkWell(
                                child: Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black12, width: 1.0)
                                  ),
                                  padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                                  child: Text('申请售后'),
                                ),
                                onTap: () {

                                },
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                },
              itemCount: this.orderList.length,
                ),
          ),
          Positioned(
            child: Container(
              color: Colors.white,
              padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Text('全部', textAlign: TextAlign.center),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text('待付款', textAlign: TextAlign.center),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text('待收货', textAlign: TextAlign.center),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text('已完成', textAlign: TextAlign.center),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text('已取消', textAlign: TextAlign.center),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
