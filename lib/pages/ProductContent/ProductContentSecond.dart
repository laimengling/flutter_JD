import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
//import '../../config/Config.dart';

class ProductContentSecond extends StatefulWidget {
  Map arguments;
  ProductContentSecond({Key key, this.arguments}): super(key:key);
  @override
  _ProductContentSecondState createState() => _ProductContentSecondState(this.arguments);
}

class _ProductContentSecondState extends State<ProductContentSecond> with AutomaticKeepAliveClientMixin{
  // 加载html字段
  InAppWebViewController webView;
  Map arguments;

  _ProductContentSecondState(this.arguments);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Expanded(
            child: InAppWebView(
              initialUrl: "http://jd.itying.com/pcontent?id=${arguments['sId']}",
              onProgressChanged: (InAppWebViewController controller, int progress) {

              },
            ),
          )
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
