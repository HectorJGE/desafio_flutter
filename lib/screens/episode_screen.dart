import 'package:flutter/material.dart';

class EpisodeScreen extends StatelessWidget {
  const EpisodeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dynamic episode = ModalRoute.of(context)?.settings.arguments ?? {}; 
    return Scaffold(
        appBar: AppBar(
          title: Text("Episode ${episode['number']}"),
        ),
        body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Nombre: ${episode['name']}')
          ]
        )
      )
      );
  }
}
