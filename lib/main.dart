import 'package:flutter/material.dart';
import 'package:flutter_jdshop/pages/tabs/Tab.dart';
import 'package:flutter_jdshop/routes/Routes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/productList',
      home: Tabs(),
      onGenerateRoute: onGenerateRoute,
      // 忘记写，会报错Could not find a generator for route RouteSettings，路由未拦截
    );
  }
}
