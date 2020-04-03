import 'package:flutter/material.dart';
import 'brand_themes.dart';
import 'brand_theme_model.dart';

class BrandTheme extends StatefulWidget {
  final Widget child;

  BrandTheme({
    Key key,
    @required this.child,
  }) : super(key: key);

  @override
  BrandThemeState createState() => BrandThemeState();

  static BrandThemeModel of(BuildContext context) {
    final inherited =
        (context.dependOnInheritedWidgetOfExactType<_InheritedBrandTheme>());
    return inherited.data.brandTheme;
  }

  static BrandThemeState instanceOf(BuildContext context) {
    final inherited =
        (context.dependOnInheritedWidgetOfExactType<_InheritedBrandTheme>());
    return inherited.data;
  }
}

class BrandThemeState extends State<BrandTheme> {
  BrandThemeModel _brandTheme;

  BrandThemeModel get brandTheme => _brandTheme;

  @override
  void initState() {
    final isPlatformDark =
        WidgetsBinding.instance.window.platformBrightness == Brightness.dark;
    final themeKey = isPlatformDark ? BrandThemeKey.dark : BrandThemeKey.light;
    _brandTheme = BrandThemes.getThemeFromKey(themeKey);
    super.initState();
  }

  void changeTheme(BrandThemeKey themeKey) {
    setState(() {
      _brandTheme = BrandThemes.getThemeFromKey(themeKey);
    });
  }

  @override
  Widget build(BuildContext context) {
    // This is a bit tricky, but very common technik though
    // we are passing whole widget.
    // it will have 2 methods
    // BrandTheme.of(context) - to get the theme data
    // BrandTheme.instanceOf(context) - to get the BrandThemeState,
    // where we can call changeTheme method
    return _InheritedBrandTheme(
      data: this,
      child: widget.child,
    );
  }
}

// We are using inhereted widget to pass data through the content 
// if you not familiar with it start here:
// https://api.flutter.dev/flutter/widgets/InheritedWidget-class.html

class _InheritedBrandTheme extends InheritedWidget {
  final BrandThemeState data;

  _InheritedBrandTheme({
    this.data,
    Key key,
    @required Widget child,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(_InheritedBrandTheme oldWidget) {
    // It will refresh all widget tree with theme change.
    return true;
  }
}
