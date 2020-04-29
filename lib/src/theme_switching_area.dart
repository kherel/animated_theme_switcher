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
    _controller.forward();
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
    var children = <Widget>[];
    if (_oldTheme == null || _oldTheme == theme) {
      children.add(_getPage(theme));
    } else {
      children.addAll([
        RawImage(image: ThemeProvider.instanceOf(context).image),
        AnimatedBuilder(
          animation: _controller,
          child: _getPage(theme),
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
        )
      ]);
    }
    return Material(
      child: Stack(
        children: children,
      ),
    );
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
    var theme = ThemeProvider.of(context);
    if (!_busy && theme != _oldTheme) {
      _busy = true;
      _getSwitcherCoordinates(
          ThemeProvider.instanceOf(context).switcherGlobalKey);
      _controller.reset();
      _controller.forward().then(
        (_) {
          _busy = false;
          _oldTheme = theme;
        },
      );
    }
    super.didUpdateWidget(oldWidget);
  }
}
