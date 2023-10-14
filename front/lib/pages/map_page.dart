import 'package:flutter/material.dart';
import 'package:front/widgets/map.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Map(),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) {
          if (value == 0) {
            Navigator.pushNamed(context, '/path');
          } else {
            Navigator.pushNamed(context, '/form');
          }
        },
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedItemColor: Theme.of(context).colorScheme.onSurface,
        backgroundColor: Theme.of(context).colorScheme.surface,
        items: const [
          BottomNavigationBarItem(
            label: "Карта",
            icon: Icon(Icons.route_outlined),
          ),
          BottomNavigationBarItem(
            label: "Поиск",
            icon: Icon(
              Icons.search,
            ),
          )
        ],
      ),
    );
  }
}
