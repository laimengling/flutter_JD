import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_jdshop/services/EventBus.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../services/UserServices.dart';
import '../../services/SignServices.dart';
import '../../config/Config.dart';
import '../../services/ScreenAdapter.dart';

class AddressList extends StatefulWidget {
  @override
  _AddressListState createState() => _AddressListState();
}

class _AddressListState extends State<AddressList> {

  List addressList = [];

  @override
  void initState() {
    super.initState();
    this._getAddressList();

    eventBus.on<AddressListEvent>().listen((event) {
      this._getAddressList();
    });
  }

  dispose() {
    super.dispose();
    eventBus.fire(new CheckOutEvent('登录成功……'));
  }
  // 获取收获地址列表
  _getAddressList() async{
    // 请求接口
    List userInfo = await UserServices.getUserInfo();
    var tempJson = {
      'uid': userInfo[0]['_id'],
      'salt': userInfo[0]['salt'],
    };
    var sign = SignServices.getSign(tempJson);
    var api = "${Config.domain}api/addressList?uid=${userInfo[0]['_id']}&sign=${sign}";

    var response = await Dio().get(api);
    setState(() {
      this.addressList = List.from(response.data['result']);
    });
  }

  // 修改默认地址
  _changeDefaultAddress(addressId) async{
    List userInfo = await UserServices.getUserInfo();
    var tempJson = {
      'uid': userInfo[0]['_id'],
      'salt': userInfo[0]['salt'],
      'id': addressId
    };
    var sign = SignServices.getSign(tempJson);
    var api = "${Config.domain}api/changeDefaultAddress";

    var response = await Dio().post(api, data: {
      'uid': userInfo[0]['_id'],
      'sign': sign,
      'id': addressId
    });
    if(response.data['success']){
      this._getAddressList();
      Navigator.pop(context);
    } else {
      Fluttertoast.showToast(
        msg: '${response.data["message"]}',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    }
  }

  //删除收货地址

  _delAddress(id) async{

    List userinfo=await UserServices.getUserInfo();
    var tempJson={
      "uid":userinfo[0]["_id"],
      "id":id,
      "salt":userinfo[0]["salt"]
    };

    var sign=SignServices.getSign(tempJson);

    var api = '${Config.domain}api/deleteAddress';
    await Dio().post(api,data:{
      "uid":userinfo[0]["_id"],
      "id":id,
      "sign":sign
    });
    this._getAddressList();   //删除收货地址完成后重新获取列表

  }

  //展示Dialog
  _alertDelDialog (id) async{
    await showDialog(
        barrierDismissible:false,   //表示点击灰色背景的时候是否消失弹出框
        context: context,
        builder: (context){
          return AlertDialog(
            title: Text('提示信息'),
            content: Text('确定删除？'),
            actions: <Widget>[
              FlatButton(
                child: Text('确定'),
                onPressed: () async{
                  //执行删除操作
                  this._delAddress(id);
                  Navigator.pop(context);
                },
              ),
              SizedBox(width: 10,),
              FlatButton(
                child: Text('取消'),
                onPressed: (){
                  Navigator.pop(context,'no');
                },
              ),
            ],
          );
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    ScreenAdapter.init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('收获地址列表'),
      ),
      body: Stack(
        children: <Widget>[
          ListView.builder(
            itemCount: this.addressList.length,
            itemBuilder: (context, index){
              return Column(
                children: <Widget>[
                  SizedBox(height: ScreenAdapter.height(20)),
                  this.addressList[index]['default_address'] == 1?
                  ListTile(
                    leading: Icon(Icons.done, color: Colors.red),
                    title: InkWell(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('${this.addressList[index]['name']} ${this.addressList[index]['phone']}'),
                          SizedBox(height: ScreenAdapter.height(10)),
                          Text('${this.addressList[index]['address']}', style: TextStyle( color: Colors.black45)),
                        ],
                      ),
                      onTap: () {
                        this._changeDefaultAddress(this.addressList[index]['_id']);
                      }
                    ),
                    trailing: IconButton(
                      icon:Icon(Icons.brush, color: Colors.lightBlue),
                      onPressed: (){
                        Navigator.pushNamed(context, '/addressEdit', arguments: {
                          'id': this.addressList[index]['_id'],
                          'name': this.addressList[index]['name'],
                          'phone': this.addressList[index]['phone'],
                          'address': this.addressList[index]['address'],
                        });
                      },
                    ),
                  ):ListTile(
                    title: InkWell(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('${this.addressList[index]['name']} ${this.addressList[index]['phone']}'),
                          SizedBox(height: ScreenAdapter.height(10)),
                          Text('${this.addressList[index]['address']}', style: TextStyle( color: Colors.black45)),
                        ],
                      ),
                      onTap: () {
                        this._changeDefaultAddress(this.addressList[index]['_id']);
                      },
                      onLongPress: (){
                        this._alertDelDialog(this.addressList[index]['_id']);
                      },
                    ),
                    trailing: IconButton(
                      icon:Icon(Icons.brush, color: Colors.lightBlue),
                      onPressed: (){
                        Navigator.pushNamed(context, '/addressEdit', arguments: {
                          'id': this.addressList[index]['_id'],
                          'name': this.addressList[index]['name'],
                          'phone': this.addressList[index]['phone'],
                          'address': this.addressList[index]['address'],
                        });
                      },
                    ),
                  ),
                  Divider(),

                ],
              );
            }
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
