import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:dio/dio.dart';
import 'dart:convert';
// 解决适配问题
import '../../services/ScreenAdaper.dart';
import '../../model/FocusModel.dart';
import '../../model/ProductModel.dart';
import '../../config/Config.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List _focusData = [];
  List _likeData = [];
  List _hotData = [];

  @override
  void initState() {
    super.initState();
    _getFocusData();
    _getHotData();
    _getLikeData();
  }
  // 获取轮播数据
  void _getFocusData() async{
    var api = '${Config.domain}api/focus';
    var result = await Dio().get(api);
    var focusList = FocusModel.fromJson(result.data);
    setState(() {
      this._focusData = focusList.result;
    });
  }

  // 猜你喜欢数据获取
  void _getLikeData() async{
    var api = '${Config.domain}api/plist?is_hot=1';
    var result = await Dio().get(api);
    var focusList = ProductModel.fromJson(result.data);
    setState(() {
      this._likeData = focusList.result;
    });
  }

  // 热门推荐数据获取
  void _getHotData() async{
    var api = '${Config.domain}api/plist?is_best=1';
    var result = await Dio().get(api);
    var focusList = ProductModel.fromJson(result.data);
    setState(() {
      this._hotData = focusList.result;
    });
  }


  //轮播图
  Widget _swiperWidget() {
    if (this._focusData.length != 0) {
      return Container(
        child: AspectRatio(
          aspectRatio: 2/1,
          child:  Swiper(
            itemBuilder: (BuildContext context,int index){
              var pic = this._focusData[index].pic;
              pic = Config.domain+pic.replaceAll('\\', '/');
              return Image.network(
                pic,
                fit: BoxFit.fill,);
            },
            itemCount: this._focusData.length,
            pagination: new SwiperPagination(),
            autoplay: true,
          ),
        ),
      );
    } else {
      return Text('数据为空');
    }
  }

  // 标题
  Widget _titleWidget(value) {
    return Container(
      height: ScreenAdaper.height(45),
      margin: EdgeInsets.only(left: ScreenAdaper.width(20)),
      padding: EdgeInsets.only(left:ScreenAdaper.width(20)),
      decoration: BoxDecoration(
        border: Border(
         left:  BorderSide(
           color: Colors.red,
           width: ScreenAdaper.width(5)
         )
        )
      ),
      child: Text(value, style: TextStyle(
        color: Colors.black54
      ),),
    );
  }

  // 猜你喜欢
  Widget _likeWidget() {
    if (this._likeData.length != 0) {
      return Container(
        width: double.infinity,
        height: ScreenAdaper.height(240),
        padding: EdgeInsets.all(ScreenAdaper.width(20)),
        child: ListView.builder(
          itemBuilder: (context, index) {
            var pic = _likeData[index].sPic;
            pic = Config.domain+pic.replaceAll('\\', '/');
            return Column(
              children: <Widget>[
                Container(
                  width: ScreenAdaper.width(140),
                  height: ScreenAdaper.height(140),
                  margin: EdgeInsets.only(right: ScreenAdaper.width(5)),
                  child: Image.network(pic,fit: BoxFit.cover),
                ),
                Container(
                  height: ScreenAdaper.height(45),
                  padding: EdgeInsets.only(top: ScreenAdaper.height(5)),
                  child: Text(
                    "￥${_likeData[index].price}",
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  ),
                )
              ],
            );
          },
          itemCount: _likeData.length,
          scrollDirection: Axis.horizontal,
        ),
      );
    } else {
     return Text('数据为空');
    }
  }

  // 热门推荐
  Widget _hotWidget() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(10),
      child: Wrap(
        runSpacing: 10,
        spacing: 10,
        children: this._hotData.map<Widget>((element) {
          return this._recProductListWidget(element);
        }).toList(),
      ),
    );
  }

  _recProductListWidget(value) {
    var width = (ScreenAdaper.getScreenWidth() - 17) ;
    var pic = Config.domain + value.pic.replaceAll('\\', '/');
    return Container(
      width: ScreenAdaper.width(width),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black12, width: 1),
      ),
      padding: EdgeInsets.all(5),
      child: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            child: AspectRatio( // 防止返回的图片高度不一
              aspectRatio: 1/1,
              child: Image.network(pic,fit: BoxFit.fill),
            )
          ),
          Padding(
            padding: EdgeInsets.only(top: ScreenAdaper.height(20)),
            child: Text(
                value.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Colors.black54)
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: ScreenAdaper.height(20)),
            child: Stack(
              children: <Widget>[
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '￥${value.price}',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 14
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                      '￥${value.oldPrice}',
                    style: TextStyle(
                      fontSize: 12,
                      decoration: TextDecoration.lineThrough
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    // 不同设备适配问题
    ScreenAdaper.init(context);
    return ListView(
      children: <Widget>[
        _swiperWidget(),
        SizedBox(height: ScreenAdaper.height(20)),
        _titleWidget('猜你喜欢'),
        SizedBox(height: ScreenAdaper.height(20)),
        _likeWidget(),
        _titleWidget('热门推荐'),
        SizedBox(height: ScreenAdaper.height(20)),
        _hotWidget(),
      ],
    );
  }

}
