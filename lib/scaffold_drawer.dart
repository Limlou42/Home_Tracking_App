import 'package:home_tracking_app/bills_tracking_page.dart';
import 'package:home_tracking_app/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:home_tracking_app/WorkTrackingFiles/work_schedule_page.dart';
import 'FoodTrackingFiles/food_tracker_page.dart';

class DrawerForMainScaffold extends StatelessWidget {
  const DrawerForMainScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      
      child: ListView(
        children: const [
          DrawerPageTile(
            pageName: "Main Menu",
            icon: Icon(Icons.home),
            destinationPage: HomeScreen(),
          ),
          DrawerPageTile(
            pageName: "Food Tracker",
            icon: Icon(Icons.food_bank),
            destinationPage: FoodTrackerPage(),
          ),
          DrawerPageTile(
            pageName: "Work Management",
            icon: Icon(Icons.work),
            destinationPage: WorkSchedulePage(),
          ),
          DrawerPageTile(
            pageName: "Money And Bills",
            icon: Icon(Icons.attach_money),
            destinationPage: BillsTrackingPage(),
          ),
          DrawerPageTile(
            pageName: "Calendar",
            icon: Icon(Icons.calendar_month),
            destinationPage: FoodTrackerPage(),
          ),
          SizedBox(
            height: 430,
          ),
          DrawerSettingsButton()
        ],
      ),
    );
  }
}

class DrawerPageTile extends StatelessWidget {
  final String pageName;
  final Icon icon;
  final Widget destinationPage;
  const DrawerPageTile(
      {super.key,
      required this.pageName,
      required this.icon,
      required this.destinationPage});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: icon,
      title: Text(pageName),
      onTap: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => destinationPage),
        );
      },
    );
  }
}

class DrawerSettingsButton extends StatelessWidget {
  const DrawerSettingsButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: FloatingActionButton(
          onPressed: () {},
          shape: const CircleBorder(),
          child: const Icon(Icons.settings),
        ),
      ),
    );
  }
}
