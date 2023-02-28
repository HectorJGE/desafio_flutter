import 'package:desafio_flutter/providers/series_bloc.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  final seriesBloc= SeriesBloc();

  HomeScreen({super.key});

  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("TV Series"),
        actions:[
          IconButton(
            icon: const Icon(Icons.search_outlined),
            onPressed: () {}
          ,)
        ],
      ),
      
      body: Column(
        children: [
          Expanded(
              child:StreamBuilder(
                stream:seriesBloc.getSeries,
                builder: ( _ , AsyncSnapshot<List<dynamic>> snapshot){

                  final series = snapshot.data ?? [ ];
                  
                  return ListView.builder(
                      itemCount: series.length,
                      itemBuilder: (_, i ){
                        return _SerieContainer(instanceSerie:series[i]);
                      }
                  );
                }
              )
          )
        ]
      )
    );
  }
}

class _SerieContainer extends StatelessWidget {

  final dynamic instanceSerie;

  const _SerieContainer({required this.instanceSerie});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context,'details',arguments:instanceSerie),
      child: Container(
        margin:const EdgeInsets.symmetric(vertical: 1),
        color:const Color.fromARGB( 255, 255, 241, 201 ),
        child:Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.all(10),
              child: FadeInImage(
                placeholder: const AssetImage('assets/loading1.gif'),
                image: NetworkImage(instanceSerie['image']['original']),
                width: 80,
                height: 110,
                fit:BoxFit.cover,
              ),
            ),
            
            Flexible(
              child: Text(
                instanceSerie['name'],
                maxLines: 3,
                overflow: TextOverflow.visible,
              )
            )
          ]
        ),
      )
    );
  }
}
