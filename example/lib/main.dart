import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;

import 'theme_config.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isPlatformDark = WidgetsBinding.instance.window.platformBrightness == Brightness.dark;
    final initTheme = isPlatformDark ? darkTheme : lightTheme;
    return ThemeProvider(
      initTheme: initTheme,
      child: Builder(builder: (context) {
        return MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeProvider.of(context),
          home: MyHomePage(),
        );
      }),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

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
                  child: ThemeSwitcher(
                    builder: (context) {
                      return IconButton(
                        onPressed: () {
                          ThemeSwitcher.of(context).changeTheme(
                            theme: ThemeProvider.of(context).brightness == Brightness.light
                                ? darkTheme
                                : lightTheme,
                          );
                        },
                        icon: Icon(Icons.brightness_3, size: 25),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        appBar: AppBar(
          title: Text(
            'Flutter Demo Home Page',
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text(
                'You have pushed the button this many times:',
              ),
              Text(
                '$_counter',
                style: TextStyle(fontSize: 200),
              ),
              CheckboxListTile(
                title: Text('Slow Animation'),
                value: timeDilation == 5.0,
                onChanged: (value) {
                  setState(() {
                    timeDilation = value ? 5.0 : 1.0;
                  });
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  ThemeSwitcher(
                    clipper: ThemeSwitcherBoxClipper(),
                    builder: (context) {
                      return OutlinedButton(
                        child: Text('Box Animation'),
                        onPressed: () {
                          ThemeSwitcher.of(context).changeTheme(
                            theme: ThemeProvider.of(context).brightness == Brightness.light
                                ? darkTheme
                                : lightTheme,
                          );
                        },
                      );
                    },
                  ),
                  ThemeSwitcher(
                    clipper: ThemeSwitcherCircleClipper(),
                    builder: (context) {
                      return OutlinedButton(
                        child: Text('Circle Animation'),
                        onPressed: () {
                          ThemeSwitcher.of(context).changeTheme(
                            theme: ThemeProvider.of(context).brightness == Brightness.light
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
                    clipper: ThemeSwitcherBoxClipper(),
                    builder: (context) {
                      return OutlinedButton(
                        child: Text('Box (Reverse)'),
                        onPressed: () {
                          var brightness = ThemeProvider.of(context).brightness;
                          ThemeSwitcher.of(context).changeTheme(
                            theme: brightness == Brightness.light ? darkTheme : lightTheme,
                            reverseAnimation: brightness == Brightness.dark ? true : false,
                          );
                        },
                      );
                    },
                  ),
                  ThemeSwitcher(
                    clipper: ThemeSwitcherCircleClipper(),
                    builder: (context) {
                      return OutlinedButton(
                        child: Text('Circle (Reverse)'),
                        onPressed: () {
                          var brightness = ThemeProvider.of(context).brightness;
                          ThemeSwitcher.of(context).changeTheme(
                            theme: brightness == Brightness.light ? darkTheme : lightTheme,
                            reverseAnimation: brightness == Brightness.dark ? true : false,
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
                        value: ThemeProvider.of(context) == pinkTheme,
                        onChanged: (needPink) {
                          ThemeSwitcher.of(context).changeTheme(
                            theme: needPink ? pinkTheme : lightTheme,
                          );
                        },
                      );
                    },
                  ),
                  ThemeSwitcher(
                    builder: (context) {
                      return Checkbox(
                        value: ThemeProvider.of(context) == darkBlueTheme,
                        onChanged: (needDarkBlue) {
                          ThemeSwitcher.of(context).changeTheme(
                            theme: needDarkBlue ? darkBlueTheme : lightTheme,
                          );
                        },
                      );
                    },
                  ),
                  ThemeSwitcher(
                    builder: (context) {
                      return Checkbox(
                        value: ThemeProvider.of(context) == halloweenTheme,
                        onChanged: (needBlue) {
                          ThemeSwitcher.of(context).changeTheme(
                            theme: needBlue ? halloweenTheme : lightTheme,
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
          child: Icon(
            Icons.add,
          ),
        ),
      ),
    );
  }
}
