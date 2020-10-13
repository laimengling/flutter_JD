import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../config/Config.dart';
import 'package:dio/dio.dart';
import '../pages/widget/JdButton.dart';
import '../pages/widget/JdText.dart';
import 'package:flutter_jdshop/services/ScreenAdapter.dart';
import '../services/Storage.dart';
import '../services/EventBus.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  // 监听登录页面销毁事件
  dispose(){
    super.dispose();
    eventBus.fire(new UserEvent('登录成功……'));
  }
  String username =  '';
  String password = '';

  doLogin() async{
    RegExp reg = new RegExp(r"^1\d{10}$");
    if(!reg.hasMatch(this.username)){
      Fluttertoast.showToast(
        msg: '手机号格式不对',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    } else if(this.password.length< 6){
      Fluttertoast.showToast(
        msg: '密码长度不足6位',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    } else {
      var api = '${Config.domain}api/doLogin';
      var response = await Dio().post(api, data:{
        'username': this.username,
        'password': this.password
      });
      print(response.data);
      if(response.data['success']){
        print(response.data);
        // 保存用户信息
        Storage.setString('userInfo', json.encode(response.data['userinfo']));
        Navigator.pop(context);
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
        leading: IconButton(
          icon: Icon(Icons.clear),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        actions: <Widget>[
          FlatButton(
            child: Text('客服', style: TextStyle(fontSize: 16)),
            onPressed: () {

            },
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            Center(
              child: Container(
                margin: EdgeInsets.fromLTRB(0, 30, 0, 10),
                height: ScreenAdapter.height(200),
                width: ScreenAdapter.width(200),
                child: Image.asset('images/login.png',fit: BoxFit.cover),
              ),
            ),
            JdText(
              text: '用户名/手机号',
              onChange: (v) {
                this.username = v;
              },
            ),
            SizedBox(height: ScreenAdapter.height(40)),
            JdText(
              text: '请输入密码',
              password: true,
              onChange: (v) {
                this.password = v;
              },
            ),
            Container(
              padding: EdgeInsets.fromLTRB(0, 15, 0, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  InkWell(
                    child: Text('忘记密码'),
                    onTap: (){

                    },
                  ),
                  InkWell(
                    child: Text('新用户注册'),
                    onTap: (){
                      Navigator.pushNamed(context, '/registerFirst');
                    },
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
              child: JdButton(
                  color: Colors.red,
                  height: 72,
                  text: '登录',
                  cb: this.doLogin
              ),
            )

          ],
        ),
      ),
    );
  }
}
