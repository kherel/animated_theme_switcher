// import 'package:flutter/material.dart';

// void main() => runApp(const MyApp());

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return BrandTheme(
//       child: Builder(builder: (context) {
//         return MaterialApp(
//           title: 'Flutter Demo',
//           theme: BrandTheme.of(context).themeData,
//           home: const MyHomePage(),
//         );
//       }),
//     );
//   }
// }

// GlobalKey switherGlobalKey = GlobalKey();

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({
//     Key? key,
//   }) : super(key: key);

//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;

//   @override
//   void initState() {
//     super.initState();

//     _controller = AnimationController(
//       duration: const Duration(milliseconds: 300),
//       vsync: this,
//     );

//     _controller.forward();
//     WidgetsBinding.instance!.addPostFrameCallback(_afterLayout);
//   }

//   void _afterLayout(_) {
//     _getSwitcherCoodinates();
//   }

//   @override
//   void dispose() {
//     _controller.dispose();

//     super.dispose();
//   }

//   int _counter = 0;
//   BrandThemeModel? oldTheme;
//   late Offset switcherOffset;

//   void _incrementCounter() {
//     setState(() {
//       _counter++;
//     });
//   }

//   _getPage(brandTheme, {isFirst = false}) {
//     return Scaffold(
//       backgroundColor: brandTheme.color2,
//       appBar: AppBar(
//         backgroundColor: brandTheme.color1,
//         title: Text(
//           'Flutter Demo Home Page',
//           style: TextStyle(color: brandTheme.textColor2),
//         ),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: <Widget>[
//             Text(
//               'You have pushed the button this many times:',
//               style: TextStyle(
//                 color: brandTheme.textColor1,
//               ),
//             ),
//             Text(
//               '$_counter',
//               style: TextStyle(color: brandTheme.textColor1, fontSize: 200),
//             ),
//             Switch(
//               key: isFirst ? switherGlobalKey : null,
//               onChanged: (needDark) {
//                 oldTheme = brandTheme;
//                 BrandTheme.instanceOf(context).changeTheme(
//                   needDark ? BrandThemeKey.dark : BrandThemeKey.light,
//                 );
//               },
//               value: BrandTheme.of(context).brightness == Brightness.dark,
//             )
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _incrementCounter,
//         tooltip: 'Increment',
//         child: const Icon(
//           Icons.add,
//         ),
//       ),
//     );
//   }

//   @override
//   void didUpdateWidget(MyHomePage oldWidget) {
//     var theme = BrandTheme.of(context);

//     if (theme != oldTheme) {
//       _getSwitcherCoodinates();
//       _controller.reset();
//       _controller.forward().then(
//         (_) {
//           oldTheme = theme;
//         },
//       );
//     }
//     super.didUpdateWidget(oldWidget);
//   }

//   void _getSwitcherCoodinates() {
//     RenderBox renderObject =
//         switherGlobalKey.currentContext!.findRenderObject() as RenderBox;
//     switcherOffset = renderObject.localToGlobal(Offset.zero);
//   }

//   @override
//   Widget build(BuildContext context) {
//     var brandTheme = BrandTheme.of(context);

//     if (oldTheme == null) {
//       return _getPage(brandTheme, isFirst: true);
//     }
//     return Stack(
//       children: <Widget>[
//         if (oldTheme != null) _getPage(oldTheme),
//         AnimatedBuilder(
//           animation: _controller,
//           child: _getPage(brandTheme, isFirst: true),
//           builder: (_, child) {
//             return ClipPath(
//               clipper: MyClipper(
//                 sizeRate: _controller.value,
//                 offset: switcherOffset.translate(30, 15),
//               ),
//               child: child,
//             );
//           },
//         ),
//       ],
//     );
//   }
// }

// class MyClipper extends CustomClipper<Path> {
//   MyClipper({required this.sizeRate, required this.offset});
//   final double sizeRate;
//   final Offset offset;

//   @override
//   Path getClip(Size size) {
//     var path = Path()
//       ..addOval(
//         Rect.fromCircle(center: offset, radius: size.height * sizeRate),
//       );

//     return path;
//   }

//   @override
//   bool shouldReclip(CustomClipper<Path> oldClipper) => true;
// }

// class BrandTheme extends StatefulWidget {
//   final Widget child;

//   const BrandTheme({
//     Key? key,
//     required this.child,
//   }) : super(key: key);

//   @override
//   BrandThemeState createState() => BrandThemeState();

//   static BrandThemeModel of(BuildContext context) {
//     final inherited =
//         context.dependOnInheritedWidgetOfExactType<_InheritedBrandTheme>();
//     assert(inherited != null, 'No _InheritedBrandTheme found in context');

//     return inherited!.data.brandTheme;
//   }

//   static BrandThemeState instanceOf(BuildContext context) {
//     final inherited =
//         (context.dependOnInheritedWidgetOfExactType<_InheritedBrandTheme>());
//     assert(inherited != null, 'No _InheritedBrandTheme found in context');

//     return inherited!.data;
//   }
// }

// class BrandThemeState extends State<BrandTheme> {
//   late BrandThemeModel brandTheme;

//   @override
//   void initState() {
//     final isPlatformDark =
//         WidgetsBinding.instance!.window.platformBrightness == Brightness.dark;
//     final themeKey = isPlatformDark ? BrandThemeKey.dark : BrandThemeKey.light;
//     brandTheme = BrandThemes.getThemeFromKey(themeKey);
//     super.initState();
//   }

//   void changeTheme(BrandThemeKey themeKey) {
//     setState(() {
//       brandTheme = BrandThemes.getThemeFromKey(themeKey);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return _InheritedBrandTheme(
//       data: this,
//       child: widget.child,
//     );
//   }
// }

// class _InheritedBrandTheme extends InheritedWidget {
//   final BrandThemeState data;

//   const _InheritedBrandTheme({
//     Key? key,
//     required this.data,
//     required Widget child,
//   }) : super(key: key, child: child);

//   @override
//   bool updateShouldNotify(_InheritedBrandTheme oldWidget) {
//     return true;
//   }
// }

// ThemeData defaultThemeData = ThemeData(
//   floatingActionButtonTheme: const FloatingActionButtonThemeData(
//     shape: RoundedRectangleBorder(),
//   ),
// );

// class BrandThemeModel extends ChangeNotifier {
//   final Color color1;
//   final Color color2;

//   final Color textColor1;
//   final Color textColor2;
//   ThemeData _themeData;

//   ThemeData get themeData => _themeData;

//   set themeData(ThemeData themeData) {
//     _themeData = themeData;
//     notifyListeners();
//   }

//   final Brightness brightness;

//   BrandThemeModel({
//     required this.color1,
//     required this.color2,
//     required this.textColor1,
//     required this.textColor2,
//     required this.brightness,
//   }) : _themeData = defaultThemeData.copyWith(brightness: brightness);

//   @override
//   bool operator ==(Object other) {
//     if (identical(this, other)) return true;

//     return other is BrandThemeModel &&
//         other.color1 == color1 &&
//         other.color2 == color2 &&
//         other.textColor1 == textColor1 &&
//         other.textColor2 == textColor2 &&
//         other._themeData == _themeData &&
//         other.brightness == brightness;
//   }

//   @override
//   int get hashCode {
//     return color1.hashCode ^
//         color2.hashCode ^
//         textColor1.hashCode ^
//         textColor2.hashCode ^
//         themeData.hashCode ^
//         brightness.hashCode;
//   }
// }

// enum BrandThemeKey { light, dark }

// class BrandThemes {
//   static BrandThemeModel getThemeFromKey(BrandThemeKey themeKey) {
//     switch (themeKey) {
//       case BrandThemeKey.light:
//         return lightBrandTheme;
//       case BrandThemeKey.dark:
//         return darkBrandTheme;
//       default:
//         return lightBrandTheme;
//     }
//   }
// }

// BrandThemeModel lightBrandTheme = BrandThemeModel(
//   brightness: Brightness.light,
//   color1: Colors.blue,
//   color2: Colors.white,
//   textColor1: Colors.black,
//   textColor2: Colors.white,
// );

// BrandThemeModel darkBrandTheme = BrandThemeModel(
//   brightness: Brightness.dark,
//   color1: Colors.red,
//   color2: Colors.black,
//   textColor1: Colors.blue,
//   textColor2: Colors.yellow,
// );

// class ThemeRoute extends PageRouteBuilder {
//   ThemeRoute(this.widget)
//       : super(
//           pageBuilder: (
//             context,
//             animation,
//             secondaryAnimation,
//           ) =>
//               widget,
//           transitionsBuilder: transitionsBuilder,
//         );

//   final Widget widget;
// }

// Widget transitionsBuilder(
//   BuildContext context,
//   Animation<double> animation,
//   Animation<double> secondaryAnimation,
//   Widget child,
// ) {
//   var _animation = Tween<double>(
//     begin: 0,
//     end: 100,
//   ).animate(animation);
//   return SlideTransition(
//     position: Tween<Offset>(
//       begin: const Offset(0, 1),
//       end: Offset.zero,
//     ).animate(animation),
//     child: Container(
//       child: child,
//     ),
//   );
// }
