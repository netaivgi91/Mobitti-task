import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mobitti_task/providers/map_provider.dart';
import 'package:mobitti_task/providers/news_provider.dart';
import 'screens/map_screen.dart';
import 'screens/news_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => NewsModel()),
        ChangeNotifierProvider(create: (_) => MapModel()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => NewsScreen(),
        '/second': (context) => MapScreen(),
      },
    );
  }
}
