import 'package:flutter/material.dart';
import 'package:home_tracking_app/ScaffoldItems/scaffold_appbar.dart';
import 'wave_design.dart';
import 'ScaffoldItems/scaffold_drawer.dart';

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
        child: const AppBarForMainScaffold(pageName: "Home"),
      ),
      drawer: const DrawerForMainScaffold(),
      body: Stack(
        children: <Widget>[
          // Background Wave design
          BackgroundWave(waveHeight: 300, waveColor: const Color.fromARGB(255, 143, 201, 78).withOpacity(0.2)),
          BackgroundWave(waveHeight: 225, waveColor: const Color.fromARGB(255, 143, 201, 78).withOpacity(0.4)),
          BackgroundWave(waveHeight: 150, waveColor: const Color.fromARGB(255, 143, 201, 78).withOpacity(0.6)),

          // Main content section
          Padding(
            padding: EdgeInsets.only(
              left: screenWidth * 0.05,
              right: screenWidth * 0.05,
              top: screenHeight * 0.04,
              bottom: screenHeight * 0.025,
            ),
            child: Column(
              children: [
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Welcome Back Ashleigh",
                    textScaler: TextScaler.linear(1.2), // Use textScaleFactor instead of textScaler
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                const Divider(
                  color: Colors.black,
                  thickness: 1,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        radius: 80,
                        child: Icon(Icons.person, size: 100),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Text(
                              "Your Update",
                              style: TextStyle(decoration: TextDecoration.underline),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.edit, size: 20),
                            ),
                          ],
                        ),
                        const Text(
                          "Nothing To Report Today!",
                          softWrap: true,
                          overflow: TextOverflow.visible,
                        ),
                      ],
                    ),
                  ],
                ),
                const Divider(
                  color: Colors.black,
                  thickness: 1,
                ),
                SizedBox(
                  height: screenHeight * 0.25,
                  child: PageView.builder(
                    itemCount: 5,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Container(
                        width: screenWidth * 0.5,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Colors.grey
                        ),
                        margin: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Text(index.toString()),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
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
        onPressed: () {},
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
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.amber,
      ),
    );
  }
}
