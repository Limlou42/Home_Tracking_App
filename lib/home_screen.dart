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

      body: Container(
        decoration: const BoxDecoration(
          color: Colors.white, // Background color of the scaffold
        ),
        child: Stack(
          children: <Widget>[
            BackgroundWave(waveHeight: 300, waveColor: const Color.fromARGB(255, 143, 201, 78).withOpacity(0.2)),
            BackgroundWave(waveHeight: 225, waveColor: const Color.fromARGB(255, 143, 201, 78).withOpacity(0.4)),
            BackgroundWave(waveHeight: 150, waveColor: const Color.fromARGB(255, 143, 201, 78).withOpacity(0.6)),
          ],
        ),
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


class BackgroundWave extends StatelessWidget {
  final double waveHeight;
  final Color waveColor;
  const BackgroundWave({super.key, required this.waveHeight, required this.waveColor});

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Align(
        alignment: Alignment.bottomCenter,
        child: ClipPath(
          clipper: WaveClipper(),
          child: Container(
            height: waveHeight,
            color: waveColor, // Third layer color
          ),
        ),
      ),
    );
  }
}

//TODO: Research this more
class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();

    // Start from top-left
    path.moveTo(0.0, 0.0);

    // First curve (wave starts at the top-left)
    var firstControlPoint = Offset(size.width / 4, 80);  // Increase the height here for a bigger curve
    var firstEndPoint = Offset(size.width / 2, 40);

    // Second curve (wave goes up on the right)
    var secondControlPoint = Offset(size.width * 3 / 4, 0);
    var secondEndPoint = Offset(size.width, 60);  // Ensure this point is not cut off

    // Draw curves
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy, firstEndPoint.dx, firstEndPoint.dy);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy, secondEndPoint.dx, secondEndPoint.dy);

    // Fill the rest of the path downwards
    path.lineTo(size.width, size.height);  // Go to bottom-right
    path.lineTo(0.0, size.height);         // Go to bottom-left
    path.close();                          // Close the path
    
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}



