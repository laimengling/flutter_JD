import 'package:flutter/material.dart';
import '../../pages/widget/JdButton.dart';
import '../../pages/widget/JdText.dart';
import '../../services/ScreenAdapter.dart';
import 'package:city_pickers/city_pickers.dart';

class AddressEdit extends StatefulWidget {
  @override
  _AddressEditState createState() => _AddressEditState();
}

class _AddressEditState extends State<AddressEdit> {

  String area = '省/市/区';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('增加收货地址'),
      ),
      body: Container(
        padding: EdgeInsets.only(top: 20),
        child: ListView(
          children: <Widget>[
            JdText(text: '收件人姓名', onChange: (v) {

            }),
            SizedBox(height: ScreenAdapter.height(20)),
            JdText(text: '收件人电话号码', onChange: (v) {

            }),
            SizedBox(height: ScreenAdapter.height(20)),
            InkWell(
              child: Container(
                height: ScreenAdapter.height(78),
                padding: EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                            width: 1,
                            color: Colors.black12
                        )
                    )
                ),
                child: Row(
                  children: <Widget>[
                    SizedBox(width: ScreenAdapter.width(15),),
                    Icon(Icons.add_location,color: Colors.black45),
                    Text('${this.area}', style: TextStyle(color: Colors.black45))
                  ],
                ),
              ),
              onTap: () async{
                Result result = await CityPickers.showCityPicker(
                    context: context,
                    cancelWidget: Text('取消', style: TextStyle(color: Colors.black)),
                    confirmWidget: Text('确定', style: TextStyle(color: Colors.black))
                );
                setState(() {
                  this.area = "${result.provinceName}/${result.cityName}/${result.areaName}";
                });
                print(result);
              },
            ),
            SizedBox(height: ScreenAdapter.height(20)),
            Text('    详细地址', style: TextStyle(color: Colors.black45, )),
            JdText( text: '',onChange: (v) {

            }),
            SizedBox(height: ScreenAdapter.height(150)),
            Container(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: JdButton(color: Colors.red,text: '增加', cb: (){}),
            )
          ],
        ),
      ),
    );
  }
}
