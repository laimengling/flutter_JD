import 'package:flutter/material.dart';
import 'package:flutter_jdshop/pages/widget/JdButton.dart';

class PayPage extends StatefulWidget {
  @override
  _PayPageState createState() => _PayPageState();
}

class _PayPageState extends State<PayPage> {

  List payList = [
    {
      "title": "支付宝支付",
      "chekced": true,
      "image": "https://www.itying.com/themes/itying/images/alipay.png"
    },
    {
      "title": "微信支付",
      "chekced": false,
      "image": "https://www.itying.com/themes/itying/images/weixinpay.png"
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('支付页面'),
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: 400,
            padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
            child: ListView.builder(
              itemCount: payList.length,
                itemBuilder: (context, index){
                  return Container(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      children: <Widget>[
                        this.payList[index]['chekced']?
                        ListTile(
                          leading: Image.network('${this.payList[index]['image']}'),
                          title: Text('${this.payList[index]['title']}'),
                          trailing: Icon(Icons.done),
                          onTap: (){},
                        ):
                        ListTile(
                          leading:  Image.network("${this.payList[index]["image"]}"),
                          title: Text('${this.payList[index]['title']}'),
                          onTap: (){
                            //让payList里面的checked都等于false
                            setState(() {
                              for (var i = 0; i < this.payList.length; i++) {
                                this.payList[i]['chekced'] = false;
                              }
                              this.payList[index]["chekced"] = true;
                            });
                          },
                        ),
                      ],
                    ),
                  );
                }
                ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: JdButton(
              color: Colors.red,
              text: '支付',
            ),
          )
        ],
      ),
    );
  }
}
