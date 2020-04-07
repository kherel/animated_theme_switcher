import 'dart:async';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ThemeProvider extends StatefulWidget {
  ThemeProvider({
    this.initTheme,
    Key key,
    @required this.child,
    this.duration = const Duration(milliseconds: 300),
  })  : assert(duration != null),
        super(key: key);

  final Widget child;
  final ThemeData initTheme;
  final Duration duration;

  @override
  ThemeProviderState createState() => ThemeProviderState();

  static ThemeData of(BuildContext context) {
    final inherited =
        context.dependOnInheritedWidgetOfExactType<_InheritedThemeProvider>();
    return inherited.data.theme;
  }

  static ThemeProviderState instanceOf(BuildContext context) {
    final inherited =
        context.dependOnInheritedWidgetOfExactType<_InheritedThemeProvider>();
    return inherited.data;
  }
}

class ThemeProviderState extends State<ThemeProvider> {
  ThemeData theme;
  GlobalKey switcherGlobalKey;
  bool isBusy = false;
  ui.Image image;

  Duration get duration => widget.duration;

  final _previewContainer = GlobalKey();

  @override
  void initState() {
    super.initState();
    theme = widget.initTheme;
  }

  Future<void> _saveScreenshot() async {
    RenderRepaintBoundary boundary =
        _previewContainer.currentContext.findRenderObject();
    image = await boundary.toImage();
  }

  void changeTheme({ThemeData theme, GlobalKey key}) async {
    if (isBusy) {
      return;
    }

    await _saveScreenshot();

    setState(() {
      isBusy = true;
      this.theme = theme;
      switcherGlobalKey = key;
    });

    Timer(duration, () {
      isBusy = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _InheritedThemeProvider(
      data: this,
      child: RepaintBoundary(
        child: widget.child,
        key: _previewContainer,
      ),
    );
  }
}

class _InheritedThemeProvider extends InheritedWidget {
  final ThemeProviderState data;

  _InheritedThemeProvider({
    this.data,
    Key key,
    @required Widget child,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(_InheritedThemeProvider oldWidget) {
    return true;
  }
}
