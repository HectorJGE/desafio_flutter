import 'package:flutter/material.dart';

class EpisodeScreen extends StatelessWidget {
  const EpisodeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dynamic episode = ModalRoute.of(context)?.settings.arguments ?? {}; 
    String urlImg;
    if(episode['image'] != null){
      urlImg= episode['image']['original'];
    }else{
      urlImg= 'https://www.classify24.com/wp-content/uploads/2015/11/no-image.png';
    }
    return Scaffold(
        appBar: AppBar(
          title: Text("Episode ${episode['number']}"),
        ),
        body:  SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _Dato(titulo:'Name: ',texto:episode['name']),
            _Dato(titulo:'Number: ',texto:episode['number'].toString()),
            _Dato(titulo:'Season: ',texto:episode['season'].toString()),
            _Dato(titulo:'Summary: ',texto:episode['summary']??'-'),
            _Imagen(urlImg: urlImg)

            
          ]
        )
      )
      );
  }
}

class _Dato extends StatelessWidget {
  final String titulo;
  final String texto;

  const _Dato({required this.titulo,required this.texto});

  @override
  Widget build(BuildContext context) {
    return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(titulo,style: const TextStyle(fontWeight: FontWeight.bold)),
                  Text(texto,style: const TextStyle())
                ],
              ),
            );
  }
}

class _Imagen extends StatelessWidget {
  final String urlImg;

  const _Imagen({required this.urlImg});

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Image',style: TextStyle(fontWeight: FontWeight.bold)),
          FadeInImage(
            placeholder: const AssetImage('assets/loading1.gif'),
            image: NetworkImage(urlImg),
            width: double.infinity,
          )
      ],)
        
    );
    
  }
}