import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';

import 'theme_config.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isPlatformDark =
        WidgetsBinding.instance.window.platformBrightness == Brightness.dark;
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
      child: Builder(builder: (context) {
        return Scaffold(
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
                ThemeSwitcher(
                  builder: (_, changeTheme) {
                    return Switch(
               
                      onChanged: (needDark) {
                        changeTheme(
                          needDark ? darkTheme : lightTheme,
                        );
                      },
                      value: ThemeProvider.of(context) == darkTheme,
                    );
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ThemeSwitcher(
                      builder: (context, changeTheme) {
                        return Checkbox(
                          value: ThemeProvider.of(context) == pinkTheme,
                          onChanged: (needPink) {
                            changeTheme(
                              needPink ? pinkTheme : lightTheme,
                            );
                          },
                        );
                      },
                    ),
                    ThemeSwitcher(
                      builder: (context, changeTheme) {
                        return Checkbox(
                          value: ThemeProvider.of(context) == darkBlueTheme,
                          onChanged: (needDarkBlue) {
                            changeTheme(
                              needDarkBlue ? darkBlueTheme : lightTheme,
                            );
                          },
                        );
                      },
                    ),
                    ThemeSwitcher(
                      builder: (context, changeTheme) {
                        return Checkbox(
                          value: ThemeProvider.of(context) == halloweenTheme,
                          onChanged: (needBlue) {
                            changeTheme(
                              needBlue ? halloweenTheme : lightTheme,
                            );
                          },
                        );
                      },
                    ),
                  ],
                )
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
        );
      }),
    );
  }
}
