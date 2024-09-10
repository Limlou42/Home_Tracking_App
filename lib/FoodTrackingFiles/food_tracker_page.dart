import 'package:flutter/material.dart';
import '../ScaffoldItems/scaffold_drawer.dart';
import 'stored_foods_page.dart';

class FoodTrackerPage extends StatefulWidget {
  const FoodTrackerPage({super.key});

  @override
  State<FoodTrackerPage> createState() => _FoodTrackerPageState();
}

class _FoodTrackerPageState extends State<FoodTrackerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Food Tracker"),
      ),
      drawer: const DrawerForMainScaffold(),
      body: Center(
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const TrackStoredFoods()),
                );
              },
              child: Container(
                height: 170,
                width: 360,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colors.amber),
              ),
            ),
          ],
        ),
      )
    );
  }
}