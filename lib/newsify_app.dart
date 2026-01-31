import 'package:flutter/material.dart';
import 'package:newsify_app/feature/home/presentation/screen/home_screen.dart';

class NewsifyApp extends StatelessWidget {
  const NewsifyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

