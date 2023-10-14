import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:front/models/form_data.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';

import '../models/services.dart';

class ClientForm extends StatefulWidget {
  const ClientForm({super.key});

  @override
  State<ClientForm> createState() => _ClientFormState();
}

class _ClientFormState extends State<ClientForm> {
  FormData _data = FormData(
      clientEntity: ClientEntity.individual,
      individualServices: [],
      legalServices: [],
      lowMobility: false,
      privilege: false,
      time: DateTime.now());

  List<bool> _selections = [true, false];
  List<String> _individualList = [];
  List<String> _legalList = [];
  DateTime? _time;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [
          const SizedBox(height: 10.0),
          Expanded(
            child: ListView(
              children: [
                Center(
                  child: ToggleButtons(
                    isSelected: _selections,
                    onPressed: (int index) {
                      setState(() {
                        if (!_selections[index]) {
                          _selections = _selections.reversed.toList();

                          if (_data.clientEntity == ClientEntity.individual) {
                            _data.clientEntity = ClientEntity.legal;
                          } else {
                            _data.clientEntity = ClientEntity.individual;
                          }
                        }
                      });
                    },
                    color: Theme.of(context).colorScheme.primary,
                    selectedColor: Theme.of(context).colorScheme.onPrimary,
                    fillColor: Theme.of(context).colorScheme.primary,
                    borderColor: Theme.of(context).colorScheme.primary,
                    selectedBorderColor: Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.circular(20.0),
                    children: const <Widget>[
                      Padding(
                        padding: EdgeInsets.all(15),
                        child: Text('Физические лица'),
                      ),
                      Padding(
                        padding: EdgeInsets.all(15),
                        child: Text('Юридические лица'),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10.0),
                _data.clientEntity == ClientEntity.individual
                    ? Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Flexible(
                            child: ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: _data.individualServices.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Row(
                                  children: [
                                    Text(
                                      _data.individualServices[index],
                                      style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onBackground),
                                    ),
                                    const Spacer(),
                                    IconButton(
                                      onPressed: () {
                                        setState(() {
                                          _individualList.removeAt(index);
                                          _data.individualServices
                                              .removeAt(index);
                                        });
                                      },
                                      icon: Icon(
                                          Icons.remove_circle_outline_rounded),
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    )
                                  ],
                                );
                              },
                            ),
                          ),
                          Theme(
                            data: Theme.of(context).copyWith(
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              focusColor: Colors.transparent,
                            ),
                            child: DropdownButton(
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                    color: Colors.white,
                                  ),
                              icon: Icon(Icons.add_rounded,
                                  color: Theme.of(context).colorScheme.primary),
                              underline: Container(),
                              hint: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 0.0, horizontal: 15.0),
                                child: Text(
                                  "Добавить услугу",
                                  style: Theme.of(context).textTheme.labelLarge,
                                ),
                              ),
                              onChanged: (value) {
                                setState(() {
                                  _individualList.add(value!);
                                  _data.individualServices.add(value);
                                });
                              },
                              items: individualServices.map((item) {
                                return DropdownMenuItem(
                                  value: item,
                                  child: Text(
                                    item,
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onBackground),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      )
                    : Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Flexible(
                            child: ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: _data.legalServices.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Row(
                                  children: [
                                    Text(
                                      _data.legalServices[index],
                                      style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onBackground),
                                    ),
                                    const Spacer(),
                                    IconButton(
                                      onPressed: () {
                                        setState(() {
                                          _legalList.removeAt(index);
                                          _data.legalServices.removeAt(index);
                                        });
                                      },
                                      icon: Icon(
                                          Icons.remove_circle_outline_rounded),
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    )
                                  ],
                                );
                              },
                            ),
                          ),
                          Theme(
                            data: Theme.of(context).copyWith(
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              focusColor: Colors.transparent,
                            ),
                            child: DropdownButton(
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                    color: Colors.white,
                                  ),
                              icon: Icon(Icons.add_rounded,
                                  color: Theme.of(context).colorScheme.primary),
                              underline: Container(),
                              hint: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 0.0, horizontal: 15.0),
                                child: Text(
                                  "Добавить услугу",
                                  style: Theme.of(context).textTheme.labelLarge,
                                ),
                              ),
                              onChanged: (value) {
                                setState(() {
                                  _legalList.add(value!);
                                  _data.legalServices.add(value);
                                });
                              },
                              items: legalServices.map((item) {
                                return DropdownMenuItem(
                                  value: item,
                                  child: Text(
                                    item,
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onBackground),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                const SizedBox(height: 10.0),
                Divider(
                  indent: 5.0,
                  endIndent: 5.0,
                  color: Theme.of(context).colorScheme.shadow,
                ),
                const SizedBox(height: 10.0),
                Column(
                  children: [
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
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(
                                color:
                                    Theme.of(context).colorScheme.onBackground,
                              ),
                        ),
                        const Spacer(),
                        FlutterSwitch(
                          width: 50.0,
                          height: 30.0,
                          value: _data.lowMobility,
                          activeColor: Theme.of(context).colorScheme.secondary,
                          onToggle: (value) {
                            setState(() {
                              _data.lowMobility = value;
                            });
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 10.0),
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
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onBackground),
                        ),
                        const Spacer(),
                        FlutterSwitch(
                          width: 50.0,
                          height: 30.0,
                          value: _data.privilege,
                          activeColor: Theme.of(context).colorScheme.secondary,
                          onToggle: (value) {
                            setState(() {
                              _data.privilege = value;
                            });
                          },
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.more_time_rounded,
                          color: Theme.of(context).colorScheme.secondary,
                          size: 35.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(7.0),
                          child: GestureDetector(
                            onTap: () async {
                              _time =
                                  await showDateTimePicker(context: context);
                              setState(() {
                                if (_time != null) {
                                  _data.time = _time!;
                                }
                              });
                            },
                            child: _time != null
                                ? Text(
                                    DateFormat('yyyy-MM-dd – kk:mm')
                                        .format(_time!),
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelLarge!
                                        .copyWith(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary),
                                  )
                                : Text(
                                    "Выбрать время",
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelLarge!
                                        .copyWith(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary),
                                  ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/path', arguments: _data);
            },
            child: const Text("Маршрут"),
          ),
        ],
      ),
    );
  }
}

Future<DateTime?> showDateTimePicker({
  required BuildContext context,
  DateTime? initialDate,
  DateTime? firstDate,
  DateTime? lastDate,
}) async {
  initialDate ??= DateTime.now();
  firstDate ??= initialDate.subtract(const Duration(days: 365 * 100));
  lastDate ??= firstDate.add(const Duration(days: 365 * 200));

  final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Theme.of(context).colorScheme.primary,
              onSurface: Theme.of(context).colorScheme.onBackground,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
                foregroundColor: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
          child: child!,
        );
      });

  if (selectedDate == null) return null;

  if (!context.mounted) return selectedDate;

  final TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(selectedDate),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Theme.of(context).colorScheme.primary,
              onSurface: Theme.of(context).colorScheme.onBackground,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
                foregroundColor: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
          child: child!,
        );
      });

  return selectedTime == null
      ? null
      : DateTime(
          selectedDate.year,
          selectedDate.month,
          selectedDate.day,
          selectedTime.hour,
          selectedTime.minute,
        );
}
