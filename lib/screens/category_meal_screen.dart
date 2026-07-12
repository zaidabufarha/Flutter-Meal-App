import 'package:flutter/material.dart';
import 'package:meals/data/dummy_data.dart';
import 'package:meals/models/category.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/provider/favorites_provider.dart';
import 'package:meals/screens/filters.dart';
import 'package:meals/widgets/meal_card.dart';
import 'package:meals/provider/meal_list_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/provider/filters_provider.dart';

class CategoryMealScreen extends ConsumerWidget {
  CategoryMealScreen(
    this.category, {
    super.key,
  });
  CategoryMealScreen.favorites({
    super.key,
  }) {
    category = null;
  }
  Category? category;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Meal> favorites = ref.watch(FavoritesProvider);
    List<Meal> categoryMeals = [];
    if (category != null) {
      categoryMeals = ref
          .watch(mealListProvider)
          .where((meal) => meal.categories.contains(category!.id))
          .toList();
    } else {
      categoryMeals = List.from(favorites);
      category = Category('f', 'Favorites', Colors.orangeAccent);
    }
    final filterList = ref.watch(filterProvider);
    print(filterList); //debug
    categoryMeals = categoryMeals.where((meal) {
      if (((filterList[Filter.glutenFree]! && !meal.isGlutenFree) ||
              (filterList[Filter.lactoseFree]! && !meal.isLactoseFree) ||
              (filterList[Filter.vegan]! && !meal.isVegan) ||
              (filterList[Filter.vegetarian]! && !meal.isVegetarian)) &&
          category!.id != 'f') {
        //favorites include filtered out items because you favorited them for a reason probably
        return false;
      } else {
        return true;
      }
    }).toList();
    Widget contentBody;

    if (categoryMeals.isEmpty) {
      contentBody = Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'This category is empty, try another one',
              textAlign: TextAlign.center,
              style:
                  Theme.of(
                    context,
                  ).textTheme.headlineMedium!.copyWith(
                    color: Colors.white,
                  ),
            ),
          ],
        ),
      );
    } else {
      contentBody = Padding(
        padding: EdgeInsets.all(20),
        child: ListView.builder(
          itemCount: categoryMeals.length,
          //more efficient use more
          itemBuilder: (context, index) => MealCard(
            categoryMeals[index],
            category!,
          ),
        ),
      );
    }
    return Scaffold(
      appBar: (category!.title == 'Favorites')
          ? null
          : AppBar(
              title: Text(category!.title),
              backgroundColor: category!.color,
            ),

      body: contentBody,
    );
  }
}
