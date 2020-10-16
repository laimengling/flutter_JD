import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_jdshop/services/ScreenAdapter.dart';

class OrderInfo extends StatefulWidget {
  @override
  _OrderInfoState createState() => _OrderInfoState();
}

class _OrderInfoState extends State<OrderInfo> {
  @override
  Widget build(BuildContext context) {
    ScreenAdapter.init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('订单详情'),
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
        child: ListView(
          children: <Widget>[
            Container(
              color: Colors.white,
              padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: ListTile(
                leading: Icon(Icons.add_location),
                title: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('张三 15759029475'),
                    SizedBox(height: ScreenAdapter.height(10)),
                    Text('北京市海定区 西二旗', maxLines: 1, overflow: TextOverflow.ellipsis),
                  ],
                ),
              ),
            ),
            Container(
              child: Column(
                children: <Widget>[
                  Container(
                    color: Colors.white,
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                              width: ScreenAdapter.width(150),
                              child: Image.network(
                                  "https://www.itying.com/images/flutter/list2.jpg",
                                  fit: BoxFit.cover),
                            ),
                            Expanded(
                                flex: 1,
                                child: Container(
                                  padding: EdgeInsets.fromLTRB(10, 10, 10, 5),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text("四季沐歌 (MICOE) 洗衣机水龙头 洗衣机水嘴 单冷快开铜材质龙头",
                                          maxLines: 2,
                                          style: TextStyle(color: Colors.black54)),
                                      Text("水龙头 洗衣机",
                                          maxLines: 2,
                                          style: TextStyle(color: Colors.black54)),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text("￥100",
                                              style: TextStyle(color: Colors.red)),
                                          Text("x2"),
                                        ],
                                      ),
                                    ],
                                  ),
                                ))
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                              width: ScreenAdapter.width(150),
                              child: Image.network(
                                  "https://www.itying.com/images/flutter/list2.jpg",
                                  fit: BoxFit.cover),
                            ),
                            Expanded(
                                flex: 1,
                                child: Container(
                                  padding: EdgeInsets.fromLTRB(10, 10, 10, 5),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text("四季沐歌 (MICOE) 洗衣机水龙头 洗衣机水嘴 单冷快开铜材质龙头",
                                          maxLines: 2,
                                          style: TextStyle(color: Colors.black54)),
                                      Text("水龙头 洗衣机",
                                          maxLines: 2,
                                          style: TextStyle(color: Colors.black54)),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text("￥100",
                                              style: TextStyle(color: Colors.red)),
                                          Text("x2"),
                                        ],
                                      ),
                                    ],
                                  ),
                                ))
                          ],
                        ),
                      ],
                    ),
                  ),

                ],
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
              padding: EdgeInsets.fromLTRB(20, 0, 0 , 0),
              color: Colors.white,
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: Row(
                      children: <Widget>[
                        Text('订单编号：', style: TextStyle(fontWeight: FontWeight.bold)),
                        Text('3683262286333655')
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: Row(
                      children: <Widget>[
                        Text('下单时间：', style: TextStyle(fontWeight: FontWeight.bold)),
                        Text('3683262286333655')
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: Row(
                      children: <Widget>[
                        Text('支付方式：', style: TextStyle(fontWeight: FontWeight.bold)),
                        Text('3683262286333655')
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: Row(
                      children: <Widget>[
                        Text('配送方式：', style: TextStyle(fontWeight: FontWeight.bold)),
                        Text('3683262286333655')
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.white,
              padding: EdgeInsets.fromLTRB(20, 10, 0 , 10),
              margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: Row(
                children: <Widget>[
                  Text('总金额：', style: TextStyle(fontWeight: FontWeight.bold)),
                  Text('￥3683262286333655元', style: TextStyle(color: Colors.red))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
