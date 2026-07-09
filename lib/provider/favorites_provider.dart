import 'package:flutter_riverpod/legacy.dart';
import 'package:meals/models/meal.dart';

class FavoritesNotifier extends StateNotifier<List<Meal>> {
  FavoritesNotifier() : super([]);

  //MANIPULATION IS LIMITED CUZ YOU CAN'T EDIT WHATS IN A PROVIDER ONLY REPLACE IT
  bool isFavorite(Meal meal) {
    return state.contains(meal);
  }

  void toggleFavorite(Meal meal) {
    print('Toggled ${meal.title}');
    if (isFavorite(meal)) {
      //remove
      state = state.where((m) {
        if (m == meal)
          return false;
        else
          return true;
      }).toList();
    } else {
      //add
      state = [...state, meal];
    }
  }
}

final FavoritesProvider = StateNotifierProvider<FavoritesNotifier, List<Meal>>((
  ref,
) {
  return FavoritesNotifier();
});
