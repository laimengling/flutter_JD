import 'package:flutter/material.dart';

class ProductContentThird extends StatefulWidget {
  @override
  _ProductContentThirdState createState() => _ProductContentThirdState();
}

class _ProductContentThirdState extends State<ProductContentThird> with AutomaticKeepAliveClientMixin{
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Text('3'),
      );
  }

  @override
  bool get wantKeepAlive => true;
}
