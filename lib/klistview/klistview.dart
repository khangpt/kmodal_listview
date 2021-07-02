import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kmodal_listview/cute_listview/cute_listview.dart';
import 'package:kmodal_listview/klistview/controller/klistcontroller.dart';
import 'package:kmodal_listview/klistview/kmodal.dart';
import 'package:kmodal_listview/klistview/koptions.dart';

class KListView<T> extends StatelessWidget {
  final KModal<T>? model;
  final KOptions options;

  KListView({
    @required this.model,
    this.options = const KOptions(),
    Key? key,
  }) : super(key: key) {
    Get.lazyPut<KListController>(() => KListController(model: model),
        tag: model!.getKey);
  }

  _onRefresh() {
    model!.controller.refreshList();
  }

  _onLoadMore() {
    model!.controller.loadMore(page: model!.controller.currentPage.value + 1);
  }

  _onRetry() {
    model!.controller.initialLoad();
  }

  @override
  Widget build(BuildContext context) {
    /// validating the screen state
    return Obx(() {
      switch (model!.controller.screenType.value) {
        case KScreenType.LIST:
          return Obx(
            () => CuteListView(
              options: options,
              refreshController: model!.controller.refresher,
              onRefresh: _onRefresh,
              onLoadmore: _onLoadMore,
              itemCount: model!.controller.datasource.length,
              itemBuilder: (ctx, index) {
                final itemAt = model!.controller.itemAt(index);
                return model!.listItem(data: itemAt);
              },
            ),
          );
        case KScreenType.EMPTY:
          return model!.empty(retryFunction: _onRetry);
        case KScreenType.LOADING:
        default:
          return model!.loading();
      }
    });
  }
}
