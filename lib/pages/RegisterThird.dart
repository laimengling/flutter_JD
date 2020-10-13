import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../config/Config.dart';
import '../pages/tabs/Tab.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../pages/widget/JdText.dart';
import '../pages/widget/JdButton.dart';
import '../services/ScreenAdapter.dart';
import '../services/Storage.dart';

class RegisterThird extends StatefulWidget {
  Map arguments;
  RegisterThird({Key key, this.arguments}) : super(key: key);

  _RegisterThirdState createState() => _RegisterThirdState();
}

class _RegisterThirdState extends State<RegisterThird> {
  String tel;
  String code;
  String pwd = '';
  String rPwd = '';

  @override
  void initState() {
    super.initState();
    this.tel = widget.arguments['tel'];
    this.code = widget.arguments['code'];
  }

  register() async {
    if (pwd.length < 6) {
      Fluttertoast.showToast(
        msg: '密码长度不能小于6位',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    } else if (rPwd != pwd) {
      Fluttertoast.showToast(
        msg: '密码和确认密码不一致',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    } else {
      var api = '${Config.domain}api/register';
      var response = await Dio().post(api, data: {
        "tel": this.tel,
        "code": this.code,
        "password": this.pwd
      });
      if (response.data["success"]) {
        //保存用户信息
        Storage.setString('userInfo', json.encode(response.data["userinfo"]));

        //返回到根
        Navigator.of(context).pushAndRemoveUntil(
            new MaterialPageRoute(builder: (context) => new Tabs()),
                (route) => route == null);
      } else {
        Fluttertoast.showToast(
          msg: '${response.data["message"]}',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("用户注册-第三步"),
      ),
      body: Container(
        padding: EdgeInsets.all(ScreenAdapter.width(20)),
        child: ListView(
          children: <Widget>[
            SizedBox(height: 50),
            JdText(
              text: "请输入密码",
              password: true,
              onChange: (value) {
                this.pwd = value;
              },
            ),
            SizedBox(height: 10),
            JdText(
              text: "请输入确认密码",
              password: true,
              onChange: (value) {
                this.rPwd = value;
              },
            ),
            SizedBox(height: 20),
            JdButton(
              text: "登录",
              color: Colors.red,
              height: 74,
              cb: this.register,
            )
          ],
        ),
      ),
    );
  }
}
