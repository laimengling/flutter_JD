import 'dart:convert';
import 'package:flutter_jdshop/config/Config.dart';

import 'Storage.dart';
class CartServices {

  static addCart(item) async{
    item = formatCartData(item);
    print(item);
    try {
      List cartListData = json.decode(await Storage.getString('cartList'));
      var hasData = cartListData.any((v) {
        // id与选择的物品属性完全相同才是相同
        return (v['_id'] == item['_id']) && (v['selectedAttr'] == item['selectedAttr']);
      });
      if (!hasData) {
        cartListData.add(item);
      } else {
        cartListData.forEach((element) {
           if((element['_id'] == item['_id']) && (element['selectedAttr'] == item['selectedAttr'])) {
             element['count'] += item['count'];
           }
        });
      }
      await Storage.setString('cartList', json.encode(cartListData));
    } catch (e) {
      List tempList = new List();
      tempList.add(item);
      await Storage.setString('cartList', json.encode(tempList));
    }
  }

  // 过滤数据
  static formatCartData(item){
    String sPic = item.pic;
    sPic = Config.domain + sPic.replaceAll('\\', '/');
    print(sPic);
    final Map data = new Map<String, dynamic>();
    data['_id'] = item.sId;
    data['title'] = item.title;
    // 返回数据类型不一
    if(item.price is int || item.price is double) {
      data['price'] = item.price;
    } else {
      data['price'] = double.parse(item.price);
    }
    data['selectedAttr'] = item.selectedAttr;
    data['count'] = item.count;
    data['pic'] = sPic;
    data['checked'] = true;
    return data;
  }
}