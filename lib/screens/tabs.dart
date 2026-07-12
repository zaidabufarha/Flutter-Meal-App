import 'package:flutter/material.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/screens/category_meal_screen.dart';
import 'package:meals/screens/category_screen.dart';
import 'package:meals/screens/filters.dart';
import 'package:meals/widgets/main_drawer.dart';
import 'package:meals/provider/filters_provider.dart';

final List<Meal> favorites = [];

bool isFavorite(Meal meal) {
  return (favorites.contains(meal));
}

class TabScreen extends StatefulWidget {
  const TabScreen({super.key});

  @override
  State<TabScreen> createState() {
    return _TabScreenState();
  }
}

class _TabScreenState extends State<TabScreen> {
  int activePageIndex = 0;
  String activePageTitle = 'Categories';

  void chooseFromDrawer(String selection) async {
    if (selection == 'meals') {
      Navigator.of(context).pop();
    } else {
      //navigate to filters screen
      Navigator.of(context).pop();
      await Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(
          builder: (context) => Filters(),
          //pushreplacement exists fyi
        ),
      );
    }
  }

  // void toggleFavorite(Meal meal) {
  //   setState(() {
  //     ScaffoldMessenger.of(context).clearSnackBars();
  //     if (favorites.contains(meal)) {
  //       favorites.remove(meal);
  //       ScaffoldMessenger.of(
  //         context,
  //       ).showSnackBar(
  //         SnackBar(
  //           duration: Duration(seconds: 2),
  //           content: Text('Removed from favorites'),
  //         ),
  //       );
  //     } else {
  //       favorites.add(meal);
  //       ScaffoldMessenger.of(
  //         context,
  //       ).showSnackBar(
  //         SnackBar(
  //           duration: Duration(seconds: 2),
  //           content: Text('Added to favorites'),
  //         ),
  //       );
  //     }
  //   });
  // }

  void selectPage(int index) {
    setState(() {
      activePageIndex = index;
      if (index == 1) {
        activePageTitle = 'Favorites';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget activePageBody = CategoryScreen();

    if (activePageIndex == 1) {
      activePageBody = CategoryMealScreen.favorites();
    } else {
      activePageIndex = 0;
      activePageTitle = 'Categories';
      activePageBody = CategoryScreen();
    }

    return Scaffold(
      drawer: MainDrawer(chooseFromDrawer),
      appBar: AppBar(title: Text(activePageTitle)),
      bottomNavigationBar: BottomNavigationBar(
        //highlights the right button
        currentIndex: activePageIndex,
        //ontap has a built in index
        onTap: selectPage,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.dining),
            label: 'Categories',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favorites'),
        ],
      ),
      body: activePageBody,
    );
  }
}
