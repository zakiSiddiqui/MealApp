import 'package:flutter/material.dart';
import 'package:meal_app/categories/categories.dart';
import 'package:meal_app/meals/meal_screen.dart';
import 'package:meal_app/providers/meals_provider.dart';
import 'package:meal_app/tabs/filters_screens.dart';
import 'package:meal_app/tabs/main_drawer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meal_app/providers/favorites_provider.dart';
import 'package:meal_app/providers/filters_provider.dart';

Map<Filter, bool> kInitialFilters = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegetarian: false,
  Filter.vegan: false,
};

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  int _selectedIndex = 0;

  void _selectTab(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _setScreen(String identifier) async {
    Navigator.of(context).pop();
    if (identifier == 'filters') {
      await Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(builder: (ctx) => FiltersScreens()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final availableMeals = ref.watch(filterMealsProvider);

    Widget activeTab = CategoriesScreen(availableMeals: availableMeals);
    var activeTitle = 'Categories';

    if (_selectedIndex == 1) {
      final favoriteMeals = ref.watch(favoritesProvider);
      activeTab = MealScreen(meals: favoriteMeals);
      activeTitle = 'Your Favorites';
    }

    return Scaffold(
      appBar: AppBar(title: Text(activeTitle)),
      body: activeTab,
      drawer: MainDrawer(onSelectScreen: _setScreen),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectTab,
        currentIndex: _selectedIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Categories',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favorites'),
        ],
      ),
    );
  }
}
