import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../pages/widget/JdButton.dart';
import '../pages/widget/JdText.dart';
import 'package:flutter_jdshop/services/ScreenAdapter.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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

              },
            ),
            SizedBox(height: ScreenAdapter.height(40)),
            JdText(
              text: '请输入密码',
              password: true,
              onChange: (v) {

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
                  cb: (){

                  }
              ),
            )

          ],
        ),
      ),
    );
  }
}
