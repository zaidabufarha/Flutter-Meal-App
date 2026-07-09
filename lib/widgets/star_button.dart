import 'package:flutter/material.dart';
import 'package:meals/models/meal.dart';

class StarButton extends StatefulWidget {
  const StarButton(this.meal, this.isFavorite, this.toggleFavorite, {super.key});
  final Meal meal;
  final bool Function(Meal meal) isFavorite;
  final void Function(Meal meal) toggleFavorite;
  @override
  State<StatefulWidget> createState() {
    return _StarButtonState();
  }
}

class _StarButtonState extends State<StarButton> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: widget.isFavorite(widget.meal)
          ? Icon(Icons.star)
          : Icon(Icons.star_border),

      onPressed: () {
        setState(() {
          widget.toggleFavorite(widget.meal);
        });
      },
    );
  }
}
