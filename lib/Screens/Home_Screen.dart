import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple[900],
        elevation: 10,
        title: Text('Sovereign Squares'),
        centerTitle: true,
       actions: [],
      ),
      body: Container(
        child: Center(
          child: Text('Home Screen'),
        ),
      ),
    );
  }
}
