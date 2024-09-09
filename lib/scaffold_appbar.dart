import 'package:flutter/material.dart';

class AppBarForMainScaffold extends StatelessWidget {
  const AppBarForMainScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 143, 201, 78),
        borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            spreadRadius: 1.5,
            blurRadius: 2,
            offset: const Offset(0, 2)
          )
        ]
      ),
      child: AppBar(
        title: const Text("Bills Tracking", textScaler: TextScaler.linear(1.2), style: TextStyle(fontWeight: FontWeight.bold),),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        leading: Builder(
          builder: (context) {
            return IconButton(
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              icon: const Icon(Icons.menu)
            );
          }
        ),
        actions: [
          IconButton(onPressed: (){}, icon: const Center(child: Icon(Icons.add, size: 35, color: Colors.black,)),)
        ],
      ),
    
    );
  }
}