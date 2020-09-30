import 'package:flutter/material.dart';
import 'package:flutter_jdshop/pages/widget/JdButton.dart';
import 'package:flutter_jdshop/services/ScreenAdapter.dart';

class ProductContentFirst extends StatefulWidget {
  @override
  _ProductContentFirstState createState() => _ProductContentFirstState();
}

class _ProductContentFirstState extends State<ProductContentFirst> {

  _addShopcar() {

  }
  _attrBottomSheet () {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          // 嵌套 GestureDetector 是为了点击showModalBottomSheet的时候，不会收缩起来
          return GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {

            },
            onDoubleTap: () {

            },
            child: Container(
              height: ScreenAdapter.height(500),
              child: Stack(
                children: <Widget>[
                  ListView(
                    padding: EdgeInsets.all(10),
                    children: <Widget>[
                     Column(
                       mainAxisAlignment: MainAxisAlignment.start,
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: <Widget>[
                         Wrap(
                           children: <Widget>[
                             Container(
                               padding: EdgeInsets.only(top: 5),
                               child: Text('颜色：'),
                             ),
                             Container(
                               child: Wrap(
                                 children: <Widget>[
                                   InkWell(
                                     child: Container(
                                       padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                                       margin: EdgeInsets.only(left: 10),
                                       decoration: BoxDecoration(
                                           color: Colors.red,
                                           borderRadius: BorderRadius.circular(10)
                                       ),
                                       child: Text('红色', style: TextStyle(color: Colors.white),),
                                     ),
                                   ),
                                   InkWell(
                                     child: Container(
                                       padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                                       margin: EdgeInsets.only(left: 10),
                                       decoration: BoxDecoration(
                                           color: Colors.black12,
                                           borderRadius: BorderRadius.circular(10)
                                       ),
                                       child: Text('黄色', style: TextStyle(color: Colors.black54),),
                                     ),
                                   ),
                                 ],
                               ),
                             )
                           ],
                         ),
                         SizedBox(height: ScreenAdapter.height(10),),
                         Wrap(
                           children: <Widget>[
                             Container(
                               padding: EdgeInsets.only(top: 5),
                               child: Text('颜色：'),
                             ),
                             Container(
                               child: Wrap(
                                 children: <Widget>[
                                   InkWell(
                                     child: Container(
                                       padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                                       margin: EdgeInsets.only(left: 10),
                                       decoration: BoxDecoration(
                                           color: Colors.red,
                                           borderRadius: BorderRadius.circular(10)
                                       ),
                                       child: Text('红色', style: TextStyle(color: Colors.white),),
                                     ),
                                   ),
                                   InkWell(
                                     child: Container(
                                       padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                                       margin: EdgeInsets.only(left: 10),
                                       decoration: BoxDecoration(
                                           color: Colors.black12,
                                           borderRadius: BorderRadius.circular(10)
                                       ),
                                       child: Text('黄色', style: TextStyle(color: Colors.black54),),
                                     ),
                                   ),
                                 ],
                               ),
                             )
                           ],
                         ),
                         SizedBox(height: ScreenAdapter.height(10),),
                       ],
                     )

                    ],
                  ),
                  Positioned(
                    bottom: 0,
                    width: ScreenAdapter.width(750),
                    height: ScreenAdapter.height(100),
                    child: Row(
                      children: <Widget>[
                        Container(
                          width: ScreenAdapter.width(750),
                          height: ScreenAdapter.height(100),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                flex: 1,
                                child: Container(
                                  child: JdButton(color: Colors.red,text:'加入购物车',cb: _addShopcar),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Container(
                                  child: JdButton(color: Colors.yellow,text:'立即购买',cb: _addShopcar),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              )
            ),
          );
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    ScreenAdapter.init(context);
    return Container(
      padding: EdgeInsets.all(10),
      child: ListView(
        children: <Widget>[
          AspectRatio(
            aspectRatio: 16/9,
            child: Image.network('https://www.itying.com/images/flutter/p1.jpg', fit: BoxFit.cover),
          ),
          Container(
            padding: EdgeInsets.only(top: 10),
            child: Text(
              '联想ThinkPad 翼480（0VCD） 英特尔酷睿i5 14英寸轻薄窄边框笔记本电脑',
              style: TextStyle(
                color: Colors.black87,
                fontSize: ScreenAdapter.setSp(38)
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 10),
            child: Text(
              '震撼首发，15.9毫米全金属外观，4.9毫米轻薄窄边框，指纹电源按钮，杜比音效，2G独显，预装正版office软件',
              style: TextStyle(
                color: Colors.black54,
                fontSize: ScreenAdapter.setSp(26)
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 10),
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                          '特价：',
                        style: TextStyle(
                          fontSize: ScreenAdapter.setSp(26)
                        ),
                      ),
                      Text(
                          '￥26',
                        style: TextStyle(
                          fontSize: ScreenAdapter.setSp(36),
                          color: Colors.red
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text('原价：',
                        style: TextStyle(
                            fontSize: ScreenAdapter.setSp(26)
                        )
                      ),
                      Text('￥35',
                        style: TextStyle(
                            fontSize: ScreenAdapter.setSp(26),
                            decoration: TextDecoration.lineThrough
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          // 筛选
          Container(
            padding: EdgeInsets.only(top: 10),
            margin: EdgeInsets.only(bottom: 10),
            child: InkWell(
              onTap: () {
                _attrBottomSheet();
              },
              child: Row(
                children: <Widget>[
                  Text(
                    '已选：',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: ScreenAdapter.setSp(26)
                    ),
                  ),
                  Text(
                      '115黑色，XL，1件',
                      style: TextStyle(
                          fontSize: ScreenAdapter.setSp(26)
                      )
                  ),
                ],
              ),
            ),
          ),
          Divider(
            height: 1
          ),
          Container(
            padding: EdgeInsets.only(top: 10),
            child: Row(
              children: <Widget>[
                Text(
                  '运费：',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: ScreenAdapter.setSp(26)
                  ),
                ),
                Text(
                    '免费',
                    style: TextStyle(
                        fontSize: ScreenAdapter.setSp(26)
                    )
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
