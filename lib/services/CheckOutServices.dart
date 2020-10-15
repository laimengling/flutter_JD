import 'dart:convert';
import '../services/Storage.dart';
class CheckOutServices{
  // 计算总价
  static getAllPrice(checkOutListData) {
    var tempAllPrice = 0.0;
    for(var i = 0; i<checkOutListData.length; i++) {
      if(checkOutListData[i]['checked']){
        tempAllPrice += checkOutListData[i]['price'] * checkOutListData[i]['count'];
      }
    }
    return tempAllPrice;
  }

  // 删除选择项
  static removeSelectedItem() async{
    List _tempList = [];
    List _cartList = [];
    try {
      List cartListData = json.decode(await Storage.getString('cartList'));
      _cartList  = cartListData;
    } catch(e) {
      _cartList = [];
    }

    for (var i=0; i< _cartList.length; i++) {
      if(!_cartList[i]['checked']){
        _tempList.add(_cartList[i]);
      }
    }

    Storage.setString('cartList', json.encode(_tempList));
  }
}