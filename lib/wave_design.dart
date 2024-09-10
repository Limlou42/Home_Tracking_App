import 'package:flutter/material.dart';

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
