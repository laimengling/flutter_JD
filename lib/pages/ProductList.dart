import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

import '../services/ScreenAdaper.dart';
import '../config/Config.dart';
class ProductList extends StatefulWidget {

  Map arguments;
  ProductList({Key key, this.arguments}) :super(key: key);

  @override
  _ProductListState createState() => _ProductListState(arguments: this.arguments);
}

class _ProductListState extends State<ProductList> {

  Map arguments;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  _ProductListState({this.arguments});

  // 商品列表
  Widget _productListWidget() {
    return Container(
      padding: EdgeInsets.all(10),
      margin:EdgeInsets.only(top: 30),
      child: ListView.builder(
          itemCount: 10,
          itemBuilder: (context, index) {
            return Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      width: ScreenAdaper.width(180),
                      height: ScreenAdaper.height(180),
                      child: Image.network('http://jd.itying.com/public/upload/ITLwdMsoj8RDHKbxISrSagUe.jpg', fit: BoxFit.cover),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        height:ScreenAdaper.width(180),
                        margin: EdgeInsets.only(left: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Text(
                              "华硕（ASUS）飞行堡垒华硕（ASUS）飞行堡垒华硕（ASUS）",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(

                              ),
                            ),
                            Row(
                              children: <Widget>[
                                Container(
                                  height: ScreenAdaper.height(36),
                                  margin: EdgeInsets.only(right: 10),
                                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Color.fromRGBO(230, 230, 230, 0.9)
                                  ),
                                  child: Text('4g'),
                                ),
                                Container(
                                  height: ScreenAdaper.height(36),
                                  margin: EdgeInsets.only(right: 10),
                                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Color.fromRGBO(230, 230, 230, 0.9)
                                  ),
                                  child: Text('126'),
                                ),
                              ],
                            ),
                            Text(
                              "￥5699",
                              style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 16.0
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                Divider(height: 20,)
              ],
            );
          }
      ),
    );
  }

  // 筛选导航
  Widget _subHeaderWidget() {
    return Positioned(
      top: 0,
      width: ScreenAdaper.width(747),
      height: ScreenAdaper.height(80),
      child: Container(
        width: ScreenAdaper.width(800),
        height: ScreenAdaper.height(80),
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(
                    width: 1,
                    color: Color.fromRGBO(233, 233, 233, 0.9)
                )
            )
        ),
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: InkWell(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(0, ScreenAdaper.width(16), 0, ScreenAdaper.width(16)),
                  child: Text(
                    "综合",
                    textAlign: TextAlign.center,
                  ),
                ),
                onTap: (){},
              ),
            ),
            Expanded(
              flex: 1,
              child: InkWell(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(0, ScreenAdaper.width(16), 0, ScreenAdaper.width(16)),
                  child: Text(
                    "销量",
                    textAlign: TextAlign.center,
                  ),
                ),
                onTap: (){},
              ),
            ),
            Expanded(
              flex: 1,
              child: InkWell(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(0, ScreenAdaper.width(16), 0, ScreenAdaper.width(16)),
                  child: Text(
                    "价格",
                    textAlign: TextAlign.center,
                  ),
                ),
                onTap: (){},
              ),
            ),
            Expanded(
              flex: 1,
              child: InkWell(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(0, ScreenAdaper.width(16), 0, ScreenAdaper.width(16)),
                  child: Text(
                    "筛选",
                    textAlign: TextAlign.center,
                  ),
                ),
                onTap: (){
                  _scaffoldKey.currentState.openEndDrawer();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    ScreenAdaper.init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('商品列表'),
//        leading: Text(""),
      actions: <Widget>[
        Text("")
      ],
      ),
      key: _scaffoldKey,
      endDrawer: Drawer(
        child: Text('11'),
      ),
      body: Stack(
        children: <Widget>[
          _productListWidget(),
          _subHeaderWidget(),
        ],
      ),
    );
  }
}
