import 'package:flutter/material.dart';
import 'package:flutter_jdshop/pages/tabs/Cart.dart';
import 'package:flutter_jdshop/pages/tabs/Category.dart';
import 'package:flutter_jdshop/pages/tabs/Home.dart';
import 'package:flutter_jdshop/pages/tabs/User.dart';
import 'package:flutter_jdshop/services/ScreenAdapter.dart';

class Tabs extends StatefulWidget {
  @override
  _TabsState createState() => _TabsState();
}

class _TabsState extends State<Tabs> {

  int _currentIndex  = 0;

  // 创建页面控制器
  var _pageController;

  List<Widget> _pageList = [
    HomePage(),
    CategoryPage(),
    CartPage(),
    UserPage()
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // 页面控制器初始化
    this._pageController = new PageController(initialPage: _currentIndex);
  }

  @override
  Widget build(BuildContext context) {
    ScreenAdapter.init(context);
    return Scaffold(
      appBar: this._currentIndex != 3?AppBar(
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
      ) : AppBar(
        title: Text('用户中心'),
      ),
      body:PageView(
        controller: _pageController,
        children: this._pageList,
        onPageChanged: (index){
          setState(() {
            this._currentIndex = index;
          });
        },
//        physics: NeverScrollableScrollPhysics(), 静止页面，不能左右滑动
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: this._currentIndex,
        onTap: (index){
          setState(() {
//            this._currentIndex = index;
            //页面控制器进行跳转
              _pageController.jumpToPage(index);
          });
        },
        fixedColor: Colors.red,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text('首页')
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.category),
              title: Text('分类')
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart),
              title: Text('购物车')
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              title: Text('我的')
          ),
        ],
      ),
    );
  }
}
