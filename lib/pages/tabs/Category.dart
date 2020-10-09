import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

import '../../services/ScreenAdapter.dart';
import '../../model/CateModel.dart';
import '../../config/Config.dart';

class CategoryPage extends StatefulWidget {
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> with AutomaticKeepAliveClientMixin{
  var _currentIndex = 0;
  List _cateData = [];
  List _rightData = [];

  @override
  void initState() {
    super.initState();
    this._getCateData();
  }

  // 左边数据获取
  _getCateData() async{
    var api = Config.domain + 'api/pcate';
    var result = await Dio().get(api);
    var data = CateModel.fromJson(result.data);
    setState(() {
      this._cateData = data.result;
    });
    _getRightCateData(this._cateData[0].sId);
  }

  // 右边数据获取
  _getRightCateData(pid) async{
    var api = Config.domain + 'api/pcate?pid=${pid}';
    var result = await Dio().get(api);
    var data = CateModel.fromJson(result.data);
    setState(() {
      this._rightData = data.result;
    });
  }

  // 左边
  _leftCateWidget(leftWidth) {
    if(this._cateData.length != 0) {
      return Container(
        width: leftWidth,
        height: double.infinity,
        child: ListView.builder(
          itemBuilder: (context, index){
            return Column(
              children: <Widget>[
                InkWell(
                  child: Container(
                    child: Text('${this._cateData[index].title}',textAlign: TextAlign.center),
                    color: _currentIndex == index? Color.fromRGBO(240, 246, 246, 0.9):Colors.white,
                    width: double.infinity,
                    height: ScreenAdapter.height(82),
                    padding: EdgeInsets.all(8),
                  ),
                  onTap: (){
                    setState(() {
                      this._currentIndex = index;
                    });
                    this._getRightCateData(this._cateData[index].sId);
                  },
                ),
                // Divider 本身自带宽度，因此要设置宽度
                Divider(height: 1,)
              ],
            );
          },
          itemCount: this._cateData.length,
        ),
      );
    } else {
      return Container(
        width: leftWidth,
        height: double.infinity,
      );
    }

  }
  // 右边
  _rightCateWidget(rightItemWidth, rightItemHeight){
    if(this._rightData.length != 0){
      return Expanded(
        flex: 1,
        child: Container(
          padding: EdgeInsets.all(10),
          height: double.infinity,
          color: Color.fromRGBO(240, 246, 246, 0.9),
          child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: rightItemWidth/rightItemHeight,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
              ),
              itemCount: this._rightData.length,
              itemBuilder: (context, index) {
                var pic = this._rightData[index].pic;
                pic = Config.domain + pic.replaceAll('\\','/');
                return InkWell(
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        AspectRatio(
                          aspectRatio: 1/1,
                          child: Image.network(pic, fit: BoxFit.cover),
                        ),
                        Container(
                          height: ScreenAdapter.height(40),
                          child: Text('女装'),
                        )
                      ],
                    ),
                  ),
                  onTap: (){
                    Navigator.pushNamed(context, '/productList', arguments: {'pid': this._rightData[index].sId});
                  },
                );
              }
          ),
        ),
      );
    } else {
      return Expanded(
        flex: 1,
        child: Container(
            padding: EdgeInsets.all(10),
            height: double.infinity,
            color: Color.fromRGBO(240, 246, 246, 0.9),
            child:Text('加载中……')
        ),
      );
    }

  }
  @override
  Widget build(BuildContext context) {
    ScreenAdapter.init(context);

    var leftWidth = ScreenAdapter.getScreenWidth() / 4;

    //右侧每一项宽度=（总宽度-左侧宽度-GridView外侧元素左右的Padding值-GridView中间的间距）/3
    var rightItemWidth = (ScreenAdapter.getScreenWidth()-20-leftWidth-20) / 3;
    rightItemWidth = ScreenAdapter.width(rightItemWidth);
    //获取计算后的高度
    var rightItemHeight=rightItemWidth+ScreenAdapter.height(28);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.center_focus_weak, size: 28, color: Colors.black87),
          onPressed: (){},
        ),
        title: InkWell(
          child: Container(
            height: ScreenAdapter.height(70),
            decoration: BoxDecoration(
                color: Color.fromRGBO(233, 233, 233, 0.8),
                borderRadius: BorderRadius.circular(30)
            ),
            padding: EdgeInsets.only(left: 10),
            child: Row(
              children: <Widget>[
                Icon(Icons.search),
                Text('笔记本', style: TextStyle(fontSize: 14),)
              ],
            ),
          ),
          onTap: (){
            Navigator.pushNamed(context, '/search');
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.message, size: 28, color: Colors.black87),
            onPressed: null,
          )
        ],
      ),
      body: Row(
        children: <Widget>[
          _leftCateWidget(leftWidth),
          _rightCateWidget(rightItemWidth, rightItemHeight)
        ],
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
