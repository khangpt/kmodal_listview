import 'package:flutter/material.dart';

class KOptions {
  final TextStyle headerStyle;
  final String refreshingText;
  final String refreshIdleText;
  final String refreshFailureText;
  final String refreshDoneText;

  final TextStyle footerStyle;
  final String moreIdleText;
  final String moreFailureText;
  final String releaseMoreText;
  final String noMoreText;

  final Widget? loadingIcon;

  const KOptions({
    this.headerStyle = const TextStyle(fontSize: 13, color: Colors.black54),
    this.refreshingText = 'Refreshing',
    this.refreshIdleText = 'Pull to refresh',
    this.refreshDoneText = 'Refresh done',
    this.refreshFailureText = 'Refresh failure',
    this.footerStyle = const TextStyle(fontSize: 13, color: Colors.black54),
    this.moreIdleText = 'Load more',
    this.moreFailureText = 'Load more failured',
    this.releaseMoreText = 'Release to load more',
    this.noMoreText = 'No more data',
    this.loadingIcon,
  });
}
