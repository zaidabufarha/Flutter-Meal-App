import 'package:flutter/material.dart';
import 'package:meals/provider/filters_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

class Filters extends ConsumerWidget {
  Filters({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //no need for state because this reexecutes build when anything changes in the state
    final activeFilters = ref.watch(filterProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Filters'),
      ),
      body: Column(
        children: [
          SwitchListTile(
            title: Text('Gluten-free'),
            subtitle: Text('Only show gluten-free meals'),
            value: activeFilters[Filter.glutenFree]!,
            onChanged: (isChecked) {
              ref
                  .read(filterProvider.notifier)
                  .setFilter(Filter.glutenFree, isChecked);
            },
          ),
          SwitchListTile(
            title: Text('Lactose-free'),
            subtitle: Text('Only show lactose-free meals'),

            value: activeFilters[Filter.lactoseFree]!,
            onChanged: (isChecked) {
              ref
                  .read(filterProvider.notifier)
                  .setFilter(Filter.lactoseFree, isChecked);
            },
          ),
          SwitchListTile(
            title: Text('Vegetarian'),
            subtitle: Text('Only show vegetarian meals'),
            value: activeFilters[Filter.vegetarian]!,
            onChanged: (isChecked) {
              ref
                  .read(filterProvider.notifier)
                  .setFilter(Filter.vegetarian, isChecked);
            },
          ),
          SwitchListTile(
            title: Text('Vegan'),
            subtitle: Text('Only show vegan meals'),
            value: activeFilters[Filter.vegan]!,
            onChanged: (isChecked) {
              ref
                  .read(filterProvider.notifier)
                  .setFilter(Filter.vegan, isChecked);
            },
          ),
        ],
      ),
    );
  }
}
