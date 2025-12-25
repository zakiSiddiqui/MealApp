import 'package:flutter/material.dart';
import 'package:meal_app/meals/meal.dart';
import 'package:meal_app/meals/meal_item.dart';
import 'package:meal_app/data/dummy_data.dart';
import 'package:meal_app/categories/models/category.dart';
import 'package:meal_app/meals/meal_details_screen.dart';

class MealScreen extends StatelessWidget {
  final String? title;
  final List<Meal> meals;

  const MealScreen({super.key, this.title, required this.meals});

  void _selectMeal(BuildContext context, Meal meal) {
    debugPrint("in the select meal function");
    Navigator.push(
      context,
      MaterialPageRoute(builder: (ctx) => MealDetailScreen(meal: meal)),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget content = ListView.builder(
      itemCount: meals.length,
      itemBuilder: (ctx, index) => MealItem(
        meal: meals[index],
        onSelectMeal: (meal) {
          _selectMeal(context, meal);
        },
      ),
    );
    if (meals.isEmpty) {
      content = Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Uh oh ... nothing here!',
              style: Theme.of(
                context,
              ).textTheme.headlineLarge!.copyWith(color: Colors.white),
            ),
            const SizedBox(height: 16),
            Text(
              'Try selecting a different category!',
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: Theme.of(context).colorScheme.onBackground,
              ),
            ),
          ],
        ),
      );
    }

    if (title == null) {
      return content;
    }
    return Scaffold(
      appBar: AppBar(title: Text(title!)),
      body: content,
    );
  }
}
