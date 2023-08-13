import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RefreshWidget {
  final Future<void> Function() onRefresh;
  final Widget child;
  const RefreshWidget({
    Key? key,
    required this.onRefresh,
    required this.child,
  });

  Widget buildAndroid(BuildContext context) => RefreshIndicator(
        color: Theme.of(context).primaryColor,
        backgroundColor: Colors.grey,
        onRefresh: onRefresh,
        child: child,
      );
}
