import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../provider/Cart.dart';
import 'package:provider/provider.dart';
import '../config/Config.dart';
import '../model/ProductContentModel.dart';
import '../services/CartServices.dart';
import '../services/ScreenAdapter.dart';
import 'ProductContent/ProductContentFirst.dart';
import 'ProductContent/ProductContentSecond.dart';
import 'ProductContent/ProductContentThree.dart';
import '../services/EventBus.dart'; // 广播

class ProductContentPage extends StatefulWidget {
  Map arguments;
  ProductContentPage ({Key key, this.arguments}): super(key: key);
  @override
  _ProductContentPageState createState() => _ProductContentPageState(this.arguments);
}

class _ProductContentPageState extends State<ProductContentPage> {
  Map arguments;


  List _productContentList=[];

  var cartProvider;

  _ProductContentPageState(this.arguments);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // print(this._productContentData.sId);

    this._getContentData();
  }
  _getContentData() async{

    var api ='${Config.domain}api/pcontent?id=${arguments['sId']}';

    var result = await Dio().get(api);
    var productContent = new ProductContentModel.fromJson(result.data);
    setState(() {
      this._productContentList.add(productContent.result);
    });
  }

  @override
  Widget build(BuildContext context) {
    ScreenAdapter.init(context);
    this.cartProvider = Provider.of<Cart>(context);
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: TabBar(
            indicatorColor: Colors.red,
            indicatorSize: TabBarIndicatorSize.label,
            tabs: <Widget>[
              Tab(text: '商品',),
              Tab(text: '详情',),
              Tab(text: '评价',),
            ],
          ),
          centerTitle: false,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.more_horiz,color: Colors.black,),
              onPressed: () {
                showMenu(
                    context: context,
                    position: RelativeRect.fromLTRB(900, 76, 0, 0),
                    items: [
                      PopupMenuItem(
                        value: '1',
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.home),
                            Text('首页')
                          ],
                        )
                      ),
                      PopupMenuItem(
                        value: '2',
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.search),
                            Text('搜索')
                          ],
                        )
                      ),
                    ],
                );
              },
            )
          ],
        ),
        body: Stack(
          children: <Widget>[
            TabBarView(
              physics: NeverScrollableScrollPhysics(), // 禁止tabView 滑动
              children: <Widget>[
                ProductContentFirst(this._productContentList),
                ProductContentSecond(this._productContentList),
                ProductContentThird()
              ],
            ),
            Positioned(
              width: ScreenAdapter.width(750),
              height: ScreenAdapter.height(100),
              bottom: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    top: BorderSide(
                      color: Colors.black26
                    )
                  ),
                ),
                child: Row(
                  children: <Widget>[
                    InkWell(
                      child: Container(
                        padding: EdgeInsets.only(top: 
                        ScreenAdapter.width(20)
                        ),
                        width: ScreenAdapter.width(270),
                        height: ScreenAdapter.height(100),
                        child: Column(
                          children: <Widget>[
                            Icon(Icons.shopping_cart, size: ScreenAdapter.setSp(40),),
                            Text('购物车',style: TextStyle(fontSize: 10),)
                          ],
                        ),
                      ),
                      onTap: () {
                        Navigator.pushNamed(context, '/cart');
                      },
                    ),
                    Expanded(
                      flex: 1,
                      child: Row(
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                            margin: EdgeInsets.only(right: 20),
                            child: InkWell(
                              child: Text('加入购物车', style: TextStyle(color: Colors.white),),
                              onTap: ()async{
                                // 广播 这里有不合理的地方，如果她的attr是空的，在ProductContentFirst接收到广播仍然会弹出空白 Container
                                // 改造 数据在ProductContent 查询，传到ProductContentFirst
                                if (this._productContentList[0].attr.length >0) {
                                  eventBus.fire(new ProductContentEvent('加入购物车'));
                                } else {
                                  Fluttertoast.showToast(
                                      msg: '加入购物车成功',
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.CENTER,
                                      backgroundColor: Colors.black,
                                      textColor: Colors.white
                                  );
                                  await CartServices.addCart(this._productContentList[0]);
                                  // 调用Provider 更新数据
                                  this.cartProvider.updateCartList();
                                }
                              },
                            )
                          ),
                          Container(
                              decoration: BoxDecoration(
                                color: Colors.yellow,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                              margin: EdgeInsets.only(right: 20),
                              child: InkWell(
                                child: Text('立即购买', style: TextStyle(color: Colors.white),),
                                onTap: (){
                                  if(this._productContentList[0].attr.length>0){
                                    //广播 弹出筛选
                                    eventBus.fire(new ProductContentEvent('立即购买'));
                                  }else{
                                    print("立即购买");
                                  }
                                },
                              )
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),

            )
          ],
        ),
      ),
    );
  }
}
