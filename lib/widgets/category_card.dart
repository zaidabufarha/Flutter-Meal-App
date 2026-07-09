import 'package:flutter/material.dart';
import 'package:meals/models/category.dart';

class CategoryCard extends StatelessWidget {
  CategoryCard(this.category, this.selectCategory, {super.key});
  final void Function(BuildContext context, Category category) selectCategory;
  Category category;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      //makes stuff touch and reactive
      onTap: () {
        selectCategory(context, category);
      },
      splashColor: category.color.withAlpha(100),
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [category.color, category.color.withAlpha(40)],
          ),
        ),
        child: Text(
          category.title,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
            color: Theme.of(context).colorScheme.onPrimaryContainer,
          ),
        ),
      ),
    );
  }
}
