import 'package:flutter/material.dart';

import 'screens/screens.dart';


void main() => runApp( const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Series TV',
        initialRoute: 'home',
        routes:{
          'home': ( _ ) => const HomeScreen(),
          'details': ( _ ) => const DetailScreen(),
          'season': ( _ ) => const SeasonScreen(),
          'episode': ( _ ) => const EpisodeScreen(),
        },
        theme:ThemeData.light().copyWith(
          appBarTheme: AppBarTheme(
            color:Colors.amber[600]
          )
        ),
      );
  }

}

