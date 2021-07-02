import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kmodal_listview/klistview/kmodal.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

enum KScreenType { LOADING, LIST, EMPTY }

class KListController extends GetxController {
  factory KListController.get({String? theKey}) =>
      Get.find<KListController>(tag: theKey);

  KListController({@required KModal<dynamic>? model}) : _model = model;

  @override
  void onInit() {
    super.onInit();
    refresher = RefreshController(initialRefresh: false);
  }

  @override
  void onReady() {
    super.onReady();

    /// firsttime load
    initialLoad();
  }

  @override
  void onClose() {
    super.onClose();
    refresher.dispose();
  }

  ///=========================================
  /// model for this controller
  KModal<dynamic>? _model;

  ///=========================================
  /// contain all datas for list
  final datasource = <dynamic>[].obs;
  dynamic itemAt(int index) =>
      index >= 0 && index < datasource.length ? datasource[index] : null;

  /// indicate the current page of model
  final currentPage = 1.obs;

  /// the list state handler
  late RefreshController refresher;

  /// indicate there is an request is being running
  bool _isLoading = false;

  /// state of screen in list
  final screenType = KScreenType.LOADING.obs;

  /// update an value contained inside datasource
  void updateItemDatasource(bool Function(dynamic e) satisfied,
      {ValueChanged<dynamic>? updated}) {
    try {
      final item = datasource.firstWhere(satisfied);
      updated?.call(item);
      datasource.refresh();
    } on StateError catch (error) {
      print('updateItemDatasource:StateError: ${error.message}');
    }
  }

  ///=========================================
  /// load data at first (or refreshing scenarios)
  void initialLoad() async {
    if (!_isLoading) {
      _isLoading = true;

      /// change state of screen to LOADING
      screenType.value = KScreenType.LOADING;

      /// request data
      final result = await _model!.request(page: 1);

      if (result != null) {
        if (result.length > 0) {
          datasource.clear();
          datasource.addAll(result);
          currentPage.value = 1;
          screenType.value = KScreenType.LIST;
        } else {
          screenType.value = KScreenType.EMPTY;
        }
      } else {
        screenType.value = KScreenType.EMPTY;
      }

      /// reset state of loading
      _isLoading = false;
    }
  }

  /// when user pull list to refresh list of data
  void refreshList() async {
    if (!_isLoading) {
      _isLoading = true;

      /// request data from network
      final result = await _model!.request(page: 1);

      if (result != null) {
        if (result.length > 0) {
          datasource.clear();
          datasource.addAll(result);
          currentPage.value = 1;
        }

        refresher.refreshCompleted(resetFooterState: true);
      } else {
        refresher.refreshFailed();
      }

      /// reset loading state
      _isLoading = false;
    }
  }

  /// when user scroll to load more data into list
  void loadMore({int page = 1}) async {
    if (!_isLoading) {
      _isLoading = true;

      /// request from network
      final result = await _model!.request(page: page);

      datasource.addAll(result ?? []);

      if (result != null) {
        /// update current page value & notify to update UI (observable)
        currentPage.value = page;

        if (result.length > 0) {
          refresher.loadComplete();
        } else {
          refresher.loadNoData();
        }
      } else {
        refresher.loadFailed();
      }

      /// reset loading state
      _isLoading = false;
    }
  }
}
