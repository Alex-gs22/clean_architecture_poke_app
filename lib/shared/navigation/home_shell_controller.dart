import 'package:flutter/material.dart';

/// Holds a reference to the shell tab setter so routes outside the shell
/// (like detail pages) can request a tab change without recreating state.
class HomeShellController {
  HomeShellController._();
  static final HomeShellController instance = HomeShellController._();

  void Function(int index)? _setTab;

  void register(void Function(int index) setter) {
    _setTab = setter;
  }

  void unregister() {
    _setTab = null;
  }

  void setTab(int index) {
    _setTab?.call(index);
  }
}
