import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'misc/custom_monster_helper.dart';
import 'misc/favo_helper.dart';
import 'views/home.dart';
import 'controllers/monster_list_provider.dart';
import 'controllers/monster_provider.dart';

void main() {
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => GetMonsterList()),
        ChangeNotifierProvider(create: (_) => GetMonster()),
        ChangeNotifierProvider(create: (_) => FavoriteController()),
        ChangeNotifierProvider(create: (_) => CustomMonsterController()),
      ],
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DnD Monster viewer',
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.blueGrey,
        useMaterial3: true,
      ),
      home: const HomeView(startIndex: 0, ),
    );
  }
}