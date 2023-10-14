import 'package:flutter/material.dart';

import '../models/form-data.dart';

class ClientTab extends StatefulWidget {
  final Widget individualChild;
  final Widget legalChild;

  const ClientTab({
    super.key,
    required this.individualChild,
    required this.legalChild,
  });

  @override
  State<ClientTab> createState() => _ClientTabState();
}

class _ClientTabState extends State<ClientTab> {
  final FormData _data = FormData(
      clientEntity: ClientEntity.individual,
      individualServices: [],
      legalServices: [],
      lowMobility: false,
      privilege: false,
      time: DateTime.now());

  List<bool> _selections = [true, false];

  @override
  Widget build(context) {
    return Column(
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
            ? widget.individualChild
            : widget.legalChild
      ],
    );
  }
}
