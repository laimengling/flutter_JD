import 'package:flutter/material.dart';
import 'package:flutter_jdshop/services/UserServices.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../pages/widget/JdButton.dart';
import '../../pages/widget/JdText.dart';
import '../../services/ScreenAdapter.dart';
import 'package:city_pickers/city_pickers.dart';
import '../../services/SignServices.dart';
import 'package:dio/dio.dart';
import '../../config/Config.dart';
import '../../services/EventBus.dart';

class AddressAdd extends StatefulWidget {
  @override
  _AddressAddState createState() => _AddressAddState();
}

class _AddressAddState extends State<AddressAdd> {

  String area = '省/市/区';
  String name = '';
  String phone = '';
  String address = '';

  dispose() {
    super.dispose();
    eventBus.fire(new AddressListEvent('登录成功……'));
    eventBus.fire(new CheckOutEvent('登录成功……'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('增加收货地址'),
      ),
      body: Container(
        padding: EdgeInsets.only(top: 20),
        child: ListView(
          children: <Widget>[
            JdText(text: '收件人姓名', onChange: (v) {
              setState(() {
                this.name = v;
              });
            }),
            SizedBox(height: ScreenAdapter.height(20)),
            JdText(text: '收件人电话号码', onChange: (v) {
              setState(() {
                this.phone = v;
              });
            }),
            SizedBox(height: ScreenAdapter.height(20)),
            InkWell(
              child: Container(
                height: ScreenAdapter.height(78),
                padding: EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      width: 1,
                      color: Colors.black12
                    )
                  )
                ),
                child: Row(
                  children: <Widget>[
                    SizedBox(width: ScreenAdapter.width(15),),
                    Icon(Icons.add_location,color: Colors.black45),
                    Text('${this.area}', style: TextStyle(color: Colors.black45))
                  ],
                ),
              ),
              onTap: () async{
                Result result = await CityPickers.showCityPicker(
                    context: context,
                    height:ScreenAdapter.height(500),
                    cancelWidget: Text('取消', style: TextStyle(color: Colors.black)),
                    confirmWidget: Text('确定', style: TextStyle(color: Colors.black))
                );
                if(result != null) {
                  setState(() {
                    this.area = "${result.provinceName}/${result.cityName}/${result.areaName}";
                  });
                }
              },
            ),
            SizedBox(height: ScreenAdapter.height(20)),
            Text('    详细地址', style: TextStyle(color: Colors.black45, )),
            JdText( text: '',onChange: (v) {
              setState(() {
                this.address = '${this.area} ${v}';
              });
            }),
            SizedBox(height: ScreenAdapter.height(150)),
            Container(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: JdButton(color: Colors.red,text: '增加', cb: () async{
                List userInfo = await UserServices.getUserInfo();
                var tempJson = {
                  'uid': userInfo[0]['_id'],
                  'salt': userInfo[0]['salt'],
                  'name': this.name,
                  'phone': this.phone,
                  'address': this.address,
                };
                var sign = SignServices.getSign(tempJson);
                var api = "${Config.domain}api/addAddress";
                var response = await Dio().post(api,data: {
                  'uid': userInfo[0]['_id'],
                  'sign': sign,
                  'name': this.name,
                  'phone': this.phone,
                  'address': this.address,
                });

                if(response.data['success']) {
                  Navigator.pop(context);
                } else {
                  Fluttertoast.showToast(
                    msg: '${response.data["message"]}',
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                  );
                }
              }),
            )
          ],
        ),
      ),
    );
  }
}
