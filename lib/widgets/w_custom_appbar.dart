import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  CustomAppBar({
    super.key,
    this.leadingWidget,
    this.titleWidget,
    this.actionWidget,
  });

  final Widget? leadingWidget;
  final Widget? titleWidget;
  final Widget? actionWidget;

  final List<Widget> widgetList = [];

  @override
  Widget build(BuildContext context) {
    if (leadingWidget != null) {
      widgetList.add(leadingWidget!);
    }

    if (titleWidget != null) {
      widgetList.add(titleWidget!);
    }

    if (actionWidget != null) {
      widgetList.add(actionWidget!);
    }

    return Container(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
      child: Row(
        mainAxisAlignment: actionWidget == null
            ? MainAxisAlignment.start
            : MainAxisAlignment.spaceBetween,
        children: widgetList,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
