import 'package:flutter/material.dart';

enum Filter { glutenFree, lactoseFree, vegetarian, vegan }

class Filters extends StatefulWidget {
  Filters(this.currentFilters, {super.key});
  Map<Filter, bool> currentFilters;
  @override
  State<StatefulWidget> createState() {
    return _FiltersState();
  }
}

class _FiltersState extends State<Filters> {
  bool glutenFree = false;
  bool lactoseFree = false;
  bool vegan = false;
  bool vegetarian = false;

  @override
  void initState() {
    //initialize
    super.initState();
    print(widget.currentFilters);
    glutenFree = widget.currentFilters[Filter.glutenFree]!;
    lactoseFree = widget.currentFilters[Filter.lactoseFree]!;
    vegan = widget.currentFilters[Filter.vegan]!;
    vegetarian = widget.currentFilters[Filter.vegetarian]!;
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        Navigator.of(context).pop({
          Filter.glutenFree: glutenFree,
          Filter.lactoseFree: lactoseFree,
          Filter.vegetarian: vegetarian,
          Filter.vegan: vegan,
        });
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
