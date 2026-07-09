// a single mom who works 2 jobs
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/data/dummy_data.dart';

final mealListProvider = Provider((ref) {
  return dummyMeals;
});
