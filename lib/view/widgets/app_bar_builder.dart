import 'package:flutter/material.dart';

class AppBarBuilder extends StatelessWidget {
  final Widget leading;
  final Widget? title;
  final Widget action;
  const AppBarBuilder({Key? key, required this.leading, this.title, required this.action}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        leading,
        const Spacer(),
        title ?? const Text(""),
        const Spacer(),
        action,
      ],
    );
  }
}
