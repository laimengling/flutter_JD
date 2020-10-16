import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_jdshop/services/ScreenAdapter.dart';

class Order extends StatefulWidget {
  @override
  _OrderState createState() => _OrderState();
}

class _OrderState extends State<Order> {
  @override
  Widget build(BuildContext context) {
    ScreenAdapter.init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('我的订单'),
      ),
      body: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
            margin: EdgeInsets.only(top: 20),
            child: ListView(
              children: <Widget>[
                // Card 卡片组件
                Container(
                  padding: EdgeInsets.fromLTRB(0 , 0, 0, 10),
                  margin: EdgeInsets.only(top: 10),
                  color: Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      InkWell(
                        child: Container(
                          child: Text('订单编号：57878900---8425677888545', textAlign: TextAlign.left),
                          padding: EdgeInsets.fromLTRB(10, 10, 0, 10),
                        ),
                        onTap: () {
                          Navigator.pushNamed(context, '/orderInfo');
                        },
                      ),
                      Divider(),
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                        child: Row(
                          children: <Widget>[
                            Container(
                              width:ScreenAdapter.width(150),
                              child: Image.network('https://www.itying.com/images/flutter/list2.jpg'),
                            ),
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                child: Text('磨砂牛皮男休闲鞋-有属性'),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                              child: Text('x1'),
                            )
                          ],
                        ),
                      ),

                      Container(
                        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              child: Text('合计：￥688.0元'),
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
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(0 , 0, 0, 10),
                  margin: EdgeInsets.only(top: 10),
                  color: Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        child: Text('订单编号：57878900---8425677888545', textAlign: TextAlign.left),
                        padding: EdgeInsets.fromLTRB(10, 10, 0, 10),
                      ),
                      Divider(),
                      Container(
                        child: Row(
                          children: <Widget>[
                            Container(
                              width:ScreenAdapter.width(200),
                              child: Image.network('https://www.itying.com/images/flutter/list2.jpg'),
                            ),
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                child: Text('磨砂牛皮男休闲鞋-有属性'),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                              child: Text('x1'),
                            )
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              child: Text('合计：￥688.0元'),
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
                ),
              ],
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
