import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_jdshop/services/ScreenAdapter.dart';
import 'ProductContent/ProductContentFirst.dart';
import 'ProductContent/ProductContentSecond.dart';
import 'ProductContent/ProductContentThree.dart';
class ProductContentPage extends StatefulWidget {
  Map arguments;
  ProductContentPage ({Key key, this.arguments}): super(key: key);
  @override
  _ProductContentPageState createState() => _ProductContentPageState(this.arguments);
}

class _ProductContentPageState extends State<ProductContentPage> {
  Map arguments;
  _ProductContentPageState(this.arguments);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(arguments['sId']);
  }

  @override
  Widget build(BuildContext context) {
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
              children: <Widget>[
                ProductContentFirst(),
                ProductContentSecond(),
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
                    Container(
                      padding: EdgeInsets.only(top: 5),
                      width: ScreenAdapter.width(270),
                      height: ScreenAdapter.height(100),
                      child: Column(
                        children: <Widget>[
                          Icon(Icons.shopping_cart),
                          Text('购物车',style: TextStyle(fontSize: 10),)
                        ],
                      ),
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
