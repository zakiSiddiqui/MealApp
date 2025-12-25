import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:meal_app/meals/meal.dart';

class FavoriteMealsNotifier extends StateNotifier<List<Meal>> {
  FavoriteMealsNotifier() : super([]);

  bool toggleMealFavoriteStatus(Meal currentMeal) {
    final isMealFavorite = state.contains(currentMeal);
    if (isMealFavorite) {
      state = state.where((meal) => meal.id != currentMeal.id).toList();
      return false;
    } else {
      state = [...state, currentMeal];
      return true;
    }
  }
}

final favoritesProvider =
    StateNotifierProvider<FavoriteMealsNotifier, List<Meal>>((ref) {
      return FavoriteMealsNotifier();
    });
