import 'package:desafio_flutter/providers/series_bloc.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    
    final dynamic serie = ModalRoute.of(context)?.settings.arguments ?? 'no-serie'; 
    return Scaffold(
      appBar: AppBar(
        title: Text(serie['name']),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _PosterTitle(instanceSerie:serie),
            // ignore: prefer_interpolation_to_compose_strings
            const ListTile(title:Text('> Days On Air:')),
            _DaysOnAir(serie:serie),
            // ignore: prefer_interpolation_to_compose_strings
            const ListTile(title:Text('> Genres:')),
            _Genres(serie: serie),
            // ignore: prefer_interpolation_to_compose_strings
            const ListTile(title:Text('> Summary:')),
            _Descripcion(descripcion:serie['summary']),
            const ListTile(title:Text('> Seasons:')),
            _SeasonsList(idShow:serie['id'].toString())
          ]
        )
      )
    );
  }
}

class _PosterTitle extends StatelessWidget {
  
  final dynamic instanceSerie;

  const _PosterTitle({required this.instanceSerie});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top:20),
      padding:const EdgeInsets.symmetric(horizontal: 30),
      child:Row(
        children: [
          ClipRRect(
            child: FadeInImage(
              placeholder: const AssetImage('assets/loading1.gif'),
              image: NetworkImage(instanceSerie['image']['original']),
              height: 170,
            )
          ),
          const SizedBox(width: 20),
          Flexible(
            child: Text(
              instanceSerie['name'],
              maxLines: 2,
              overflow: TextOverflow.visible,
            )
          )
        ]
      )
    );
  }
}

class _DaysOnAir extends StatelessWidget {

  final dynamic serie;

  const _DaysOnAir({required this.serie});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 10),
      child:Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:[
          ...serie["schedule"]["days"].map((ep,)=> Text('\u2022 $ep')
          ).toList()
        ]
      )
    );
  }
}
class _Descripcion extends StatelessWidget {

  final String descripcion;

  const _Descripcion({required this.descripcion});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 10),
      child: Text(
        descripcion,
        textAlign: TextAlign.justify
      )
    );
  }
}

class _Genres extends StatelessWidget {

  final dynamic serie;

  const _Genres({required this.serie});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 10),
      child:Column( 
        crossAxisAlignment: CrossAxisAlignment.start,
        children:[
          ...serie["genres"].map((ep,)=> Text('\u2022 $ep')
          ).toList()
        ]
      )
    );
  }
} 

class _SeasonsList extends StatelessWidget {
  final String idShow;

  const _SeasonsList({required this.idShow});

  @override
  Widget build(BuildContext context) {

    final seasonsBloc= SeasonsBloc(idShow:idShow);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
      child:StreamBuilder(
        stream:seasonsBloc.getSeasons,
        builder: ( _ , AsyncSnapshot<List<dynamic>> snapshot){

          final season = snapshot.data ?? [ ];
          
          return ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: season.length,
              itemBuilder: (_, i ){
                return ListTile(
                  onTap: () => Navigator.pushNamed(context,'season',arguments:season[i]),
                  title:Text('Season: ${i+1}'),
                  trailing: const Icon(Icons.arrow_forward_ios_outlined)
                );
              }
          );
        }
      )
    );
  }
}

