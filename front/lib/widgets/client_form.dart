import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:front/models/form-data.dart';

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
                          'Доступно для маломобильных граждан',
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

List<String> individualServices = ['indService1', 'indService2', 'indService3'];
List<String> legalServices = [
  'legalService1',
  'legalService2',
  'legalService3'
];
