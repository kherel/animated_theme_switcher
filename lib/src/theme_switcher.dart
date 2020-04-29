import 'package:animated_theme_switcher/animated_theme_switcher.dart';

import 'clippers/theme_switcher_clipper.dart';
import 'theme_provider.dart';
import 'package:flutter/material.dart';

typedef ChangeTheme = void Function(ThemeData theme);

class ThemeSwitcher extends StatefulWidget {
  const ThemeSwitcher({
    Key key,
    this.clipper = const ThemeSwitcherCircleClipper(),
    @required this.builder,
  })  : assert(builder != null),
        assert(clipper != null),
        super(key: key);

  final Widget Function(BuildContext) builder;
  final ThemeSwitcherClipper clipper;

  @override
  ThemeSwitcherState createState() => ThemeSwitcherState();

  static ThemeSwitcherState of(BuildContext context) {
    final inherited =
        context.dependOnInheritedWidgetOfExactType<_InheritedThemeSwitcher>();
    return inherited.data;
  }
}

class ThemeSwitcherState extends State<ThemeSwitcher> {
  final GlobalKey _globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return _InheritedThemeSwitcher(
      data: this,
      child: Builder(
        key: _globalKey,
        builder: widget.builder,
      ),
    );
  }

  void changeTheme({ThemeData theme}) {
    ThemeProvider.instanceOf(context).changeTheme(
      theme: theme,
      key: _globalKey,
      clipper: widget.clipper,
    );
  }
}

class _InheritedThemeSwitcher extends InheritedWidget {
  final ThemeSwitcherState data;

  _InheritedThemeSwitcher({
    this.data,
    Key key,
    @required Widget child,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(_InheritedThemeSwitcher oldWidget) {
    return true;
  }
}
