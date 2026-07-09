import 'package:flutter/material.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/widgets/star_button.dart';
import 'package:transparent_image/transparent_image.dart';

class MealScreen extends StatelessWidget {
  MealScreen(this.meal, {super.key});

  Meal meal;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [StarButton(meal)],
        backgroundColor: Colors.black,
        title: Text(meal.title),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10),
        child: Column(
          spacing: 5,
          children: [
            FadeInImage(
              placeholder: MemoryImage(kTransparentImage),
              image: NetworkImage(meal.imageUrl),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Ingredients:',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            for (String ingredient in meal.ingredients)
              Text(
                ingredient,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: const Color.fromARGB(128, 255, 255, 255),
                  fontSize: 15,
                ),
              ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Steps:',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            for (String step in meal.steps)
              Text(
                step,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: const Color.fromARGB(128, 255, 255, 255),
                  fontSize: 15,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
