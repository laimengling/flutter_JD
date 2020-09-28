import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import '../pages/widget/Loading.dart';
import '../model/ProductModel.dart';
import '../services/ScreenAdaper.dart';
import '../config/Config.dart';
class ProductList extends StatefulWidget {

  Map arguments;
  ProductList({Key key, this.arguments}) :super(key: key);

  @override
  _ProductListState createState() => _ProductListState(arguments: this.arguments);
}

class _ProductListState extends State<ProductList> {

  // 传过来的参数
  Map arguments;
  // Scaffold key
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  // 分页
  int _page = 1;
  // 每页数据大小
  int _pageSize = 10;
  ScrollController _scrollController = new ScrollController(); // 滚动条
  List _productList = []; // 数据
  /*
  价格升序 sort=price_1 价格降序 sort=price_-1 销量升序 sort=salecount_1 销量降序 sort=salecount_-1
   */
  String _sort = 'price_1'; // 排序
  bool _flag = true; // 防止数据还未回来，再次触发加载
  bool _hasMore = true; // 是否还有数据

  _ProductListState({this.arguments});

  @override
  void initState() {
    super.initState();
    this._getPlist();
    // 监听滚动条数据
    _scrollController.addListener(() {
      // 滚动的距离 滚动的最大长度
      if(_scrollController.position.pixels >= _scrollController.position.maxScrollExtent) {
        if(this._flag && this._hasMore){
          this._getPlist();
        }
      }
    });
  }

  // 获取商品数据列表
  _getPlist() async{
    setState(() {
      this._flag = false;
    });
    var api = '${Config.domain}api/plist?cid=${arguments['pid']}&page=${_page}&sort=${_sort}&pageSize=${_pageSize}';
    var result = await Dio().get(api);
    var focusList = ProductModel.fromJson(result.data);
    print(result.data.length);
    print(this._pageSize);
    if(focusList.result.length<this._pageSize){
      setState(() {
        this._hasMore = false;
      });
    }
    setState(() {
      this._productList.addAll(focusList.result) ;
      this._page++;
      this._flag = true;
    });
  }

  // 显示加载圈圈
  Widget _showMore(index) {
    if(this._hasMore){
      return (index == this._productList.length - 1)?LoadingWidget():Text('');
    } else {
      return (index == this._productList.length - 1)?Text("----我是有底线的----"):Text('');
    }
  }

  // 商品列表
  Widget _productListWidget() {
    if(this._productList.length !=0){
      return Container(
        padding: EdgeInsets.all(10),
        margin:EdgeInsets.only(top: 30),
        child: ListView.builder(
          controller: _scrollController,
            itemCount: this._productList.length,
            itemBuilder: (context, index) {
              var pic = Config.domain + this._productList[index].pic;
              pic = pic.replaceAll('\\', '/');
              return Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                        width: ScreenAdaper.width(180),
                        height: ScreenAdaper.height(180),
                        child: Image.network('${pic}', fit: BoxFit.cover),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          height:ScreenAdaper.width(180),
                          margin: EdgeInsets.only(left: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Text(
                                '${this._productList[index].title}',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(

                                ),
                              ),
                              Row(
                                children: <Widget>[
                                  Container(
                                    height: ScreenAdaper.height(36),
                                    margin: EdgeInsets.only(right: 10),
                                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Color.fromRGBO(230, 230, 230, 0.9)
                                    ),
                                    child: Text('4g'),
                                  ),
                                  Container(
                                    height: ScreenAdaper.height(36),
                                    margin: EdgeInsets.only(right: 10),
                                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Color.fromRGBO(230, 230, 230, 0.9)
                                    ),
                                    child: Text('126'),
                                  ),
                                ],
                              ),
                              Text(
                                "${this._productList[index].price}",
                                style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 16.0
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  Divider(height: 20,),
                  _showMore(index)
                ],
              );
            }
        ),
      );
    } else {
      return LoadingWidget();
    }

  }

  // 筛选导航
  Widget _subHeaderWidget() {
    return Positioned(
      top: 0,
      width: ScreenAdaper.width(747),
      height: ScreenAdaper.height(80),
      child: Container(
        width: ScreenAdaper.width(800),
        height: ScreenAdaper.height(80),
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(
                    width: 1,
                    color: Color.fromRGBO(233, 233, 233, 0.9)
                )
            )
        ),
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: InkWell(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(0, ScreenAdaper.width(16), 0, ScreenAdaper.width(16)),
                  child: Text(
                    "综合",
                    textAlign: TextAlign.center,
                  ),
                ),
                onTap: (){},
              ),
            ),
            Expanded(
              flex: 1,
              child: InkWell(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(0, ScreenAdaper.width(16), 0, ScreenAdaper.width(16)),
                  child: Text(
                    "销量",
                    textAlign: TextAlign.center,
                  ),
                ),
                onTap: (){},
              ),
            ),
            Expanded(
              flex: 1,
              child: InkWell(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(0, ScreenAdaper.width(16), 0, ScreenAdaper.width(16)),
                  child: Text(
                    "价格",
                    textAlign: TextAlign.center,
                  ),
                ),
                onTap: (){},
              ),
            ),
            Expanded(
              flex: 1,
              child: InkWell(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(0, ScreenAdaper.width(16), 0, ScreenAdaper.width(16)),
                  child: Text(
                    "筛选",
                    textAlign: TextAlign.center,
                  ),
                ),
                onTap: (){
                  _scaffoldKey.currentState.openEndDrawer();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    ScreenAdaper.init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('商品列表'),
//        leading: Text(""),
      actions: <Widget>[
        Text("")
      ],
      ),
      key: _scaffoldKey,
      endDrawer: Drawer(
        child: Text('11'),
      ),
      body: Stack(
        children: <Widget>[
          _productListWidget(),
          _subHeaderWidget(),
        ],
      ),
    );
  }
}
