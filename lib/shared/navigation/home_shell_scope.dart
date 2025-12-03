import 'package:flutter/material.dart';

class HomeShellScope extends InheritedWidget {
  const HomeShellScope({
    super.key,
    required this.tabNotifier,
    required this.setTab,
    required super.child,
  });

  final ValueNotifier<int> tabNotifier;
  final void Function(int index) setTab;

  static HomeShellScope? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<HomeShellScope>();
  }

  @override
  bool updateShouldNotify(covariant HomeShellScope oldWidget) {
    return oldWidget.tabNotifier != tabNotifier;
  }
}
