import 'package:desafio_flutter/providers/series_bloc.dart';
import 'package:flutter/material.dart';

class SeasonScreen extends StatelessWidget {
  const SeasonScreen({super.key});
  
  @override
  Widget build(BuildContext context) {
    final dynamic season = ModalRoute.of(context)?.settings.arguments ?? 'no-serie'; 
    final episodesBloc= EpisodesBloc(idSeason:season['id'].toString());
    return Scaffold(
        appBar: AppBar(
          title: Text("Season ${season['number']}"),
        ),
        body: Column(
          children: [
            Expanded(
                child:StreamBuilder(
                  stream:episodesBloc.getEpisodes,
                  builder: ( _ , AsyncSnapshot<List<dynamic>> snapshot){

                    final episodes = snapshot.data ?? [ ];
                    
                    return ListView.builder(
                        itemCount: episodes.length,
                        itemBuilder: (_, i ){
                          return ListTile(
                            onTap: () => Navigator.pushNamed(context,'episode',arguments:episodes[i]),
                            title:Text('Episode: ${i+1}'),
                            trailing: const Icon(Icons.arrow_forward_ios_outlined)
                          );
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