import 'package:flutter/material.dart';
import 'package:front/pages/map-page.dart';

class App extends StatelessWidget {
  const App({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routes: {
        '/': (context) => const MapPage(),
        // '/form': (context) => {},
        // '/path-select': (context) => {},
        // '/path': (context) => {},
      },
    );
  }
}
