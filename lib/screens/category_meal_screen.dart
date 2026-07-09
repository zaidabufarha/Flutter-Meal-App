import 'package:flutter/material.dart';
import 'package:meals/data/dummy_data.dart';
import 'package:meals/models/category.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/screens/filters.dart';
import 'package:meals/widgets/meal_card.dart';

class CategoryMealScreen extends StatelessWidget {
  CategoryMealScreen(
    this.category,
    this.isFavorite,
    this.toggleFavorite,
    this.filterList, {
    super.key,
  });
  CategoryMealScreen.favorites(
    this.favorites,
    this.isFavorite,
    this.toggleFavorite,
    this.filterList, {
    super.key,
  }) {
    category = null;
  }
  final Map<Filter, bool> filterList;
  final bool Function(Meal meal) isFavorite;
  final void Function(Meal meal) toggleFavorite;
  Category? category;
  List<Meal>? favorites;

  @override
  Widget build(BuildContext context) {
    List<Meal> categoryMeals = [];
    if (category != null) {
      categoryMeals = dummyMeals
          .where((meal) => meal.categories.contains(category!.id))
          .toList();
    } else {
      categoryMeals = List.from(favorites!);
      category = Category('f', 'Favorites', Colors.orangeAccent);
    }
    categoryMeals = categoryMeals.where((meal) {
      if (((filterList[Filter.glutenFree]! && !meal.isGlutenFree) ||
              (filterList[Filter.lactoseFree]! && !meal.isLactoseFree) ||
              (filterList[Filter.vegan]! && !meal.isVegan) ||
              (filterList[Filter.vegetarian]! && !meal.isVegetarian)) &&
          category!.title == 'f') {
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
            isFavorite,
            toggleFavorite,
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
