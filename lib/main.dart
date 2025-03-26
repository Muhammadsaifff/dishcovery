import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meal Selection App',
      home: MealSelectionScreen(),
    );
  }
}

class MealSelectionScreen extends StatefulWidget {
  @override
  _MealSelectionScreenState createState() => _MealSelectionScreenState();
}

class _MealSelectionScreenState extends State<MealSelectionScreen> {
  String selectedMeal = 'No meal selected';

  void _navigateAndSelectMeal(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MealOptionsScreen()),
    );

    if (result != null && result is String) {
      setState(() {
        selectedMeal = result;
      });

      ScaffoldMessenger.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(SnackBar(content: Text('Selected Meal: $selectedMeal')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Meal Selection App')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Selected Meal: $selectedMeal', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _navigateAndSelectMeal(context),
              child: const Text('Select a Meal'),
            ),
          ],
        ),
      ),
    );
  }
}

class MealOptionsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Choose Your Meal')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MealButton(meal: 'Pizza', description: 'Cheesy and tasty.', context: context),
            MealButton(meal: 'Burger', description: 'Soft bun with patty.', context: context),
            MealButton(meal: 'Sushi', description: 'Rice with seafood.', context: context),
          ],
        ),
      ),
    );
  }
}

class MealButton extends StatelessWidget {
  final String meal;
  final String description;
  final BuildContext context;

  MealButton({required this.meal, required this.description, required this.context});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: SizedBox(
        width: 200,
        child: Tooltip(
          message: description,
          child: ElevatedButton(
            onPressed: () {
              Navigator.pop(this.context, meal);
            },
            child: Text(meal),
          ),
        ),
      ),
    );
  }
}
