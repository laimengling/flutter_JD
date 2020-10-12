import 'package:flutter/material.dart';
import '../services/ScreenAdapter.dart';
import 'package:flutter_jdshop/pages/widget/JdButton.dart';
import 'package:flutter_jdshop/pages/widget/JdText.dart';

class RegisterFirst extends StatefulWidget {
  @override
  _RegisterFirstState createState() => _RegisterFirstState();
}

class _RegisterFirstState extends State<RegisterFirst> {
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
                print(v);
              },
            ),
            SizedBox(height: ScreenAdapter.height(30)),
            JdButton(
              color: Colors.black12,
              text: '下一步',
              height: 74,
              cb: (){
                Navigator.pushNamed(context, '/registerSecond');
              },
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
