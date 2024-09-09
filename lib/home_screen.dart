import 'package:flutter/material.dart';
import 'package:home_tracking_app/scaffold_appbar.dart';
import 'scaffold_drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(screenWidth, screenHeight * 0.065), 
        child: const AppBarForMainScaffold()
      ),
      drawer: const DrawerForMainScaffold(),
      body: const Center(
        child: Column(
          children: [
            SizedBox(height: 20,),
            MainMenuFloatingButton(),
            SizedBox(height: 50,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MainMenuFloatingButton(),
                SizedBox(width: 30,),
                MainMenuFloatingButton(),
              ],
            ),
            SizedBox(height: 50,),
            PanelViewContainer(),
          ],
        ),
      )
    );
  }
}

class MainMenuFloatingButton extends StatelessWidget {
  const MainMenuFloatingButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      height: 150,
      child: ElevatedButton(
        child: const Text("Button One"),
        onPressed: (){},
      ),
    );
  }
}

class PanelViewContainer extends StatelessWidget {
  const PanelViewContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 170,
      width: 330,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colors.amber),
    );
  }
}