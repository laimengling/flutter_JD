import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
          Column(
            children: <Widget>[
               Container(
                  child: Row(
                    children: <Widget>[
                      Checkbox(
                        value: false,
                      ),
                      Image.network('src', fit: BoxFit.cover,),
                      Container(
                        width: ScreenAdapter.width(500),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              '松紧腰迷彩束脚休闲裤男士修身小脚裤夏季运动裤子男韩款潮流薄款',
                              maxLines: 2,
                              textAlign: TextAlign.left,
                              style: TextStyle(

                              ),
                            ),
                            Text('￥20',textAlign: TextAlign.left),
                            Align(
                              child: Container(
                                width: ScreenAdapter.width(154),
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
                                      onTap: (){},
                                    ),
                                    Container(
                                      width: ScreenAdapter.width(50),
                                      height: ScreenAdapter.height(50),
                                      decoration: BoxDecoration(
                                        border: Border(
                                          top: BorderSide(color: Colors.black12),
                                          bottom: BorderSide(color: Colors.black12),
                                        )
                                      ),
                                      child: TextField(
                                        decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(30),
                                                borderSide: BorderSide.none
                                            )
                                        ),
                                      ),
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
                                      onTap: (){},
                                    ),
                                  ],
                                ),
                              ),
                              alignment: Alignment.bottomRight,
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  height: ScreenAdapter.height(240),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.black26,width: 1.0)
                  ),
                 margin: EdgeInsets.all(5),
                ),

            ],
          ),
          Positioned(
            width: ScreenAdapter.width(750),
            height: ScreenAdapter.height(100),
            bottom: 0,
            child: Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: Colors.black12
                  )
                )
              ),
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 3,
                    child: Row(
                      children: <Widget>[
                        Checkbox(
                          value: false,
                        ),
                        Text("全选")
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: JdButton(color: Colors.red,text: '结算',cb: (){},),
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
