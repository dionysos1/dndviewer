import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'home.dart';
import 'monster_list_provider.dart';
import 'monster_provider.dart';

void main() {
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => GetMonsterList()),
        ChangeNotifierProvider(create: (_) => GetMonster())
      ],
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.blueGrey,
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'DnD Monster viewer'),
    );
  }
}