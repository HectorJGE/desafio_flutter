import 'package:desafio_flutter/bloc/series/bloc/series_bloc.dart';
import 'package:desafio_flutter/models/serie.dart';
import 'package:desafio_flutter/providers/api_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../search/search_delegate.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final SeriesBloc _seriesBloc = SeriesBloc();

  @override 
  void initState(){
    _seriesBloc.add(FetchSeries());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("TV Series"),
        actions:[
          IconButton(
            icon: const Icon(Icons.search_outlined),
            onPressed: () => showSearch(context: context, delegate: SerieSearchDelegate())
          ,)
        ],
      ),
      body:_builtListSeries(),
    );
  }
  Widget _builtListSeries () {
    return Container(
      margin:const EdgeInsets.all(8.0),
      child: BlocProvider(
        create: (_) => _seriesBloc,
        child:BlocListener <SeriesBloc,SeriesState> (
          listener: (context, state){
            if(state is SeriesNotLoaded) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.errorMessage??'Error'))
              );
            }
          },
          child:BlocBuilder<SeriesBloc,SeriesState>(
            builder: (context, state){
              if(state is InitialSeriesState){
                return _buildLoading();
              }else if (state is SeriesLoading){
                return _buildLoading();
              }else if (state is SeriesLoaded){
                return _SerieContainer(serie:state.series);
              }else if (state is SeriesNotLoaded){
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

class _SerieContainer extends StatelessWidget {

  final Series serie;

  const _SerieContainer({required this.serie});

  @override
  Widget build(BuildContext context) {
    String? url;
    if(serie.image?.original != null && serie.image != null){
      url=serie.image?.original;
    }else{
      url='https://www.classify24.com/wp-content/uploads/2015/11/no-image.png';
    }
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context,'details',arguments:serie),
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
                image: NetworkImage(url!),
                width: 80,
                height: 110,
                fit:BoxFit.cover,
              ),
            ),
            
            Flexible(
              child: Text(
                serie.name??' - ',
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
