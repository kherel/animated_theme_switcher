import 'package:animated_theme_switcher/theme_provider.dart';
import 'package:flutter/material.dart';

typedef ChangeTheme = void Function(ThemeData theme);

class ThemeSwitcher extends StatefulWidget {
  const ThemeSwitcher({Key key, this.builder}) : super(key: key);

  final Widget Function(BuildContext context, ChangeTheme changeMyTheme)
      builder;

  @override
  _ThemeSwitcherState createState() => _ThemeSwitcherState();
}

class _ThemeSwitcherState extends State<ThemeSwitcher> {
  final GlobalKey globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    void changeTheme(ThemeData theme) {
      ThemeProvider.instanceOf(context).changeTheme(theme: theme, key: globalKey);
    }

    return Container(
      key: globalKey,
      child: widget.builder(context, changeTheme),
    );
  }
}
