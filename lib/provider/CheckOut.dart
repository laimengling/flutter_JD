import 'package:flutter/material.dart';

class CheckOut with ChangeNotifier{
  List _checkOutList = [];

  get checkOutList => this._checkOutList;

  changeCheckOutListData(data) {
    this._checkOutList = data;
    notifyListeners();
  }

}