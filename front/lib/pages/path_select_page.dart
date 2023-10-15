import 'package:flutter/material.dart';
import 'package:front/models/path_to_office.dart';
import 'package:front/widgets/map.dart';

class PathSelectedPage extends StatefulWidget {
  const PathSelectedPage({super.key});

  @override
  State<PathSelectedPage> createState() => _PathSelectedPageState();
}

class _PathSelectedPageState extends State<PathSelectedPage> {
  PathToOffice _path = PathToOffice(-1, address: "", time: 0, path: []);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final modalRoute = ModalRoute.of(context);
      if (modalRoute != null) {
        setState(() {
          _path = modalRoute.settings.arguments as PathToOffice;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Маршрут'),
      ),
      body: Stack(
        children: [
          Map(
            offices: [],
            path: _path.path,
          ),
          Flex(
            direction: Axis.vertical,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8, bottom: 10, right: 80),
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.popUntil(context, ModalRoute.withName("/"));
                    },
                    child: const Text("Завершить")),
              )
            ],
          )
        ],
      ),
    );
  }
}
