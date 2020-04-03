import 'package:animated_theme_switcher_example/circle_clipper.dart';
import 'package:flutter/material.dart';
import 'brand_theme.dart';
import 'brand_theme_model.dart';
import 'brand_theme_model.dart';
import 'brand_themes.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BrandTheme(
      child: Builder(builder: (context) {
        return MaterialApp(
          title: 'Flutter Demo',
          theme: BrandTheme.of(context).themeData,
          home: MyHomePage(),
        );
      }),
    );
  }
}

GlobalKey switherGlobalKey = GlobalKey();

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  int _counter = 0;
  BrandThemeModel oldTheme;
  Offset switcherOffset;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    var brandTheme = BrandTheme.of(context);

    // How we main animation works:
    // we have a stack with 2 widgets, they are the same
    // but they are using 2 different themes
    // A front widget is using new theme
    // a back widget is using old theme
    // we have animation that change a clipper
    // The clipper clips the front widget with a path
    // The path has a shape of circle
    // When animation is over, we remove the back widget.

    if (oldTheme == null) {
      return _getPage(brandTheme, isFirst: true);
    }
    return Stack(
      children: <Widget>[
        _getPage(oldTheme),
        AnimatedBuilder(
          animation: _controller,
          child: _getPage(brandTheme, isFirst: true),
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
    );
  }

  Widget _getPage(BrandThemeModel brandTheme, {isFirst = false}) {
    // The isFirst bool needed to not use one global key twice
    // The global key need to find the size and coordinates of the switcher
    // this need to center circle path at the right place.
    return Theme(
      data: brandTheme.themeData,
      child: Scaffold(
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
              Switch(
                key: isFirst ? switherGlobalKey : null,
                onChanged: (needDark) {
                  oldTheme = brandTheme;
                  BrandTheme.instanceOf(context).changeTheme(
                    needDark ? BrandThemeKey.dark : BrandThemeKey.light,
                  );
                },
                value: BrandTheme.of(context).brightness == Brightness.dark,
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
      ),
    );
  }

  void _getSwitcherCoodinates() {
    // this is how we find coordinates and size of the switcher
    RenderBox renderObject = switherGlobalKey.currentContext.findRenderObject();
    final size = renderObject.size;
    switcherOffset = renderObject
        .localToGlobal(Offset.zero)
        .translate(size.width / 2, size.height / 2);
  }

  @override
  void didUpdateWidget(Widget oldWidget) {
    // didUpdateWidget - is lifescile that trigers after widget update with
    // new data from parents
    // in our case it would be new brandtheme in app context
    var theme = BrandTheme.of(context);
    if (theme != oldTheme) {
      // if the have oldTheme it means we need to run animation

      _getSwitcherCoodinates();
      _controller.reset();
      _controller.forward().then(
        // we remove oldTheme, just to not render 2 screens in stack
        (_) {
          setState(() {
            oldTheme = null;
          });
        },
      );
    }
    super.didUpdateWidget(oldWidget);
  }
}
