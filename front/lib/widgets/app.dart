import 'package:flutter/material.dart';
import 'package:front/pages/form_page.dart';
import 'package:front/pages/map_page.dart';
import 'package:front/pages/path_page.dart';
import 'package:front/pages/path_select_page.dart';

class App extends StatelessWidget {
  const App({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: const ColorScheme(
          brightness: Brightness.light,
          primary: Color(0xff00aaff),
          onPrimary: Colors.white,
          background: Color(0xfff3f7fa),
          onBackground: Colors.white,
          secondary: Color(0xff0A2896),
          onSecondary: Colors.white,
          error: Color(0xffca181f),
          onError: Colors.white,
          surface: Color(0xff00aaff),
          onSurface: Colors.white,
        ),

        // colorScheme: ColorScheme.fromSeed(seedColor: Color(0X0A2896)),
        useMaterial3: true,
      ),
      routes: {
        '/': (context) => const MapPage(),
        '/form': (context) => const FormPage(),
        '/path-select': (context) => const PathSelectedPage(),
        '/path': (context) => const PathPage(),
      },
    );
  }
}
