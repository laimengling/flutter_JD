import 'package:flutter/material.dart';
import '../services/Storage.dart';
import 'dart:convert';
class Cart with ChangeNotifier{

  List _cartList=[];  //购物车数据
  bool _isCheckedAll = false; // 全选 私有
  double _allPrice = 0; // 总价
  List get cartList=>this._cartList; // 获取私有属性值
  bool get isCheckedAll => this._isCheckedAll;
  double get allPrice => this._allPrice;
  Cart() {
    this.init();
  }
  // 初始化的时候获取购物车数据
  init () async{
    // catch(e) 是当Storage获取不到捕捉的异常
    try{
      List cartListData = json.decode(await Storage.getString('cartList'));
      this._cartList = cartListData;
    } catch(e) {
      this._cartList = [];
    }
    _isCheckedAll = isCheckAll();
    computeAllPrice();
    notifyListeners();
  }

  // 更新
   updateCartList() {
    init();
  }

  // shopcart item count
   changeItemCount() async{
    Storage.setString('cartList', json.encode(this._cartList));
    // 计算总价
    computeAllPrice();
    notifyListeners();
  }

  // 全选、反选
  checkAll(v) {
    _isCheckedAll = v;
    for (var i=0; i< this._cartList.length; i++) {
      this._cartList[i]['checked'] = v;
    }
    // 计算总价
    computeAllPrice();
    Storage.setString('cartList', json.encode(this._cartList));
    notifyListeners();
  }

  // 判断是否全选
  bool isCheckAll(){
    if(this._cartList.length>0){
      for (var i=0; i< this._cartList.length; i++) {
        if(!this._cartList[i]['checked']){
          return false;
        }
      }
      return true;
    }
    return false;
  }

  // 监听每一项的选中事件
  itemChange() {
    this._isCheckedAll = this.isCheckAll();
    // 计算总价
    computeAllPrice();
    Storage.setString('cartList', json.encode(this._cartList));
    notifyListeners();
  }

  // 计算总价
  computeAllPrice() {
    this._allPrice = 0.0;
    if(this._cartList.length>0){
      for (var i=0; i< this._cartList.length; i++) {
        if(this._cartList[i]['checked']){
          this._allPrice += this._cartList[i]['price']* this._cartList[i]['count'];
        }
      }
    } else {
      this._allPrice = 0.0;
    }
    notifyListeners();
  }

  // 删除选择项
  removeSelectedItem (){
    if(this._cartList.length>0){
      for (var i=0; i< this._cartList.length; i++) {
        if(this._cartList[i]['checked']){
          this._cartList.removeAt(i);
          i--;
        }
      }
    }
    // 计算总价
    computeAllPrice();
    Storage.setString('cartList', json.encode(this._cartList));
    notifyListeners();
  }
}