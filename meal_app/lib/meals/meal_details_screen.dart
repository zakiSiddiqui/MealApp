import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meal_app/meals/meal.dart';
import 'package:meal_app/providers/favorites_provider.dart';

class MealDetailScreen extends ConsumerWidget {
  final Meal meal;

  const MealDetailScreen({super.key, required this.meal});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoriteMeals = ref.watch(favoritesProvider);

    final isFavorite = favoriteMeals.contains(meal);

    return Scaffold(
      appBar: AppBar(
        title: Text(meal.title),
        actions: [
          IconButton(
            icon: Icon(isFavorite ? Icons.star : Icons.star_border),
            onPressed: () {
              final isAdded = ref
                  .read(favoritesProvider.notifier)
                  .toggleMealFavoriteStatus(meal);

              ScaffoldMessenger.of(context).clearSnackBars();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  duration: const Duration(seconds: 1),
                  content: Text(
                    isAdded
                        ? 'Meal added to favorites.'
                        : 'Meal removed from favorites.',
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 300,
              width: double.infinity,
              child: Image.network(meal.imageUrl, fit: BoxFit.cover),
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  Text(
                    "Ingredients",
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  SizedBox(height: 14),
                  ...meal.ingredients.map(
                    (ingredient) => Text(
                      ingredient,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                    ),
                  ),
                  SizedBox(height: 24),
                  Text(
                    "Steps",
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  SizedBox(height: 24),
                  for (final step in meal.steps)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        step,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Theme.of(context).colorScheme.onBackground,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
