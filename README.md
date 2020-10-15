# flutter_jdshop

A new Flutter application.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

## 暂存bug
1. 点击商品，进入详情页，第一秒时页面报错，控制台报错`RangeError (index): Invalid value: Valid value range is empty: 0`,隔几秒后恢复正常
2. 点击新增收货地址，点击返回收货地址列表，报错
```
E/flutter ( 4280): [ERROR:flutter/lib/ui/ui_dart_state.cc(157)] Unhandled Exception: setState() called after dispose(): _AddressListState#ff9db(lifecycle state: defunct, not mounted)
E/flutter ( 4280): This error happens if you call setState() on a State object for a widget that no longer appears in the widget tree (e.g., whose parent widget no longer includes the widget in its build). This error can occur when code calls setState() from a timer or an animation callback.
E/flutter ( 4280): The preferred solution is to cancel the timer or stop listening to the animation in the dispose() callback. Another solution is to check the "mounted" property of this object before calling setState() to ensure the object is still in the tree.
E/flutter ( 4280): This error might indicate a memory leak if setState() is being called because another object is retaining a reference to this State object after it has been removed from the tree. To avoid memory leaks, consider breaking the reference to this object during dispose().
E/flutter ( 4280): #0      State.setState.<anonymous closure> (package:flutter/src/widgets/framework.dart:1197:9)
E/flutter ( 4280): #1      State.setState (package:flutter/src/widgets/framework.dart:1232:6)
E/flutter ( 4280): #2      _AddressListState._getAddressList (package:flutter_jdshop/pages/Address/AddressList.dart:40:5)
E/flutter ( 4280): <asynchronous suspension>
E/flutter ( 4280): #3      _AddressListState.initState.<anonymous closure> (package:flutter_jdshop/pages/Address/AddressList.dart:24:12)
```
  暂未找到解决方案，但能运行。