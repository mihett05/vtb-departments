import 'package:flutter/material.dart';

class FormPage extends StatefulWidget {
  const FormPage({super.key});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  // bool _individual = true;
  List<bool> _selections = [true, false];

  // void _incrementCounter() {
  //   setState(() {
  //     _counter++;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Выбор отделения'),
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            ToggleButtons(
              isSelected: _selections,
              onPressed: (int index) {
                setState(() {
                  // _selections[index] = !_selections[index];
                  if (!_selections[index]) {
                    _selections = _selections.reversed.toList();
                    // if (index == 0) {
                    //   // _selections[0] = !_selections[0];
                    //   _selections.reversed;
                    // } else if (index == 1) {
                    //   _selections.reversed;
                    // }
                  }
                  // You Can Compare Other Indexes Too
                });
              },
              color: Theme.of(context).colorScheme.primary,
              selectedColor: Theme.of(context).colorScheme.onPrimary,
              fillColor: Theme.of(context).colorScheme.primary,
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
            // Row(
            //   children: [
            //     ElevatedButton(onPressed: () => _individual = true, child: child),
            //   ],),
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _incrementCounter,
      //   tooltip: 'Increment',
      //   child: const Icon(Icons.add),
      // ),
    );
  }
}
