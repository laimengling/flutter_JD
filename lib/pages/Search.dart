import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../services/ScreenAdapter.dart';
import '../services/SearchServices.dart';

class SearchPage extends StatefulWidget {
  SearchPage({Key key}) : super(key: key);

  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String keyWords = '';
  List _historyListData = [];

  @override
  void initState() {
    super.initState();
    this.getHistoryData();
  }
  // 获取历史搜索数据
  void getHistoryData() async{
    var list = await  SearchServices.getHistoryList();
    setState(() {
      this._historyListData = list;
    });
  }

  //展示Dialog
  _alertDialog (keywords) async{
     await showDialog(
        barrierDismissible:false,   //表示点击灰色背景的时候是否消失弹出框
        context: context,
        builder: (context){
          return AlertDialog(
            title: Text('提示信息'),
            content: Text('确定删除${keywords}？'),
            actions: <Widget>[
              FlatButton(
                child: Text('确定'),
                onPressed: () async{
                  await SearchServices.removeHistoryData(keywords);
                  this.getHistoryData();
                  Navigator.pop(context,'yes');
                },
              ),
              SizedBox(width: 10,),
              FlatButton(
                child: Text('取消'),
                onPressed: (){
                  Navigator.pop(context,'no');
                },
              ),
            ],
          );
        }
    );
  }

  // 获取历史搜索数据树
  Widget _getHistory () {
    if(this._historyListData.length > 0){
      return Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              child: Text(
                  '历史搜索',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)
              ),
            ),
            Divider(),
            Column(
              children: this._historyListData.map((v){
                return Column(
                  children: <Widget>[
                    ListTile(
                      title: Text(v),
                      onLongPress: () {
                        this._alertDialog(v);

                      },
                    ),
                    Divider(height: 1),
                  ],
                );
              }).toList(),
            ),
          ],
        ),
      );
    } else {
      return Text('');
    }
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
            autofocus: true,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none
              )
            ),
            onChanged: (value){
              setState(() {
                this.keyWords = value;
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
              SearchServices.setHistoryData(this.keyWords.trim());
              Navigator.pushReplacementNamed(context, '/productList', arguments: {
                'keywords': this.keyWords.trim()
              });
              // pushNamed
              // pushReplacementNamed 替换路由
            },
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            Container(
              child: Text(
                  '热搜',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)
              ),
            ),
            Divider(),
            Wrap(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(5),
                  margin: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(233, 233, 233, 0.9),
                    borderRadius: BorderRadius.circular(5)
                  ),
                  child: Text('女装',style: TextStyle(fontSize: 13)),
                ),
                Container(
                  padding: EdgeInsets.all(5),
                  margin: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(233, 233, 233, 0.9),
                      borderRadius: BorderRadius.circular(5)
                  ),
                  child: Text('女装',style: TextStyle(fontSize: 13)),
                ),
              ],
            ),
           // 获取历史搜索
           _getHistory(),
            SizedBox(height: ScreenAdapter.height(40)),
            InkWell(
              child: Container(
                  width: ScreenAdapter.width(500),
                  height: ScreenAdapter.height(64),
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: Colors.black45
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.delete_outline),
                      Text('清空历史搜索')
                    ],
                  ),
                ),
              onTap: (){
                SearchServices.clearHistoryList();
                this.getHistoryData();
              }
            )
          ],
        ),
      ),
    );
  }
}