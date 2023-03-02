import 'package:desafio_flutter/providers/series_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'screens/screens.dart';


void main() => runApp( const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers:const [
      ],
      child: MaterialApp(
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
      ),
    );
  }
}
