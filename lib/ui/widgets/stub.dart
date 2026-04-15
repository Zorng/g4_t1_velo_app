import 'package:flutter/material.dart';

class Stub extends StatelessWidget {
  final String title;
  const Stub({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title),),
      body: Padding(padding: const EdgeInsetsGeometry.all(20), child: Center(child: Text("$title comming soon"),),),
    );
  }
}