import 'package:flutter/material.dart';
import 'package:meals/models/category.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/widgets/meal_trait.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:meals/screens/meal_screen.dart';

class MealCard extends StatelessWidget {
  MealCard(
    this.meal,
    this.category,
    this.isFavorite,
    this.toggleFavorite, {
    super.key,
  });
  Category category;
  Meal meal;
  final bool Function(Meal meal) isFavorite;
  final void Function(Meal meal) toggleFavorite;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      clipBehavior: Clip.hardEdge,
      //clip hardedge prevents anything from leaving the constraints
      elevation: 2, // elevation just adds a drop shadow
      child: Stack(
        //stack allows widgets on top of each other
        children: [
          FadeInImage(
            //cover makes sure it covers the whole box with as little zoom as possible (most visible)
            fit: BoxFit.cover,
            placeholder: MemoryImage(kTransparentImage),
            image: NetworkImage(meal.imageUrl),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.all(10),
              color: const Color.fromARGB(180, 0, 0, 0),
              child: Column(
                children: [
                  Text(
                    meal.title,
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //to show info with icons i made a custom widget
                      MealTrait.duration(
                        meal.duration.toString(),
                      ),
                      MealTrait.complexity(meal.complexity),
                      MealTrait.affordability(meal.affordability),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 0,
            bottom: 0,
            left: 0,
            right: 0,
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                //makes stuff touch and reactive
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (ctx) =>
                          MealScreen(meal, isFavorite, toggleFavorite),
                    ),
                  );
                },
                splashColor: category.color.withAlpha(100),
                //borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
