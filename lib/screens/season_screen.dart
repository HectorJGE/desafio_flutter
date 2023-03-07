import 'package:desafio_flutter/bloc/episodes/episodes_bloc.dart';
import 'package:desafio_flutter/providers/api_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SeasonScreen extends StatefulWidget {
  const SeasonScreen({super.key});

  @override
  State<SeasonScreen> createState() => _SeasonScreenState();
}

class _SeasonScreenState extends State<SeasonScreen> {
    
  late final EpisodesBloc _episodesBloc;

  @override
  Widget build(BuildContext context) {
    final dynamic season = ModalRoute.of(context)?.settings.arguments?? 'no-season'; 
    _episodesBloc=EpisodesBloc(idSeason:season["id"]);
    _episodesBloc.add(FetchEpisodes());
    return Scaffold(
        appBar: AppBar(
          title: Text("Season ${season['number']}"),
        ),
        body: _builtListSeasons()
      );
  }

  Widget _builtListSeasons () {
    return Container(
      margin:const EdgeInsets.all(8.0),
      child: BlocProvider(
        create: (_) => _episodesBloc,
        child:BlocListener <EpisodesBloc,EpisodesState> (
          listener: (context, state){
            if(state is EpisodesNotLoaded) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.errorMessage??'Error'))
              );
            }
          },
          child:BlocBuilder<EpisodesBloc,EpisodesState>(
            builder: (context, state){
              if(state is InitialEpisodesState){
                return _buildLoading();
              }else if (state is EpisodesLoading){
                return _buildLoading();
              }else if (state is EpisodesLoaded){
                return SingleChildScrollView(
                  child: Column(
                    children:
                      List.generate(state.episodes.length, (index) => 
                        ListTile(
                          onTap: () => Navigator.pushNamed(context,'episode',arguments:state.episodes[index]),
                          title:Text('Episode: ${index+1}'),
                          trailing: const Icon(Icons.arrow_forward_ios_outlined)
                        )
                      )
                  )
                );
              }else if (state is EpisodesNotLoaded){
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
