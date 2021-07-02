import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

/// listview with refresh and loadmore widget
class CuteListView extends StatelessWidget {
  final RefreshController? refreshController;
  final VoidCallback? onRefresh;
  final VoidCallback? onLoadmore;
  final EdgeInsets? padding;
  final int? itemCount;
  final IndexedWidgetBuilder? itemBuilder;
  final TextStyle textStyle;
  final String loadMoreText;
  final String loadMoreFailureText;
  final String releaseToLoadMoreText;
  final String noMoreText;

  CuteListView({
    @required this.refreshController,
    @required this.itemCount,
    @required this.itemBuilder,
    this.padding,
    this.textStyle = const TextStyle(fontSize: 13, color: Colors.black87),
    this.loadMoreText = 'Load more',
    this.loadMoreFailureText = 'Load more failured',
    this.releaseToLoadMoreText = 'Release to load more',
    this.noMoreText = 'No more data',
    this.onRefresh,
    this.onLoadmore,
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
        header: ClassicHeader(),
        footer: CustomFooter(
          builder: (_, mode) {
            Widget body;
            if (mode == LoadStatus.idle) {
              body = Text(loadMoreText, style: textStyle);
            } else if (mode == LoadStatus.loading) {
              body = CircularProgressIndicator(color: Colors.amber.shade300);
            } else if (mode == LoadStatus.failed) {
              body = Text(loadMoreFailureText, style: textStyle);
            } else if (mode == LoadStatus.canLoading) {
              body = Text(releaseToLoadMoreText, style: textStyle);
            } else {
              body = Text(noMoreText, style: textStyle);
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
