import 'package:flutter/material.dart';
import 'package:flutter_jdshop/pages/Login.dart';
import '../pages/RegisterFirst.dart';
import '../pages/RegisterSecond.dart';
import '../pages/RegisterThird.dart';
import '../pages/tabs/Cart.dart';
import '../pages/ProductContent.dart';
import '../pages/ProductList.dart';
import '../pages/Search.dart';
import '../pages/tabs/Tab.dart';
// 配置路由
final routes = {
  '/':(context) => Tabs(),
  '/search':(context) => SearchPage(),
  '/productList':(context, { arguments }) => ProductList(arguments: arguments),
  '/productContent': (context, { arguments }) => ProductContentPage(arguments: arguments),
  '/cart':(context) => CartPage(),
  '/login':(context) => LoginPage(),
  '/registerFirst':(context) => RegisterFirst(),
  '/registerSecond':(context, { arguments }) => RegisterSecond(arguments: arguments),
  '/registerThird':(context) => RegisterThird(),
  /*
  '/product': (context) => ProductPage(),
  '/productInfo': (context, { arguments }) => ProductInfoPage(arguments: arguments),
   */
};

// 固定写法
var onGenerateRoute = (RouteSettings settings) {
  // 统一处理
  final String name = settings.name;
  final Function pageContentBuilder = routes[name];
  if(pageContentBuilder != null){
    if(settings.arguments != null){
      final Route route = MaterialPageRoute(
          builder: (context) => pageContentBuilder(context, arguments: settings.arguments)
      );
      return route;
    } else {
      final Route route = MaterialPageRoute(
          builder: (context) => pageContentBuilder(context)
      );
      return route;
    }
  }
};