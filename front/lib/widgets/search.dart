import 'package:flutter/material.dart';
import 'package:front/models/office.dart';

class Search extends StatelessWidget {
  final List<Office> offices;

  const Search({super.key, required this.offices});

  @override
  Widget build(BuildContext context) {
    return Autocomplete<Office>(
      optionsBuilder: (value) {
        return offices.where(
          (element) =>
              element.address.toLowerCase().contains(value.text.toLowerCase()),
        );
      },
      displayStringForOption: (Office office) => office.address,
      fieldViewBuilder: (
        context,
        textEditingController,
        focusNode,
        onFieldSubmitted,
      ) =>
          TextField(
        controller: textEditingController,
        focusNode: focusNode,
        onSubmitted: (value) => onFieldSubmitted(),
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          hintText: 'Найти отделение...',
          fillColor: Theme.of(context).colorScheme.background,
          filled: true,
          enabledBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(15)),
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.primary,
              width: 2,
            ),
          ),
        ),
        style: TextStyle(
          color: Theme.of(context).colorScheme.onBackground,
        ),
      ),
      optionsViewBuilder: (
        BuildContext context,
        onSelected,
        options,
      ) {
        return Container(
          color: Theme.of(context).colorScheme.background,
          child: ListView.separated(
            itemCount: offices.length,
            separatorBuilder: (context, index) => const Divider(),
            itemBuilder: (_, index) => GestureDetector(
              onTap: () => onSelected(offices[index]),
              child: Text(
                offices[index].address.split(",").reversed.join(",").trim(),
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onBackground,
                  fontSize:
                      Theme.of(context).textTheme.headlineSmall?.fontSize ?? 10,
                  decoration: TextDecoration.none,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
