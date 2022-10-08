import 'dart:async';
import 'dart:ui' as ui;

import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'clippers/theme_switcher_clipper.dart';

typedef ThemeBuilder = Widget Function(BuildContext, ThemeData theme);

class ThemeProvider extends StatefulWidget {
  const ThemeProvider({
    Key? key,
    this.builder,
    this.child,
    required this.initTheme,
    this.duration = const Duration(milliseconds: 300),
  }) : super(key: key);

  final ThemeBuilder? builder;
  final Widget? child;
  final ThemeData initTheme;
  final Duration duration;

  @override
  State<ThemeProvider> createState() => _ThemeProviderState();
}

class _ThemeProviderState extends State<ThemeProvider>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late var model;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    model = ThemeModel(
      startTheme: widget.initTheme,
      controller: _controller,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ThemeModelInheritedNotifier(
      notifier: model,
      child: Builder(builder: (context) {
        var model = ThemeModelInheritedNotifier.of(context);
        return RepaintBoundary(
          key: model.previewContainer,
          child: widget.child ?? widget.builder!(context, model.theme),
        );
      }),
    );
  }
}

class ThemeModelInheritedNotifier extends InheritedNotifier<ThemeModel> {
  const ThemeModelInheritedNotifier({
    Key? key,
    required ThemeModel notifier,
    required Widget child,
  }) : super(key: key, notifier: notifier, child: child);

  static ThemeModel of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<ThemeModelInheritedNotifier>()!
        .notifier!;
  }
}

class ThemeModel extends ChangeNotifier {
  ThemeData _theme;

  late GlobalKey switcherGlobalKey;
  ui.Image? image;
  final previewContainer = GlobalKey();

  Timer? timer;
  ThemeSwitcherClipper clipper = const ThemeSwitcherCircleClipper();
  final AnimationController controller;

  ThemeModel({
    required ThemeData startTheme,
    required this.controller,
  }) : _theme = startTheme;

  ThemeData get theme => _theme;
  ThemeData? oldTheme;

  bool isReversed = false;
  late Offset switcherOffset;

  void changeTheme({
    required ThemeData theme,
    required GlobalKey key,
    ThemeSwitcherClipper? clipper,
    required bool isReversed,
  }) async {
    if (controller.isAnimating) {
      return;
    }

    if (clipper != null) {
      this.clipper = clipper;
    }
    this.isReversed = isReversed;

    oldTheme = _theme;
    _theme = theme;
    switcherOffset = _getSwitcherCoordinates(key);
    await _saveScreenshot();

    if (isReversed) {
      await controller.reverse(from: 1.0);
    } else {
      await controller.forward(from: 0.0);
    }
  }

  Future<void> _saveScreenshot() async {
    final boundary = previewContainer.currentContext!.findRenderObject()
        as RenderRepaintBoundary;
    image = await boundary.toImage(pixelRatio: ui.window.devicePixelRatio);
    notifyListeners();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  Offset _getSwitcherCoordinates(
      GlobalKey<State<StatefulWidget>> switcherGlobalKey) {
    final renderObject =
        switcherGlobalKey.currentContext!.findRenderObject()! as RenderBox;
    final size = renderObject.size;
    return renderObject
        .localToGlobal(Offset.zero)
        .translate(size.width / 2, size.height / 2);
  }
}
