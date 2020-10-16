import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_jdshop/services/ScreenAdapter.dart';
import '../model/OrderModel.dart';

class OrderInfo extends StatefulWidget {
  Map arguments;
  OrderInfo({Key key, this.arguments}):super(key:key);
  @override
  _OrderInfoState createState() => _OrderInfoState();
}

class _OrderInfoState extends State<OrderInfo> {

  Result rs;

  @override
  void initState() {
    super.initState();
    rs =  widget.arguments['orderItem'];
  }
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
                    Text('${rs.name} ${rs.phone}'),
                    SizedBox(height: ScreenAdapter.height(10)),
                    Text('${rs.address}', maxLines: 1, overflow: TextOverflow.ellipsis),
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
                      children: rs.orderItem.map<Widget>((item){
                        return Row(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                              width: ScreenAdapter.width(150),
                              child: Image.network(
                                  "${item.productImg}",
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
                                      Text("${item.productTitle}",
                                          maxLines: 2,
                                          style: TextStyle(color: Colors.black54)),
                                      Text("${item.selectedAttr}",
                                          maxLines: 2,
                                          style: TextStyle(color: Colors.black54)),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text("￥${item.productPrice}",
                                              style: TextStyle(color: Colors.red)),
                                          Text("x${item.productCount}"),
                                        ],
                                      ),
                                    ],
                                  ),
                                ))
                          ],
                        );
                      }).toList(),
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
                        Text('${rs.sId}')
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
                        Text('${rs.payStatus}')
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
                  Text('￥${rs.allPrice}元', style: TextStyle(color: Colors.red))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
