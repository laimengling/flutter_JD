import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
//import '../../config/Config.dart';

class ProductContentSecond extends StatefulWidget {
  List _productContentList=[];
  ProductContentSecond(this._productContentList, {Key key}): super(key:key);
  @override
  _ProductContentSecondState createState() => _ProductContentSecondState(this._productContentList);
}

class _ProductContentSecondState extends State<ProductContentSecond> with AutomaticKeepAliveClientMixin{
  // 加载html字段
  InAppWebViewController webView;
  List _productContentList=[];

  _ProductContentSecondState(this._productContentList);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Expanded(
            child: InAppWebView(
              initialUrl: "http://jd.itying.com/pcontent?id=${this._productContentList[0].sId}",
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
