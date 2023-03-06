import 'package:desafio_flutter/bloc/seasons/seasons_bloc.dart';
import 'package:desafio_flutter/providers/api_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
            _SeasonsList(idShow:serie['id'])
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
    String urlImg = '';
    if(instanceSerie['image'] != null){
      urlImg= instanceSerie['image']['original'];
    }else{
      urlImg= 'https://www.classify24.com/wp-content/uploads/2015/11/no-image.png';
    }
    return Container(
      margin: const EdgeInsets.only(top:20),
      padding:const EdgeInsets.symmetric(horizontal: 30),
      child:Row(
        children: [
          ClipRRect(
            child: FadeInImage(
              placeholder: const AssetImage('assets/loading1.gif'),
              image: NetworkImage(urlImg),
              height: 170,
              width: 123,
              fit:BoxFit.cover,
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

class _SeasonsList extends StatefulWidget {
  final int idShow;
  const _SeasonsList({required this.idShow});

  State<_SeasonsList> createState() => __SeasonsListState(idShow: idShow);
}

class __SeasonsListState extends State<_SeasonsList> {
  final int idShow;
  late final SeasonsBloc _seasonsBloc;
  __SeasonsListState({required this.idShow});


  @override 
  void initState(){
    _seasonsBloc=SeasonsBloc(idShow:idShow);
    _seasonsBloc.add(FetchSeasons());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
      child:_builtListSeries()
    );
  }
  Widget _builtListSeries () {
    return Container(
      margin:const EdgeInsets.all(8.0),
      child: BlocProvider(
        create: (_) => _seasonsBloc,
        child:BlocListener <SeasonsBloc,SeasonsState> (
          listener: (context, state){
            if(state is SeasonsNotLoaded) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.errorMessage??'Error'))
              );
            }
          },
          child:BlocBuilder<SeasonsBloc,SeasonsState>(
            builder: (context, state){
              if(state is InitialSeasonsState){
                return _buildLoading();
              }else if (state is SeasonsLoading){
                return _buildLoading();
              }else if (state is SeasonsLoaded){
                return SingleChildScrollView(
                  child: Column(
                    children:
                      List.generate(state.seasons.length, (index) => 
                        ListTile(
                          onTap: () => Navigator.pushNamed(context,'season',arguments:state.seasons[index]),
                          title:Text('Season: ${index+1}'),
                          trailing: const Icon(Icons.arrow_forward_ios_outlined)
                        )
                      )
                  )
                );
              }else if (state is SeasonsNotLoaded){
                return Container();
              }else {
                return Container();
              }
            })
        ),
      )
    );
  }
  Widget _buildLoading() => const Center(child:CircularProgressIndicator());
}

