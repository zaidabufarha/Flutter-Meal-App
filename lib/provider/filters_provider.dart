import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:meals/provider/meal_list_provider.dart';

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

final filteredMealsProvider = Provider((ref) {
  final filterList = ref.watch(filterProvider);
  final mealList = ref.watch(mealListProvider);

  return mealList.where((meal) {
    if ((filterList[Filter.glutenFree]! && !meal.isGlutenFree) ||
        (filterList[Filter.lactoseFree]! && !meal.isLactoseFree) ||
        (filterList[Filter.vegan]! && !meal.isVegan) ||
        (filterList[Filter.vegetarian]! && !meal.isVegetarian)) {
      return false;
    } else {
      return true;
    }
  }).toList();
});
