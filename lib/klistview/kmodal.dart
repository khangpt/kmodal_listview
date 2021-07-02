import 'package:flutter/material.dart';
import 'package:kmodal_listview/klistview/controller/klistcontroller.dart';

abstract class KModal<T> {
  /// controller of model
  KListController get controller => KListController.get(theKey: getKey);

  ///=========================================
  /// the unique key to be found by Get (other name is tag)
  String? get getKey;

  /// start request data from internet
  Future<List<T>?> request({int page = 1});

  /// build an list item widget
  Widget listItem({T? data});

  /// build an loading widget to show at first time enter
  Widget loading();

  /// build an empty widget when datasource is empty. Consider to adapt [retryFunction] into your widget
  Widget empty({VoidCallback? retryFunction});
}
