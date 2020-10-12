import 'package:flutter/material.dart';
import 'pages/tabs/Tab.dart';
import 'routes/Routes.dart';

import 'provider/Cart.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
       ChangeNotifierProvider(create: (_) => Cart())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        home: Tabs(),
        theme: ThemeData(
            primaryColor: Colors.white
        ),
        onGenerateRoute: onGenerateRoute,
        // 忘记写，会报错Could not find a generator for route RouteSettings，路由未拦截
      ),
    );
  }
}
