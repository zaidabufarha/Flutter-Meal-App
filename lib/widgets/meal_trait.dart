import 'package:flutter/material.dart';
import 'package:meals/models/meal.dart';

String getCapitalized(String input) {
  return input[0].toUpperCase() + input.substring(1);
}

class MealTrait extends StatelessWidget {
  MealTrait.duration(this.label, {super.key}) {
    icon = Icon(Icons.access_time);
  }
  MealTrait.affordability(
    Affordability affordability, {
    super.key,
  }) {
    icon = Icon(Icons.attach_money);
    label = getCapitalized(affordability.name);
  }
  MealTrait.complexity(Complexity complexity, {super.key}) {
    icon = Icon(Icons.soup_kitchen);
    label = getCapitalized(complexity.name);
  }
  Icon? icon;
  String? label;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          icon!,

          Text(
            label!,
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
