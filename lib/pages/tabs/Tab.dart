import 'package:flutter/material.dart';
import 'package:flutter_jdshop/pages/tabs/Cart.dart';
import 'package:flutter_jdshop/pages/tabs/Category.dart';
import 'package:flutter_jdshop/pages/tabs/Home.dart';
import 'package:flutter_jdshop/pages/tabs/User.dart';

class Tabs extends StatefulWidget {
  @override
  _TabsState createState() => _TabsState();
}

class _TabsState extends State<Tabs> {

  int _currentIndex  = 1;

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
    return Scaffold(
      appBar: AppBar(
        title: Text('jdshop'),
      ),
      body:PageView(
        controller: _pageController,
        children: this._pageList,
        onPageChanged: (index){
          _currentIndex = index;
        },
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
