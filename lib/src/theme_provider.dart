import 'package:flutter/material.dart';

import 'models/theme_model.dart';
import 'theme_notifier.dart';

typedef ThemeBuilder = Widget Function(
    BuildContext, ThemeNotifier themeNotifier);

class ThemeProvider extends StatefulWidget {
  const ThemeProvider({
    Key? key,
    this.builder,
    this.child,
    required this.themeModel,
    this.duration = const Duration(milliseconds: 300),
  }) : super(key: key);

  final ThemeBuilder? builder;
  final Widget? child;
  final ThemeModel themeModel;
  final Duration duration;

  @override
  State<ThemeProvider> createState() => _ThemeProviderState();
}

class _ThemeProviderState extends State<ThemeProvider>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late ThemeNotifier themeNotifier;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    themeNotifier =
        ThemeNotifier(themeModel: widget.themeModel, controller: _controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    themeNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    assert(widget.builder != null || widget.child != null,
        'builder or child must be provided');
    return ThemeModelInheritedNotifier(
      notifier: themeNotifier,
      child: Builder(builder: (context) {
        final themeNotifier = ThemeModelInheritedNotifier.of(context);
        return RepaintBoundary(
          key: themeNotifier.containerKey,
          child: widget.child ?? widget.builder!(context, themeNotifier),
        );
      }),
    );
  }
}

class ThemeModelInheritedNotifier extends InheritedNotifier<ThemeNotifier> {
  const ThemeModelInheritedNotifier({
    Key? key,
    required ThemeNotifier notifier,
    required Widget child,
  }) : super(key: key, notifier: notifier, child: child);

  static ThemeNotifier of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<ThemeModelInheritedNotifier>()!
        .notifier!;
  }
}
