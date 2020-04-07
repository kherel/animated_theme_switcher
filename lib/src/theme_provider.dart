import 'dart:async';

import 'package:flutter/material.dart';


class ThemeProvider extends StatefulWidget {
  final Widget child;

  ThemeProvider({
    this.initTheme,
    Key key,
    @required this.child,
    Duration duration,
  })  : duration = duration ?? Duration(milliseconds: 300),
        super(key: key);

  final ThemeData initTheme;
  final Duration duration;

  @override
  ThemeProviderState createState() => ThemeProviderState();

  static ThemeData of (BuildContext context) {
    final inherited =
        (context.dependOnInheritedWidgetOfExactType<_InheritedBrandTheme>());
    return inherited.data.brandTheme;
  }

  static ThemeProviderState instanceOf(BuildContext context) {
    final inherited =
        (context.dependOnInheritedWidgetOfExactType<_InheritedBrandTheme>());
    return inherited.data;
  }
}

class ThemeProviderState extends State<ThemeProvider> {
  ThemeData _brandTheme;

  ThemeData get brandTheme => _brandTheme;

  @override
  void initState() {
    _brandTheme = widget.initTheme;
    duration = widget.duration;
    super.initState();
  }

  GlobalKey switherGlobalKey;
  Duration duration;
  bool isBusy = false;

  void changeTheme({ThemeData theme, GlobalKey key}) {
    if (isBusy) {
      return;
    }
    setState(() {
      isBusy = true;
      _brandTheme = theme;
      switherGlobalKey = key;
    });

    Timer(widget.duration, () {
      isBusy = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _InheritedBrandTheme(
      data: this,
      child: widget.child,
    );
  }
}

class _InheritedBrandTheme extends InheritedWidget {
  final ThemeProviderState data;

  _InheritedBrandTheme({
    this.data,
    Key key,
    @required Widget child,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(_InheritedBrandTheme oldWidget) {
    return true;
  }
}
