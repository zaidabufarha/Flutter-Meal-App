import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

enum Filter { glutenFree, lactoseFree, vegetarian, vegan }

class FilterNotifier extends StateNotifier<Map<Filter, bool>> {
  FilterNotifier()
    : super({
        //initialization
        Filter.glutenFree: false,
        Filter.lactoseFree: false,
        Filter.vegetarian: false,
        Filter.vegan: false,
      });

  void setFilter(Filter filter, bool isActive) {
    state = {
      //include original values
      ...state,
      //override selected value
      filter: isActive,
    };
  }

  void setAllFilters(Map<Filter, bool> chosenFilters) {
    state = chosenFilters;
  }
}

final filterProvider =
    //parameters are the type of notifier, then type of state (map)
    StateNotifierProvider<FilterNotifier, Map<Filter, bool>>(
      (ref) => FilterNotifier(),
    );
