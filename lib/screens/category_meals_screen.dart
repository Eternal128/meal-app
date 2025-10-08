import 'dart:math';
import 'package:flutter/material.dart';
import 'package:meal_app/widgets/meal_item.dart';
import '../dummy_data.dart';
import '../models/meal.dart';
import 'dart:math';

class CategoryMealsScreen extends StatefulWidget {
  static const routeName = '/category-meals';

  static Color randomOpaqueColor() {
    return Color(Random().nextInt(0xffffffff)).withAlpha(0xff);
  }

  final List<Meal> availableMeals;

  CategoryMealsScreen(this.availableMeals);

  @override
  State<CategoryMealsScreen> createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  String? categoryTitle;
  List<Meal>? displayedMeals;

  final List<Color> colors = [
    const Color.fromARGB(255, 9, 2, 56),
    const Color.fromARGB(255, 6, 34, 48),
    const Color.fromARGB(255, 15, 62, 50),
    const Color.fromARGB(255, 2, 61, 100),
    const Color.fromARGB(255, 51, 2, 86),
    const Color.fromARGB(255, 33, 2, 105),
    const Color.fromARGB(255, 27, 2, 81),
    const Color.fromARGB(255, 1, 88, 14),
    const Color.fromARGB(255, 98, 8, 8),
    const Color.fromARGB(255, 88, 86, 16),
    const Color.fromARGB(255, 80, 1, 63),
    const Color.fromARGB(255, 45, 76, 3),
    const Color.fromARGB(255, 78, 18, 78),
    const Color.fromARGB(255, 72, 2, 2),
    const Color.fromARGB(255, 80, 32, 32),
  ];

  Random random = Random();


  @override
  void didChangeDependencies() {
    final routeArgs = ModalRoute.of(context)?.settings.arguments as Map<String, String>;
    categoryTitle = routeArgs['title'];
    final categoryId = routeArgs['id'];
    displayedMeals = widget.availableMeals.where((meal) {
      return meal.categories.contains(categoryId);
    }).toList();
    super.didChangeDependencies();
  }

  void _removeMeal(String mealId){
    setState(() {
      displayedMeals?.removeWhere((meal) => meal.id == mealId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(categoryTitle!),
        backgroundColor: colors[random.nextInt(colors.length)],
      ),
      body: ListView.builder(
        itemBuilder: (ctx, index) {
          return MealItem(
            id: displayedMeals![index].id,
            title: displayedMeals![index].title,
            imageUrl: displayedMeals![index].imageUrl,
            affordability: displayedMeals![index].affordability,
            complexity: displayedMeals![index].complexity,
            duration: displayedMeals![index].duration,
          );
        },
        itemCount: displayedMeals?.length,
      ),
    );
  }
}
