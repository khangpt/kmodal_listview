import 'package:flutter/material.dart';
import 'package:kmodal_listview/kmodal_listview.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

/// listview with refresh and loadmore widget
class CuteListView extends StatelessWidget {
  final RefreshController? refreshController;
  final VoidCallback? onRefresh;
  final VoidCallback? onLoadmore;
  final EdgeInsets? padding;
  final int? itemCount;
  final IndexedWidgetBuilder? itemBuilder;
  final KOptions options;

  CuteListView({
    @required this.refreshController,
    @required this.itemCount,
    @required this.itemBuilder,
    this.padding,
    this.onRefresh,
    this.onLoadmore,
    this.options = const KOptions(),
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      thickness: 3,
      radius: const Radius.circular(10),
      child: SmartRefresher(
        controller: refreshController!,
        enablePullDown: true,
        enablePullUp: true,
        onRefresh: onRefresh,
        onLoading: onLoadmore,
        header: ClassicHeader(
          textStyle: options.headerStyle,
          refreshingText: options.refreshingText,
          idleText: options.refreshIdleText,
          failedText: options.refreshFailureText,
          completeText: options.refreshDoneText,
          refreshingIcon: options.loadingIcon,
        ),
        footer: CustomFooter(
          builder: (_, mode) {
            Widget body;
            if (mode == LoadStatus.idle) {
              body = Text(options.moreIdleText, style: options.footerStyle);
            } else if (mode == LoadStatus.loading) {
              body = options.loadingIcon ??
                  Container(
                      width: 30,
                      height: 30,
                      child: CircularProgressIndicator(
                          color: Theme.of(context).primaryColor));
            } else if (mode == LoadStatus.failed) {
              body = Text(options.moreFailureText, style: options.footerStyle);
            } else if (mode == LoadStatus.canLoading) {
              body = Text(options.releaseMoreText, style: options.footerStyle);
            } else {
              body = Text(options.noMoreText, style: options.footerStyle);
            }
            return Container(
              height: 50,
              child: Center(child: body),
            );
          },
        ),
        child: ListView.builder(
          padding: padding,
          itemCount: itemCount,
          itemBuilder: itemBuilder!,
        ),
      ),
    );
  }
}
