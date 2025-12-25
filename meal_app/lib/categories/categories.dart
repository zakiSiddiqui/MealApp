import 'package:flutter/material.dart';
import 'package:meal_app/data/dummy_data.dart';
import 'package:meal_app/categories/category_grid_item.dart';
import 'package:meal_app/meals/meal_screen.dart';
import 'package:meal_app/categories/models/category.dart';
import 'package:meal_app/meals/meal.dart';

class CategoriesScreen extends StatelessWidget {
  final List<Meal> availableMeals;
  const CategoriesScreen({super.key, required this.availableMeals});

  void _selectCategory(BuildContext context, Category category) {
    final meals = availableMeals
        .where((meal) => meal.categories.contains(category.id))
        .toList();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (ctx) => MealScreen(title: category.title, meals: meals),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GridView(
      padding: const EdgeInsets.all(24),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
      children: [
        for (final category in availableCategories)
          CategoryGridItem(
            category: category,
            onSelectCategory: () {
              _selectCategory(context, category);
            },
          ),
      ],
    );
  }
}
