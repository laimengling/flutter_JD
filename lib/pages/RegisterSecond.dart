import 'package:flutter/material.dart';
import 'package:flutter_jdshop/pages/widget/JdButton.dart';
import 'package:flutter_jdshop/pages/widget/JdText.dart';
import 'package:flutter_jdshop/services/ScreenAdapter.dart';

class RegisterSecond extends StatefulWidget {
  @override
  _RegisterSecondState createState() => _RegisterSecondState();
}

class _RegisterSecondState extends State<RegisterSecond> {
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
                '请输入18760375007收到的验证码：',
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
                    onChange: (v) {},
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: JdButton(
                    text: '重新发送(113)',
                    color: Colors.black12,
                    cb: (){},
                  ),
                )
              ],
            ),
            SizedBox(height: ScreenAdapter.height(20)),
            JdButton(
              text: '下一步',
              color: Colors.black12,
              height: 74,
              cb: () {
                Navigator.pushNamed(context, '/registerThird');
              },
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
            )

          ],
        ),
      ),
    );
  }
}
