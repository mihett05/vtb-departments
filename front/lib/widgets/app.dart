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
          primary: Color(0xff1e4bd2),
          onPrimary: Colors.white,
          background: Colors.white,
          onBackground: Color(0xff2F3441),
          secondary: Color(0xff0A2896),
          onSecondary: Colors.white,
          tertiary: Color(0xff00aaff),
          error: Color(0xffca181f),
          onError: Colors.white,
          surface: Color(0xff1e4bd2),
          onSurface: Colors.white,
          shadow: Color(0xFFDCE0EB),
        ),
        textTheme: const TextTheme(
          titleLarge: TextStyle(
              fontFamily: 'VTB', fontSize: 22, fontWeight: FontWeight.bold),
          bodyLarge: TextStyle(fontFamily: 'VTB', fontSize: 16),
          bodyMedium: TextStyle(fontFamily: 'VTB', fontSize: 14),
          labelLarge: TextStyle(
              fontFamily: 'VTB',
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Color(0xff2F3441)),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0Xff1E4BD2),
            foregroundColor: Colors.white,
            textStyle: const TextStyle(
                fontFamily: 'VTB', fontSize: 14, fontWeight: FontWeight.bold),
            minimumSize: const Size(double.infinity, 60),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
          ),
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
