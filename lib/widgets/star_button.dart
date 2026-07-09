import 'package:flutter/material.dart';
import 'package:meals/models/meal.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/screens/tabs.dart';
import 'package:meals/provider/favorites_provider.dart';

class StarButton extends ConsumerWidget {
  const StarButton(this.meal, {super.key});
  final Meal meal;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IconButton(
      icon: ref.watch(FavoritesProvider).contains(meal)
          //isfavorite wouldnt work but this does
          ? Icon(Icons.star)
          : Icon(Icons.star_border),

      onPressed: () {
        ref.read(FavoritesProvider.notifier).toggleFavorite(meal);
      },
    );
  }
}
