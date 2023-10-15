import 'package:flutter/material.dart';
import 'package:front/models/office.dart';
import 'package:front/models/services.dart';
import 'package:front/widgets/client_tab.dart';

import 'bar_chart.dart';

class OfficeInfo extends StatelessWidget {
  final Office office;

  const OfficeInfo({super.key, required this.office});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 16, bottom: 0, left: 8, right: 8),
      color: Theme.of(context).dialogBackgroundColor,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Text(
              office.salePointName,
              style: TextStyle(
                color: Theme.of(context).primaryColorDark,
                fontSize:
                    Theme.of(context).textTheme.titleLarge?.fontSize ?? 0.0,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Text(
            "Услуги",
            style: TextStyle(
              color: Theme.of(context).colorScheme.onBackground,
              fontSize: Theme.of(context).textTheme.titleLarge?.fontSize ?? 0.0,
            ),
            textAlign: TextAlign.center,
          ),
          ClientTab(
            individualChild: Column(
              children: individualServices
                  .map(
                    (e) => Text(
                      e,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                      textAlign: TextAlign.start,
                    ),
                  )
                  .toList(),
            ),
            legalChild: Column(
              children: legalServices
                  .map(
                    (e) => Text(
                      e,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                      textAlign: TextAlign.start,
                    ),
                  )
                  .toList(),
            ),
          ),
          const Divider(),
          Text(
            "Расписание",
            style: TextStyle(
              color: Theme.of(context).colorScheme.onBackground,
              fontSize: Theme.of(context).textTheme.titleLarge?.fontSize ?? 0.0,
            ),
            textAlign: TextAlign.center,
          ),
          ClientTab(
            individualChild: Column(
              children: office.openHoursIndividual
                  .map(
                    (e) => Text(
                      "${e.days} - ${e.hours}",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onBackground,
                        fontSize:
                            Theme.of(context).textTheme.titleLarge?.fontSize ??
                                0.0,
                      ),
                    ),
                  )
                  .toList(),
            ),
            legalChild: Column(
              children: office.openHoursIndividual
                  .map(
                    (e) => Text(
                      "${e.days} - ${e.hours}",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onBackground,
                        fontSize:
                            Theme.of(context).textTheme.titleLarge?.fontSize ??
                                0.0,
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
          const Divider(),
          Text(
            "Загруженность", // TODO: Толя
            style: TextStyle(
              color: Theme.of(context).colorScheme.onBackground,
              fontSize: Theme.of(context).textTheme.titleLarge?.fontSize ?? 0.0,
            ),
            textAlign: TextAlign.center,
          ),
          ChartContainer(
            title: 'stats',
            color: Theme.of(context).colorScheme.secondary,
            chart: BarChartWidget(
              stats: office.statistics
                  .where((i) => DateTime.now().weekday == i.dateTime.weekday)
                  .toList(),
            ),
          ),
          const Divider(),
          Column(
            children: [
              if (office.hasRamp) ...[
                Row(
                  children: [
                    Icon(
                      Icons.accessible_rounded,
                      color: Theme.of(context).colorScheme.secondary,
                      size: 35.0,
                    ),
                    const SizedBox(width: 7.0),
                    Text(
                      'Доступная среда',
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: Theme.of(context).colorScheme.onBackground),
                    ),
                  ],
                ),
                const SizedBox(height: 10.0),
              ],
              if (office.openOffice) ...[
                Row(
                  children: [
                    Icon(
                      Icons.star_border_rounded,
                      color: Theme.of(context).colorScheme.secondary,
                      size: 35.0,
                    ),
                    const SizedBox(width: 7.0),
                    Text(
                      'Привилегия',
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: Theme.of(context).colorScheme.onBackground),
                    ),
                  ],
                )
              ]
            ],
          ),
          ElevatedButton(
            child: const Text("Маршрут"),
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/path');
            },
          ),
        ],
      ),
    );
  }
}
