import 'dart:async'; // Timer 定时器需要

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_jdshop/config/Config.dart';
import 'package:flutter_jdshop/pages/widget/JdButton.dart';
import 'package:flutter_jdshop/pages/widget/JdText.dart';
import 'package:flutter_jdshop/services/ScreenAdapter.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RegisterSecond extends StatefulWidget {
  Map arguments;
  RegisterSecond({Key key, this.arguments}):super(key:key);
  @override
  _RegisterSecondState createState() => _RegisterSecondState();
}

class _RegisterSecondState extends State<RegisterSecond> {
  String tel;
  bool sendCodeBtn = false;
  int seconds = 10;
  String code;
  @override
  void initState() {
    super.initState();
    this.tel = widget.arguments['tel'];
    this.showTimer();
  }

  showTimer() {
    Timer t;
      t = Timer.periodic(Duration(milliseconds: 1000), (timer) {
      setState(() {
        this.seconds --;
      });
      if (this.seconds == 0) {
        t.cancel();
        setState(() {
          this.sendCodeBtn = true;
        });
      }
    });
  }

  // 重新发送验证码
  sendCode() async{
    var api = '${Config.domain}api/sendCode';
    var response = await Dio().post(api, data: {"tel": this.tel});
    if (response.data["success"]) {

      print(response);  //演示期间服务器直接返回  给手机发送的验证码
      setState(() {
        this.sendCodeBtn = false;
        this.seconds = 10;
        this.showTimer();
      });


    } else {
      Fluttertoast.showToast(
        msg: '${response.data["message"]}',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    }
  }

  // 验证
  validateCode() async{
    var api = '${Config.domain}api/validateCode';
    var response = await Dio().post(api, data: {"tel": this.tel,"code": this.code});
    if (response.data["success"]) {
      Navigator.pushNamed(context, '/registerThird', arguments: {
        'tel': this.tel,
        'code': this.code
      });
    }else{
      Fluttertoast.showToast(
        msg: '${response.data["message"]}',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('手机快速注册'),
      ),
      body: Container(
        padding: EdgeInsets.all(15),
        child: ListView(
          children: <Widget>[
            Text(
                '请输入${this.tel}收到的验证码：',
              style: TextStyle(
                fontWeight: FontWeight.bold
              ),
            ),
            SizedBox(height: ScreenAdapter.height(20)),
            Row(
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: JdText(
                    text: '请输入验证码',
                    onChange: (v) {
                      this.code = v;
                    },
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: this.sendCodeBtn?JdButton(
                    text: '重新发送',
                    color: Colors.black12,
                    cb: this.sendCode,
                  ): JdButton(
                    text: '重新发送(${this.seconds})',
                    color: Colors.black12,
                    cb: (){},
                  ),
                )
              ],
            ),
            SizedBox(height: ScreenAdapter.height(20)),
            JdButton(
              text: '下一步',
              color: Colors.red,
              height: 74,
              cb: this.validateCode,
            ),
            SizedBox(height: ScreenAdapter.height(20)),
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
            ),
          ],
        ),
      ),
    );
  }
}
