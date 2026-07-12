import 'package:flutter/material.dart';
import 'package:meals/provider/filters_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

class Filters extends ConsumerStatefulWidget {
  Filters({super.key});
  @override
  ConsumerState<Filters> createState() {
    return _FiltersState();
  }
}

class _FiltersState extends ConsumerState<Filters> {
  bool glutenFree = false;
  bool lactoseFree = false;
  bool vegan = false;
  bool vegetarian = false;

  @override
  void initState() {
    //initialize
    super.initState();
    final activeFilters = ref.read(filterProvider);
    //initializing from provider. still local management to update UI
    glutenFree = activeFilters[Filter.glutenFree]!;
    lactoseFree = activeFilters[Filter.lactoseFree]!;
    vegan = activeFilters[Filter.vegan]!;
    vegetarian = activeFilters[Filter.vegetarian]!;
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,

      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        ref.read(filterProvider.notifier).setAllFilters({
          Filter.glutenFree: glutenFree,
          Filter.lactoseFree: lactoseFree,
          Filter.vegetarian: vegetarian,
          Filter.vegan: vegan,
        });
        Navigator.of(context).pop();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Filters'),
        ),
        body: Column(
          children: [
            SwitchListTile(
              title: Text('Gluten-free'),
              subtitle: Text('Only show gluten-free meals'),
              value: glutenFree,
              onChanged: (isChecked) {
                setState(() {
                  glutenFree = isChecked;
                });
              },
            ),
            SwitchListTile(
              title: Text('Lactose-free'),
              subtitle: Text('Only show lactose-free meals'),
              value: lactoseFree,
              onChanged: (isChecked) {
                setState(() {
                  lactoseFree = isChecked;
                });
              },
            ),
            SwitchListTile(
              title: Text('Vegetarian'),
              subtitle: Text('Only show vegetarian meals'),
              value: vegetarian,
              onChanged: (isChecked) {
                setState(() {
                  vegetarian = isChecked;
                  if (!isChecked) vegan = isChecked;
                });
              },
            ),
            SwitchListTile(
              title: Text('Vegan'),
              subtitle: Text('Only show vegan meals'),
              value: vegan,
              onChanged: (isChecked) {
                setState(() {
                  vegan = isChecked;
                  if (isChecked) vegetarian = isChecked;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
