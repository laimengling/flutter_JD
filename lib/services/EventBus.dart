import 'package:event_bus/event_bus.dart';

EventBus eventBus =new EventBus();

class ProductContentEvent{
  String str;

  ProductContentEvent(String str) {
    this.str = str;
  }
}

class UserEvent{
  String str;

  UserEvent(String str) {
    this.str = str;
  }
}