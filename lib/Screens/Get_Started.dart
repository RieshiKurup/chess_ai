// ignore: file_names
import 'package:flutter/material.dart';

class GetStarted extends StatefulWidget {
  const GetStarted({super.key});

  @override
  State<GetStarted> createState() => _GetStartedState();
}

class _GetStartedState extends State<GetStarted> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[850],
        titleTextStyle: TextStyle(color: Color.fromARGB(255, 241, 239, 241)),
        title: Text('Sovereign Squares'),
        centerTitle: true,
        elevation: 40,
      ),
      // ignore: avoid_unnecessary_containers
      body: Container(
        child: Text('GET STARTED!'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {  },
          child: Text('LOGIN'),
        ),
    );
  }
}