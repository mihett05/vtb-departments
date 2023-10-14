import 'package:flutter/material.dart';
import 'package:front/models/path_to_office.dart';
import 'package:front/widgets/map.dart';

class PathPage extends StatefulWidget {
  const PathPage({super.key});

  @override
  State<PathPage> createState() => _PathPageState();
}

class _PathPageState extends State<PathPage> {
  List<PathToOffice> paths = [
    PathToOffice(
        address: 'ул. Красная, д. 60', time: 15, workload: Workload.medium),
    PathToOffice(
        address: 'ул. Баранова, д. 1', time: 17, workload: Workload.high),
    PathToOffice(address: 'ул. Ленина, д. 9', time: 20, workload: Workload.low),
    PathToOffice(
        address: 'пр-д Строителей, д. 1б', time: 25, workload: Workload.medium),
  ];

  List<String> _filters = ['Расстояние', 'Загруженность'];
  String _chosenFilter = 'Расстояние';
  int _chosenIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Маршрут'),
      ),
      body: Stack(children: [
        const Map(
          offices: [],
        ),
        Align(
          alignment: AlignmentDirectional.bottomCenter,
          child: Container(
            width: double.infinity,
            height: 200,
            // color: Theme.of(context).colorScheme.background,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.background,
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    PopupMenuButton<String>(
                      icon: Padding(
                        padding: EdgeInsets.all(5.0),
                        child: Icon(Icons.filter_list,
                            color: Theme.of(context).colorScheme.primary),
                      ),
                      color: Theme.of(context).colorScheme.background,
                      onSelected: (String result) {
                        setState(() {
                          _chosenFilter = result;
                          paths = sortPaths(_chosenFilter, paths);
                          _chosenIndex = 0;
                        });
                      },
                      itemBuilder: (BuildContext context) =>
                          _filters.map((item) {
                        return PopupMenuItem(
                          value: item,
                          child: Text(
                            item,
                            style:
                                Theme.of(context).textTheme.bodyLarge!.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onBackground,
                                    ),
                          ),
                        );
                      }).toList(),
                    ),
                    Container(
                      height: 25,
                      decoration: _chosenFilter != ''
                          ? BoxDecoration(
                              border: Border.all(
                                color: Theme.of(context).colorScheme.primary,
                                width: 1.0,
                              ),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(25)),
                            )
                          : BoxDecoration(),
                      child: Row(
                        children: [
                          const SizedBox(width: 15.0),
                          Text(_chosenFilter,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  )),
                          _chosenFilter != ''
                              ? IconButton(
                                  onPressed: () => setState(() {
                                    _chosenFilter = '';
                                  }),
                                  icon: Icon(
                                    Icons.close_rounded,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    size: 15.0,
                                  ),
                                  padding: EdgeInsets.all(0),
                                )
                              : const SizedBox(),
                        ],
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: paths.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _chosenIndex = index;
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 0.0),
                          margin: EdgeInsets.all(7.0),
                          width: 120,
                          decoration: BoxDecoration(
                            image: index == paths.length - 1 &&
                                    _chosenFilter == 'Расстояние'
                                ? DecorationImage(
                                    scale: 0.5,
                                    alignment: Alignment.bottomCenter,
                                    image: AssetImage('assets/car1.png'),
                                    fit: BoxFit.fitWidth)
                                : index == 0 &&
                                        _chosenFilter == 'Расстояние' &&
                                        workloadToInt(paths[index].workload) > 0
                                    ? DecorationImage(
                                        scale: 0.5,
                                        alignment: Alignment.bottomCenter,
                                        image: AssetImage('assets/coffee.png'),
                                        fit: BoxFit.fitWidth)
                                    : null,
                            color: _chosenIndex == index
                                ? Theme.of(context).colorScheme.primary
                                : Theme.of(context).colorScheme.shadow,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(15)),
                            border: index == paths.length - 1 &&
                                    _chosenFilter == 'Расстояние'
                                ? Border.all(
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                    width: 1.0,
                                  )
                                : Border(),
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    '${paths[index].time} мин',
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelLarge!
                                        .copyWith(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onBackground),
                                  ),
                                  const Spacer(),
                                  Container(
                                    width: 15,
                                    height: 15,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: paths[index].color),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 5.0,
                              ),
                              Text(
                                paths[index].address,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onBackground),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ]),

      // Center(
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: <Widget>[
      //     ],
      //   ),
      // ),
    );
  }
}

int distanceComparison(PathToOffice a, PathToOffice b) {
  final propertyA = a.time;
  final propertyB = b.time;
  if (propertyA < propertyB) {
    return -1;
  } else if (propertyA > propertyB) {
    return 1;
  } else {
    return 0;
  }
}

int workloadToInt(Workload w) {
  switch (w) {
    case Workload.high:
      return 2;
    case Workload.medium:
      return 1;
    case Workload.low:
      return 0;
    default:
      return 0;
  }
}

int workloadComparison(PathToOffice a, PathToOffice b) {
  final propertyA = workloadToInt(a.workload);
  final propertyB = workloadToInt(b.workload);
  if (propertyA < propertyB) {
    return -1;
  } else if (propertyA > propertyB) {
    return 1;
  } else {
    return 0;
  }
}

List<PathToOffice> sortPaths(String filter, List<PathToOffice> paths) {
  if (filter == 'Расстояние') {
    paths.sort(distanceComparison);
  } else if (filter == 'Загруженность') {
    paths.sort(workloadComparison);
  }
  return paths;
}
