import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../pages/widget/JdButton.dart';
import '../provider/CheckOut.dart';
import 'package:provider/provider.dart';
import '../services/ScreenAdapter.dart';

class CheckOutPage extends StatefulWidget {
  @override
  _CheckOutPageState createState() => _CheckOutPageState();
}

class _CheckOutPageState extends State<CheckOutPage> {

  var checkOutProvider;

  Widget _checkOutItem(item) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.black12,width: 1.0)
        )
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: ScreenAdapter.width(150),
            child: Image.network('${item['pic']}', fit: BoxFit.cover,),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.fromLTRB(10, 10, 5, 5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    '${item['title']}',
                    maxLines: 2,
                    textAlign: TextAlign.left,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: ScreenAdapter.height(5)),
                  Text(
                    '${item['selectedAttr']}',
                    maxLines: 2,
                    textAlign: TextAlign.left,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: ScreenAdapter.height(10),),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('￥${item['price']}',textAlign: TextAlign.left, style: TextStyle(color: Colors.red)),
                        Text('x${item['count']}')
                      ],
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
  Widget build(BuildContext context) {
    ScreenAdapter.init(context);
    this.checkOutProvider = Provider.of<CheckOut>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('订单页面'),
      ),
      body: Stack(
        children: <Widget>[
          ListView(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  color: Colors.white
                ),
                child: Column(
                  children: <Widget>[
                    ListTile(
                      leading: Icon(Icons.add_location),
                      title: Center(
                        child: Text('请添加收获地址'),
                      ),
                      trailing: Icon(Icons.navigate_next),
                      onTap: (){
                        Navigator.pushNamed(context, '/addressAdd');
                      },
                    ),
                    ListTile(
                      title: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(height: ScreenAdapter.height(10)),
                          Text('张三 15201681234'),
                          SizedBox(height: ScreenAdapter.height(10)),
                          Text('北京市海定区西二旗'),
                          SizedBox(height: ScreenAdapter.height(10)),
                        ],
                      ),
                      trailing: Icon(Icons.navigate_next),
                      onTap: (){
                        Navigator.pushNamed(context, '/addressList');
                      },
                    ),
                  ],
                ),
              ),
              Container(
                height: ScreenAdapter.height(20),
                decoration: BoxDecoration(
                  color: Color.fromRGBO(233, 233, 233, 0.4)
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white
                ),
                padding: EdgeInsets.all(ScreenAdapter.width(20)),
                child: Column(
                  children: this.checkOutProvider.checkOutList.map<Widget>((item){
                    return _checkOutItem(item);
                  }).toList(),
                ),
              ),
              Container(
                height: ScreenAdapter.height(30),
                decoration: BoxDecoration(
                    color: Color.fromRGBO(233, 233, 233, 0.4)
                ),
              ),
              SizedBox(height: ScreenAdapter.height(20)),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white
                ),
                padding: EdgeInsets.all(ScreenAdapter.width(20)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('商品总金额：￥100'),
                    Divider(),
                    Text('立减：￥5'),
                    Divider(),
                    Text('运费：￥5'),
                  ],
                ),
              )
            ],
          ),
          Positioned(
            bottom: 0,
            child: Container(
              width: ScreenAdapter.width(750),
              height: ScreenAdapter.height(100),
              padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                  top: BorderSide(color: Colors.black12, width: 1.0)
                )
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: ScreenAdapter.width(450),
                    height: ScreenAdapter.height(100),
                    child: Row(

                      children: <Widget>[
                        Text('实付款：'),
                        Text('￥128元', style: TextStyle(color: Colors.red),)
                      ],
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                    ),
                  ),
                  Container(
                    width: ScreenAdapter.width(200),
                    child: JdButton(color: Colors.red,text: '立即下单',cb: (){

                    }),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
