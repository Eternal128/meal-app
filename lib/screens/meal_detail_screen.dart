import 'package:flutter/material.dart';
import '../models/meal.dart';
import '../dummy_data.dart';
import 'dart:math';

class MealDetailScreen extends StatelessWidget {
  static const routeName = '/meal-detail';
  Random random = Random();
  static Color randomOpaqueColor() {
    return Color(Random().nextInt(0xffffffff)).withAlpha(0xff);
  }

   static const foodIcons = <IconData> [
    Icons.restaurant,
    Icons.restaurant_menu,

  ];

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

  final Function toggleFavorite;
  final Function isFavorite;

  MealDetailScreen(this.toggleFavorite, this.isFavorite);


  Widget buildSectionTitle(BuildContext context, String text) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
          fontFamily: 'RobotoCondensed',
        ),
      ),
    );
  }

  Widget buildContainer(Widget child) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: colors[random.nextInt(colors.length)]),
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      height: 200,
      width: 300,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final mealId = ModalRoute.of(context)?.settings.arguments as String;
    final selectedMeal = DUMMY_MEALS.firstWhere(((meal) => meal.id == mealId));
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(selectedMeal.title),
        backgroundColor: colors[random.nextInt(colors.length)],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 300,
              width: double.infinity,
              child: Image.network(
                selectedMeal.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            buildSectionTitle(context, "Ingredients"),
            buildContainer(
              ListView.builder(
                itemBuilder: (ctx, index) => Card(
                  color: Colors.amber,
                  child: Column(
                    children: [
                      ListTile(
                        //ListTile used to display some text and an icon or other widget.
                        leading: Icon(
                          foodIcons[index % 2],
                          color: Colors.black87,
                        ),
                        title: Text(
                          selectedMeal.ingredients[index],
                        ),
                      ),
                      // const Divider(color: Colors.amber),
                    ],
                  ),
                ),
                itemCount: selectedMeal.ingredients.length,
              ),
            ),
            // buildContainer(
            //   ListView.builder(
            //     itemBuilder: (ctx, index) => Card(
            //         color: Theme.of(context).accentColor,
            //         child: Padding(
            //           padding: const EdgeInsets.symmetric(
            //             vertical: 5,
            //             horizontal: 10,
            //           ),
            //           child: Text(
            //             selectedMeal.ingredients[index],
            //           ),
            //         )),
            //     itemCount: selectedMeal.ingredients.length,
            //   ),
            // ),
            buildSectionTitle(context, "Steps"),
            buildContainer(
              ListView.builder(
                itemBuilder: (ctx, index) => Column(
                  children: [
                    ListTile(
                      //ListTile used to display some text and an icon or other widget.
                      leading: CircleAvatar(
                        child: Text('# ${index + 1}'),
                      ),
                      title: Text(
                        selectedMeal.steps[index],
                      ),
                    ),
                    const Divider(color: Colors.amber),
                  ],
                ),
                itemCount: selectedMeal.steps.length,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => toggleFavorite(mealId),
        child: Icon(
          isFavorite(mealId) ? Icons.star : Icons.star_border,
        ),
      ),
    );
  }
}
