import 'circle_clipper.dart';
import 'theme_provider.dart';
import 'package:flutter/material.dart';

GlobalKey switherGlobalKey = GlobalKey();

class ThemeSwitchingArea extends StatefulWidget {
  ThemeSwitchingArea({
    Key key,
    @required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  _ThemeSwitchingAreaState createState() =>
      _ThemeSwitchingAreaState();
}

class _ThemeSwitchingAreaState extends State<ThemeSwitchingArea>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(_afterLayout);

    super.initState();
  }

  void _afterLayout(_) {
    oldTheme = ThemeProvider.of(context);
    _controller = AnimationController(
      vsync: this,
      duration: ThemeProvider.instanceOf(context).duration,
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  ThemeData oldTheme;
  Offset switcherOffset;

  @override
  Widget build(BuildContext context) {
    var brandTheme = ThemeProvider.of(context);

    if (oldTheme == null || oldTheme == brandTheme) {
      return _getPage(brandTheme);
    }
    return Material(
      child: Stack(
        children: <Widget>[
          _getPage(
            oldTheme,
          ),
          AnimatedBuilder(
            animation: _controller,
            child: _getPage(brandTheme),
            builder: (_, child) {
              return ClipPath(
                clipper: CircleClipper(
                  sizeRate: _controller.value,
                  offset: switcherOffset,
                ),
                child: child,
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _getPage(ThemeData brandTheme) {
    return Theme(
      data: brandTheme,
      child: widget.child,
    );
  }

  void _getSwitcherCoodinates(switherGlobalKey) {
    RenderBox renderObject = switherGlobalKey.currentContext.findRenderObject();
    final size = renderObject.size;
    switcherOffset = renderObject
        .localToGlobal(Offset.zero)
        .translate(size.width / 2, size.height / 2);
  }

  @override
  void didUpdateWidget(Widget oldWidget) {
    var theme = ThemeProvider.of(context);
    if (theme != oldTheme) {
      _getSwitcherCoodinates(ThemeProvider.instanceOf(context).switherGlobalKey);
      _controller.reset();
      _controller.forward().then(
        (_) {
          oldTheme = theme;
        },
      );
    }
    super.didUpdateWidget(oldWidget);
  }
}
