import 'clippers/theme_switcher_clipper_bridge.dart';
import 'clippers/theme_switcher_circle_clipper.dart';
import 'theme_provider.dart';
import 'package:flutter/material.dart';

class ThemeSwitchingArea extends StatefulWidget {
  ThemeSwitchingArea({
    Key key,
    @required this.child,
  })  : assert(child != null),
        super(key: key);

  final Widget child;

  @override
  _ThemeSwitchingAreaState createState() => _ThemeSwitchingAreaState();
}

class _ThemeSwitchingAreaState extends State<ThemeSwitchingArea>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  bool _busy = false;

  //one more key to save drawer state
  final _globalKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(_afterLayout);
  }

  void _afterLayout(_) {
    _oldTheme = ThemeProvider.of(context);
    _controller = AnimationController(
      vsync: this,
      duration: ThemeProvider.instanceOf(context).duration,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  ThemeData _oldTheme;
  Offset _switcherOffset;

  @override
  Widget build(BuildContext context) {
    var theme = ThemeProvider.of(context);
    var child;

    if (_oldTheme == null || _oldTheme == theme) {
      child = _getPage(theme);
    } else {
      var firstWidget, animWidget;

      if (ThemeProvider.instanceOf(context).reverseAnimation) {
        firstWidget = _getPage(theme);
        animWidget = RawImage(image: ThemeProvider.instanceOf(context).image);
      } else {
        firstWidget = RawImage(image: ThemeProvider.instanceOf(context).image);
        animWidget = _getPage(theme);
      }

      child = Stack(
        children: [
          firstWidget,
          AnimatedBuilder(
            animation: _controller,
            child: animWidget,
            builder: (_, child) {
              return ClipPath(
                clipper: ThemeSwitcherClipperBridge(
                  clipper: ThemeProvider.instanceOf(context).clipper ??
                      const ThemeSwitcherCircleClipper(),
                  offset: _switcherOffset,
                  sizeRate: _controller.value,
                ),
                child: child,
              );
            },
          ),
        ],
      );
    }

    return Material(child: child);
  }

  Widget _getPage(ThemeData brandTheme) {
    return Theme(
      key: _globalKey,
      data: brandTheme,
      child: widget.child,
    );
  }

  void _getSwitcherCoordinates(switcherGlobalKey) {
    RenderBox renderObject =
        switcherGlobalKey.currentContext.findRenderObject();
    final size = renderObject.size;
    _switcherOffset = renderObject
        .localToGlobal(Offset.zero)
        .translate(size.width / 2, size.height / 2);
  }

  @override
  void didUpdateWidget(Widget oldWidget) {
    super.didUpdateWidget(oldWidget);
    var theme = ThemeProvider.of(context);
    if (!_busy && theme != _oldTheme) {
      _busy = true;
      _getSwitcherCoordinates(
          ThemeProvider.instanceOf(context).switcherGlobalKey);
      _runAnimation(theme);
    }
  }

  void _runAnimation(ThemeData theme) async {
    if (ThemeProvider.instanceOf(context).reverseAnimation) {
      await _controller.reverse(from: 1.0);
    } else {
      await _controller.forward(from: 0.0);
    }

    setState(() {
      _busy = false;
      _oldTheme = theme;
    });
  }
}
