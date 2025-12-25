import 'package:flutter/material.dart';
import 'package:meal_app/categories/models/category.dart';

class CategoryGridItem extends StatelessWidget {
  final Category category;
  final void Function() onSelectCategory;

  const CategoryGridItem({
    super.key,
    required this.category,
    required this.onSelectCategory,
  });

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(12);

    return Material(
      color: Colors.transparent,
      borderRadius: radius,
      clipBehavior:
          Clip.antiAlias, // ensures ripple is clipped to rounded corners
      child: InkWell(
        borderRadius: radius,
        onTap: () {
          debugPrint("Category ${category.title} tapped!");
          onSelectCategory();
        },
        splashColor: Theme.of(context).colorScheme.primary.withOpacity(0.25),
        child: Ink(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [category.color.withOpacity(0.5), category.color],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: radius,
          ),
          child: Center(
            child: Text(
              category.title,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Theme.of(context).colorScheme.onBackground,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
