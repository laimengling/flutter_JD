import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_jdshop/services/SearchServices.dart';
import '../pages/widget/Loading.dart';
import '../model/ProductModel.dart';
import '../services/ScreenAdapter.dart';
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

  // 二级导航数据
  bool _hasData = true; // 判断进来是否有数据
  List _subHeaderList = [
    {
      "id": 1,
      "title": "综合",
      "fileds": "all",
      "sort": -1, // 排序
    },
    {
      "id": 2,
      "title": "销量",
      "fileds": "salecount",
      "sort": -1, // 排序
    },
    {
      "id": 3,
      "title": "价格",
      "fileds": "price",
      "sort": -1, // 排序
    },
    {
      "id": 4,
      "title": "筛选",
    },
  ];
  int _selectHeaderId = 1;

  // 搜索框
  String keywords = '';

  // 配置search 搜索框的值
  var _initKeywordsController = new TextEditingController();
  _ProductListState({this.arguments});

  @override
  void initState() {
    super.initState();
    arguments['keywords'] == null ? this._initKeywordsController.text = '': this._initKeywordsController.text = arguments['keywords'];
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
    var api;
    if (arguments['keywords'] != null || this.keywords != ''){
      api = '${Config.domain}api/plist?search=${this._initKeywordsController.text}&page=${_page}&sort=${_sort}&pageSize=${_pageSize}';
    } else {
      api = '${Config.domain}api/plist?cid=${arguments['pid']}&page=${_page}&sort=${_sort}&pageSize=${_pageSize}';
    }
    var result = await Dio().get(api);
    var focusList = ProductModel.fromJson(result.data);
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
    if(focusList.result.length == 0 && this._page == 1){
      setState(() {
        this._hasData = false;
      });
    } else {
      setState(() {
        this._hasData = true;
      });
    }
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
                        width: ScreenAdapter.width(180),
                        height: ScreenAdapter.height(180),
                        child: Image.network('${pic}', fit: BoxFit.cover),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          height:ScreenAdapter.width(180),
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
                                    height: ScreenAdapter.height(36),
                                    margin: EdgeInsets.only(right: 10),
                                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Color.fromRGBO(230, 230, 230, 0.9)
                                    ),
                                    child: Text('4g'),
                                  ),
                                  Container(
                                    height: ScreenAdapter.height(36),
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
                                "￥${this._productList[index].price}",
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

  // 展示筛选导航后的图标
  Widget _showIcon(id) {
    if(id == 2 || id == 3){
      if(this._subHeaderList[id-1]['sort'] < 0) {
        return Icon(Icons.arrow_drop_down, color: id == this._selectHeaderId? Colors.red : Colors.black54,);
      } else {
        return Icon(Icons.arrow_drop_up, color: id == this._selectHeaderId? Colors.red : Colors.black54,);
      }
    } else {
      return Text('');
    }
  }

  // 筛选导航
  Widget _subHeaderWidget() {
    return Positioned(
      top: 0,
      width: ScreenAdapter.width(747),
      height: ScreenAdapter.height(80),
      child: Container(
        width: ScreenAdapter.width(800),
        height: ScreenAdapter.height(80),
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(
                    width: 1,
                    color: Color.fromRGBO(233, 233, 233, 0.9)
                )
            )
        ),
        child: Row(
          children: this._subHeaderList.map((value){
            return Expanded(
              flex: 1,
              child: InkWell(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(0, ScreenAdapter.width(16), 0, ScreenAdapter.width(16)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        '${value['title']}',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: (this._selectHeaderId == value['id'])?Colors.red : Colors.black54),
                      ),
                      _showIcon(value['id'])
                    ],
                  )
                ),
                onTap: (){
                  setState(() {
                    this._selectHeaderId = value['id'];
                  });
                  if(value['id'] != 4){
                    setState(() {
                      value['sort'] = -value['sort'];
                      _sort = '${value['fileds']}_${value['sort']}';
                      this._page = 1;
                      this._productList = [];
                      this._hasMore = true;
                    });
                    this._scrollController.jumpTo(0);
                    this._getPlist();
                  } else {
                    _scaffoldKey.currentState.openEndDrawer();
                  }
                },
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ScreenAdapter.init(context);
    return Scaffold(
      appBar: AppBar(
        title: Container(
          height: ScreenAdapter.height(70),
          decoration: BoxDecoration(
              color: Color.fromRGBO(233, 233, 233, 0.8),
              borderRadius: BorderRadius.circular(30)
          ),
          child: TextField(
            controller: _initKeywordsController,
            autofocus: false,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none
                )
            ),
            onChanged: (value){
              setState(() {
                this.keywords = value;
              });
            },
          ),
        ),
        actions: <Widget>[
          InkWell(
            child: Container(
              height: ScreenAdapter.height(70),
              padding: EdgeInsets.all(10),
              child: Row(
                children: <Widget>[
                  Text('搜索', textAlign: TextAlign.center,)
                ],
              ),
            ),
            onTap: () {
              setState(() {
                this._page = 0;
                this._productList = [];
                this._hasMore = true;
                this._selectHeaderId = 1;
              });
              SearchServices.setHistoryData(this.keywords);
             this._getPlist();
              // pushNamed
              // pushReplacementNamed 替换路由
            },
          )
        ],
      ),
//      AppBar(
//        title: arguments['keywords'] != null?Text('${arguments['keywords']}'):Text('商品列表'),
////        leading: Text(""),
//        actions: <Widget>[
//          Text("")
//        ],
//      ),
      key: _scaffoldKey,
      endDrawer: Drawer(
        child: Text('11'),
      ),
      body: this._hasData?Stack(
        children: <Widget>[
          _productListWidget(),
          _subHeaderWidget(),
        ],
      ):Center(
        child: Text('没有你要搜索的数据哦'),
      ),
    );
  }
}
