import 'package:flutter/material.dart';

class PathSelectedPage extends StatefulWidget {
  const PathSelectedPage({super.key});

  @override
  State<PathSelectedPage> createState() => _PathSelectedPageState();
}

class _PathSelectedPageState extends State<PathSelectedPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Маршрут'),
          ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
          ],
        ),
      ),
    );
  }
}
