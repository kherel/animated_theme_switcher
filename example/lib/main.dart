import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;

import 'theme_config.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isPlatformDark =
        WidgetsBinding.instance!.window.platformBrightness == Brightness.dark;
    final initTheme = isPlatformDark ? darkTheme : lightTheme;
    return ThemeProvider(
      initTheme: initTheme,
      builder: (_, myTheme) {
        return MaterialApp(
          title: 'Flutter Demo',
          theme: myTheme,
          home: const MyHomePage(),
        );
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ThemeSwitchingArea(
      child: Scaffold(
        drawer: Drawer(
          child: SafeArea(
            child: Stack(
              children: <Widget>[
                Align(
                  alignment: Alignment.topRight,
                  child: ThemeSwitcher.withTheme(
                    builder: (_, switcher, theme) {
                      return IconButton(
                        onPressed: () => switcher.changeTheme(
                          theme: theme.brightness == Brightness.light
                              ? darkTheme
                              : lightTheme,
                        ),
                        icon: const Icon(Icons.brightness_3, size: 25),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        appBar: AppBar(
          title: const Text(
            'Flutter Demo Home Page',
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              const Text(
                'You have pushed the button this many times:',
              ),
              Text(
                '$_counter',
                style: const TextStyle(fontSize: 200),
              ),
              CheckboxListTile(
                title: const Text('Slow Animation'),
                value: timeDilation == 5.0,
                onChanged: (value) {
                  setState(() {
                    timeDilation = value != null && value ? 5.0 : 1.0;
                  });
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  ThemeSwitcher.switcher(
                    clipper: const ThemeSwitcherBoxClipper(),
                    builder: (context, switcher) {
                      return OutlinedButton(
                        child: const Text('Box Animation'),
                        onPressed: () {
                          switcher.changeTheme(
                            theme: ThemeModelInheritedNotifier.of(context)
                                        .theme
                                        .brightness ==
                                    Brightness.light
                                ? darkTheme
                                : lightTheme,
                          );
                        },
                      );
                    },
                  ),
                  ThemeSwitcher(
                    clipper: const ThemeSwitcherCircleClipper(),
                    builder: (context) {
                      return OutlinedButton(
                        child: const Text('Circle Animation'),
                        onPressed: () {
                          ThemeSwitcher.of(context).changeTheme(
                            theme: ThemeModelInheritedNotifier.of(context)
                                        .theme
                                        .brightness ==
                                    Brightness.light
                                ? darkTheme
                                : lightTheme,
                          );
                        },
                      );
                    },
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  ThemeSwitcher(
                    clipper: const ThemeSwitcherBoxClipper(),
                    builder: (context) {
                      return OutlinedButton(
                        child: const Text('Box (Reverse)'),
                        onPressed: () {
                          var brightness =
                              ThemeModelInheritedNotifier.of(context)
                                  .theme
                                  .brightness;
                          ThemeSwitcher.of(context).changeTheme(
                            theme: brightness == Brightness.light
                                ? darkTheme
                                : lightTheme,
                            isReversed:
                                brightness == Brightness.dark ? true : false,
                          );
                        },
                      );
                    },
                  ),
                  ThemeSwitcher(
                    clipper: const ThemeSwitcherCircleClipper(),
                    builder: (context) {
                      return OutlinedButton(
                        child: const Text('Circle (Reverse)'),
                        onPressed: () {
                          var brightness =
                              ThemeModelInheritedNotifier.of(context)
                                  .theme
                                  .brightness;
                          ThemeSwitcher.of(context).changeTheme(
                            theme: brightness == Brightness.light
                                ? darkTheme
                                : lightTheme,
                            isReversed:
                                brightness == Brightness.dark ? true : false,
                          );
                        },
                      );
                    },
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ThemeSwitcher(
                    builder: (context) {
                      return Checkbox(
                        value: ThemeModelInheritedNotifier.of(context).theme ==
                            pinkTheme,
                        onChanged: (needPink) {
                          ThemeSwitcher.of(context).changeTheme(
                            theme: needPink != null && needPink
                                ? pinkTheme
                                : lightTheme,
                          );
                        },
                      );
                    },
                  ),
                  ThemeSwitcher(
                    builder: (context) {
                      return Checkbox(
                        value: ThemeModelInheritedNotifier.of(context).theme ==
                            darkBlueTheme,
                        onChanged: (needDarkBlue) {
                          ThemeSwitcher.of(context).changeTheme(
                            theme: needDarkBlue != null && needDarkBlue
                                ? darkBlueTheme
                                : lightTheme,
                          );
                        },
                      );
                    },
                  ),
                  ThemeSwitcher(
                    builder: (context) {
                      return Checkbox(
                        value: ThemeModelInheritedNotifier.of(context).theme ==
                            halloweenTheme,
                        onChanged: (needBlue) {
                          ThemeSwitcher.of(context).changeTheme(
                            theme: needBlue != null && needBlue
                                ? halloweenTheme
                                : lightTheme,
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _incrementCounter,
          tooltip: 'Increment',
          child: const Icon(
            Icons.add,
          ),
        ),
      ),
    );
  }
}
