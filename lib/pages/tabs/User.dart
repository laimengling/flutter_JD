import 'package:flutter/material.dart';
import '../../services/ScreenAdapter.dart';

class UserPage extends StatefulWidget {
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> with AutomaticKeepAliveClientMixin{
  @override
  Widget build(BuildContext context) {
    ScreenAdapter.init(context);
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Container(
            width: double.infinity,
            height: ScreenAdapter.height(200),
            decoration: BoxDecoration(
              image: new DecorationImage(
                fit: BoxFit.cover,
                image: new AssetImage('images/user_bg.jpg')
              )
            ),
            child: Row(
              children: <Widget>[
                Container(
                  margin:EdgeInsets.fromLTRB(10, 0, 15, 0),
                  width: ScreenAdapter.width(100),
                  child: ClipOval(
                    child: Image.asset(
                        'images/user.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: InkWell(
                    child: Text(
                      '登录/注册',
                      style: TextStyle(
                          color: Colors.white
                      ),
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, '/login');
                    },
                  ),
                ),
//                Expanded(
//                  flex: 1,
//                  child: Container(
//                    child: Column(
//                      mainAxisAlignment: MainAxisAlignment.spaceAround,
//                      crossAxisAlignment: CrossAxisAlignment.start,
//                      children: <Widget>[
//                        Text(
//                          "用户名：18760375007",
//                          style: TextStyle(
//                              color: Colors.white,
//                              fontSize: 12
//                          ),
//                        ),
//                        Text(
//                          "普通用户",
//                          style: TextStyle(
//                              color: Colors.white,
//                              fontSize: 12
//                          ),
//                        ),
//                      ],
//                    ),
//                    height: ScreenAdapter.height(100),
//                  ),
//                )
              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.assignment, color: Colors.red),
            title: Text('全部订单'),
          ),
          Divider(height: 1),
          ListTile(
            leading: Icon(Icons.payment, color: Colors.green),
            title: Text('待付款'),
          ),
          Divider(height: 1),
          ListTile(
            leading: Icon(Icons.local_car_wash, color: Colors.orange),
            title: Text('待收货'),
          ),
          Container(
            height: ScreenAdapter.height(10),
            width: double.infinity,
            color: Colors.black12,
          ),
          ListTile(
            leading: Icon(Icons.favorite, color: Colors.lightGreen),
            title: Text('我的收藏'),
          ),
          Divider(height: 1),
          ListTile(
            leading: Icon(Icons.people, color: Colors.black54),
            title: Text('在线客服'),
          ),
        ],
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
