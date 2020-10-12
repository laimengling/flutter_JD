import 'package:flutter/material.dart';
import 'package:flutter_jdshop/services/ScreenAdapter.dart';

class JdText extends StatelessWidget {
  String text;
  bool password;
  bool focus;
  Object onChange;
  JdText({Key key, this.text = '输入内容', this.password = false, this.focus = false, this.onChange = null}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextField(
        obscureText: this.password,
        autofocus: true,
        decoration: InputDecoration(
          hintText: '${this.text}',
          hintStyle: TextStyle(
              color: Colors.black45,
              fontSize: 14
          ),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide.none
          ),
        ),
        onChanged: this.onChange,
      ),
      height: ScreenAdapter.height(68),
      decoration: BoxDecoration(
//          color: Color.fromRGBO(233, 233, 233, 0.8),
//          borderRadius: BorderRadius.circular(30)
      border: Border(
          bottom: BorderSide(
              width: 1,
              color: Colors.black12
          )
      )
      ),
    );
  }
}

