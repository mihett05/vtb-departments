import 'package:flutter/material.dart';
import 'package:front/api/client.dart';
import 'package:front/widgets/map.dart';
import 'package:front/widgets/search.dart';

import '../models/office.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  Future<List<Office>> _offices = getDepartments();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _offices,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Text(
                        "Не удалось загрузить данные\nПроверьте подключение к интеренету"),
                  )
                ]);
          }
          if (!snapshot.hasData) {
            return const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: SizedBox(
                    width: 60,
                    height: 60,
                    child: CircularProgressIndicator(),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: 16),
                    child: Text('Загрузка...'),
                  ),
                ),
              ],
            );
          }
          return Map(offices: snapshot.data!, search: true);
        },
      ),
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
