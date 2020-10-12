import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../config/Config.dart';
import '../services/ScreenAdapter.dart';
import '../pages/widget/JdButton.dart';
import '../pages/widget/JdText.dart';
import 'package:dio/dio.dart';
class RegisterFirst extends StatefulWidget {
  @override
  _RegisterFirstState createState() => _RegisterFirstState();
}

class _RegisterFirstState extends State<RegisterFirst> {
  String tel;
  bool next = false;
  sendCode() async{
    RegExp reg = new RegExp(r"^1\d{10}$");
    if (reg.hasMatch(this.tel)) {
      var api = '${Config.domain}api/sendCode';
      var response = await Dio().post(api, data: {"tel": this.tel});
      if (response.data["success"]) {
        next =  true;
        print(response);  //演示期间服务器直接返回  给手机发送的验证码
        Navigator.pushNamed(context, '/registerSecond',arguments: {
          "tel":this.tel
        });

      } else {
        Fluttertoast.showToast(
          msg: '${response.data["message"]}',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
        );
      }
    } else {
      Fluttertoast.showToast(
        msg: '手机号格式不对',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    ScreenAdapter.init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('手机快速注册'),
      ),
      body: Container(
        padding: EdgeInsets.all(15),
        child: ListView(
          children: <Widget>[
            SizedBox(height: ScreenAdapter.height(30)),
            JdText(
              text: '请输入手机号',
              onChange: (v) {
                this.tel = v;
              },
            ),
            SizedBox(height: ScreenAdapter.height(30)),
            JdButton(
              color: Colors.red,
              text: '下一步',
              height: 74,
              cb: sendCode,
            ),
            SizedBox(height: ScreenAdapter.height(10)),
            Row(
              children: <Widget>[
                Text(
                  '遇到问题？您可以',
                  style: TextStyle(
                      color: Colors.black38,
                      fontSize: 12
                  ),
                ),

              ],
            )
          ],
        ),
      ),
    );
  }
}
