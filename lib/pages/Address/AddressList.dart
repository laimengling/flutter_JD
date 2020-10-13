import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_jdshop/services/ScreenAdapter.dart';

class AddressList extends StatefulWidget {
  @override
  _AddressListState createState() => _AddressListState();
}

class _AddressListState extends State<AddressList> {
  @override
  Widget build(BuildContext context) {
    ScreenAdapter.init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('收获地址列表'),
      ),
      body: Stack(
        children: <Widget>[
          ListView(
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.done, color: Colors.red),
                title: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('张三 15201681234'),
                    SizedBox(height: ScreenAdapter.height(10)),
                    Text('北京市海淀区西二旗', style: TextStyle( color: Colors.black45)),
                  ],
                ),
                trailing: IconButton(
                  icon:Icon(Icons.brush, color: Colors.lightBlue),
                  onPressed: (){},
                ),
              ),
              Divider(),
              ListTile(
                title: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('张三 15201681234'),
                    SizedBox(height: ScreenAdapter.height(10)),
                    Text('北京市海淀区西二旗', style: TextStyle( color: Colors.black45)),
                  ],
                ),
                trailing: IconButton(
                  icon:Icon(Icons.brush, color: Colors.lightBlue),
                  onPressed: (){},
                ),
              )
            ],
          ),
          Positioned(
            bottom: 0,
            child: InkWell(
              child: Container(
                width: ScreenAdapter.width(750),
                height: ScreenAdapter.height(90),
                decoration: BoxDecoration(
                  color: Colors.red,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.add, color: Colors.white,),
                    SizedBox(width: ScreenAdapter.width(10)),
                    Text('新增收货地址', style: TextStyle( color: Colors.white)),
                  ],
                ),
              ),
              onTap: () {
                Navigator.pushNamed(context, '/addressAdd');
              },
            ),
          )
        ],
      ),
    );
  }
}
