import 'package:flutter/material.dart';
import 'package:flutter_hello_world/provider/tmb_provider.dart';
import 'package:flutter_hello_world/screen/tmb_screen.dart';
import 'screen/cars_list_screen.dart';
import 'package:provider/provider.dart';
import 'provider/car_provider.dart';
import 'provider/joke_provider.dart';
import 'screen/joke_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CarProvider()..fetchCars()),
        ChangeNotifierProvider(create: (_) => JokeProvider()..fetchNewJoke()),
        ChangeNotifierProvider(create: (_) => TmbProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'P5d API Cars',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: TmbScreen(),
    );
  }
}

