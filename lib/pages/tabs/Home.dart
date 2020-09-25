import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
// 解决适配问题
import '../../services/ScreenAdaper.dart';
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  //轮播图
  Widget _swiperWidget() {
    List<Map> imgList = [
      {"url": "https://www.itying.com/images/flutter/slide01.jpg"},
      {"url": "https://www.itying.com/images/flutter/slide02.jpg"},
      {"url": "https://www.itying.com/images/flutter/slide03.jpg"},
    ];
    return Container(
      child: AspectRatio(
        aspectRatio: 2/1,
        child:  Swiper(
          itemBuilder: (BuildContext context,int index){
            return Image.network(
              imgList[index]['url'],
              fit: BoxFit.fill,);
          },
          itemCount: 3,
          pagination: new SwiperPagination(),
          autoplay: true,
        ),
      ),
    );
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
    return Container(
      width: double.infinity,
      height: ScreenAdaper.height(240),
      padding: EdgeInsets.all(ScreenAdaper.width(20)),
      child: ListView.builder(
          itemBuilder: (context, index) {
            return Column(
              children: <Widget>[
                Container(
                  width: ScreenAdaper.width(140),
                  height: ScreenAdaper.height(140),
                  margin: EdgeInsets.only(right: ScreenAdaper.width(5)),
                  child: Image.network("https://www.itying.com/images/flutter/hot${index+1}.jpg",fit: BoxFit.cover),
                ),
                Container(
                  height: ScreenAdaper.height(45),
                  padding: EdgeInsets.only(top: ScreenAdaper.height(5)),
                  child: Text("第${index}条"),
                )
              ],
            );
          },
          itemCount: 10,
          scrollDirection: Axis.horizontal,
          ),
    );
  }

  // 热门推荐
  Widget _hotWidget() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: 1),
      ),
      width: double.infinity,
      height: ScreenAdaper.height(200),
      child: GridView.builder(
          gridDelegate: null,
          itemBuilder: null
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
        _titleWidget('猜你喜欢'),
        SizedBox(height: ScreenAdaper.height(20)),
        _likeWidget(),
        _titleWidget('热门推荐'),
        SizedBox(height: ScreenAdaper.height(20)),

      ],
    );
  }
}
