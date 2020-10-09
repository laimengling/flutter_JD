import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_jdshop/pages/Cart/CartNum.dart';
import '../../config/Config.dart';
import '../../pages/widget/JdButton.dart';
import '../../services/ScreenAdapter.dart';
import '../../model/ProductContentModel.dart';
//import 'package:provider/provider.dart';
import '../../services/EventBus.dart';

class ProductContentFirst extends StatefulWidget {
  Map arguments;
  ProductContentFirst({Key key, this.arguments}): super(key:key);
  @override
  _ProductContentFirstState createState() => _ProductContentFirstState(this.arguments);
}

class _ProductContentFirstState extends State<ProductContentFirst> with AutomaticKeepAliveClientMixin{

  Map _arguments;
  List<Attr> _attr = [];
  ProductContentitem _pCItem;
  String _selectedValue;
  var actionEventBus;
  @override
  void initState() {
    super.initState();
    this._getProductItem ();
    // 监听广播
    this.actionEventBus = eventBus.on<ProductContentEvent>().listen((event) {
      print(event);
      this._attrBottomSheet();
    });
  }

  // 销毁
  void dispose() {
    super.dispose();
    this.actionEventBus.cancel(); // 取消事件监听
  }

  _ProductContentFirstState(this._arguments);

  // 初始化，获取商品数据
  _getProductItem() async{
    var api = '${Config.domain}api/pcontent?id=${_arguments['sId']}';
    var result = await Dio().get(api);
    print(api);
    var productContent = new ProductContentModel.fromJson(result.data);
    setState(() {
      _pCItem = productContent.result;
      this._attr = _pCItem.attr;
    });
    this._initAttr();
    this._getSelectedAttrValue();
  }
  _addShopcar(){}

  // 初始化 Attr 格式化数据
  _initAttr() {
    var attr = this._attr;
    for(var i = 0;i<attr.length;i++) {
      for(var j=0; j< attr[i].list.length; j++) {
        if (j == 0) {
          setState(() {
            attr[i].attrList.add({
              "title": attr[i].list[j],
              "checked": true
            });
          });
        } else {
          setState(() {
            attr[i].attrList.add({
              "title": attr[i].list[j],
              "checked": false
            });
          });
        }
      }

    }
  }

  _changeAttr(cate, title, setBottomState) {
    var attr = this._attr;
    for(var i = 0; i < attr.length; i++) {
      if (attr[i].cate == cate){
        attr[i].attrList.forEach((element) {
          if(element['title'] == title){
            element['checked'] = true;
          } else {
            element['checked'] = false;
          }
        });
      }
    }
    setBottomState(() { // 注意 改变 showModelBottomSheet 里面的数据来源于 StatefulBuilder
      this._attr = attr;
    });

    _getSelectedAttrValue();
  }

  // 获取选中的值
  _getSelectedAttrValue() {
    var _list = this._attr;
    List tempArr = [];
    for(var i = 0; i < _list.length; i++) {
      for( var j = 0; j< _list[i].attrList.length;j++){
        if(_list[i].attrList[j]['checked'] == true) {
          tempArr.add(_list[i].attrList[j]['title']);
        }
      }
    }
    setState(() {
      this._selectedValue = tempArr.join(',');
    });
  }

  // 选择项
  Widget _showBottomChoose(item, setBottomState){
      return Container(
        child: Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: 5),
              child: Text('${item.cate}：'),
            ),
            Container(
              child: Wrap(
                children: item.attrList.map<Widget>((innerItem){
                  return InkWell(
                    child: Container(
                      padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                      margin: EdgeInsets.only(left: 10),
                      decoration: BoxDecoration(
                      color: innerItem['checked']?Colors.red : Colors.black26,
                      borderRadius: BorderRadius.circular(10)
                      ),
                      child: Text('${innerItem['title']}', style: TextStyle(color: Colors.white),),
                      ),
                    onTap: (){
                      _changeAttr(item.cate,innerItem['title'], setBottomState);
                    },
                  );
                }).toList(),
              ),
            )
          ],
        ),
      );

  }
  // 下方弹出框展示
  _attrBottomSheet () {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return StatefulBuilder(
            builder: (BuildContext context, setBottomState) {
              return GestureDetector(
                // 嵌套 GestureDetector 是为了点击showModalBottomSheet的时候，不会收缩起来
                behavior: HitTestBehavior.opaque,
                onTap: () {},
                onDoubleTap: () {},
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
                              children: this._attr.map((attrItem){
                                return Container(
                                  child: Column(
                                    children: <Widget>[
                                      Wrap(
                                        children: <Widget>[
                                          _showBottomChoose(attrItem, setBottomState),
                                        ],
                                      ),
                                      SizedBox(height: ScreenAdapter.height(10),),
                                    ],
                                  ),
                                );
                              }).toList(),
                            ),
                            Divider(),
                            Container(
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.only(top: 5),
                                    child: Text('数量：'),
                                  ),
                                  Container(
                                    child: Wrap(
                                      children: <Widget>[
                                        CartNum()
                                      ],
                                    ),
                                  )
                                ],
                              ),
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
            },
          );
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    ScreenAdapter.init(context);
    var pic = '';
    pic = Config.domain + _pCItem.pic;
    pic = pic.replaceAll('\\', '/');

    return Container(
      padding: EdgeInsets.all(10),
      child: ListView(
        children: <Widget>[
          AspectRatio(
            aspectRatio: 16/15,
            child: Image.network('${pic}', fit: BoxFit.cover),
          ),
          Container(
            padding: EdgeInsets.only(top: 10),
            child: Text(
              '${_pCItem.title}',
              style: TextStyle(
                color: Colors.black87,
                fontSize: ScreenAdapter.setSp(38)
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 10),
            child: Text(
              '${_pCItem.subTitle}',
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
                          '￥${this._pCItem.price}',
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
                      Text('￥${this._pCItem.oldPrice}',
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
            child: this._attr.length != 0? InkWell(
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
                      '${this._selectedValue}',
                      style: TextStyle(
                          fontSize: ScreenAdapter.setSp(26)
                      )
                  ),
                ],
              ),
            ): Text(''),
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
                    '${this._pCItem.salecount == 0? '免费': this._pCItem.salecount}',
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

  @override
  bool get wantKeepAlive =>  true;
}
