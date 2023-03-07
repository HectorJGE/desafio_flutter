

import 'package:desafio_flutter/bloc/search/search_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class SerieSearchDelegate extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: (){query='';},
        icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: (){
          close(context, null);
        },
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return BuildSearch(query: query);
  }
  @override
  Widget buildSuggestions(BuildContext context) {
    
    if( query.isEmpty){
      return const Center(
        child: Icon(Icons.tv, color: Colors.black38, size:100)
      );
    }
    return Container();
  }
}

class BuildSearch extends StatefulWidget {
  final String query;
  const BuildSearch({required this.query,super.key});

  @override
  State<BuildSearch> createState() => _BuildSearchState(query:query);
}

class _BuildSearchState extends State<BuildSearch> {
  final String query;
  late final SearchBloc _searchBloc=SearchBloc(query:query);
  _BuildSearchState({required this.query});

  @override
  Widget build(BuildContext context) {

    _searchBloc.add(FetchSearch());
    return Container(
        margin:const EdgeInsets.all(8.0),
        child: BlocProvider(
          create: (_) => _searchBloc,
          child:BlocListener <SearchBloc,SearchState> (
            listener: (context, state){
              if(state is SearchNotLoaded) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.errorMessage??'Error'))
                );
              }
            },
            child:BlocBuilder<SearchBloc,SearchState>(
              builder: (context, state){
                if(state is InitialSearchState){
                  return const Center(child:CircularProgressIndicator());
                }else if (state is SearchLoading){
                  return const Center(child:CircularProgressIndicator());
                }else if (state is SearchLoaded){
                  return SingleChildScrollView(
                    child: Column(
                      children:
                        List.generate(state.search.length, (index) => 
                          ListTile(
                            onTap: () => Navigator.pushNamed(context,'details',arguments:state.search[index]['show']),
                            title:Text(state.search[index]['show']['name']),
                            trailing: const Icon(Icons.arrow_forward_ios_outlined)
                          )
                        )
                    )
                  );
                }else if (state is SearchNotLoaded){
                  return Container();
                }else {
                  return Container();
                }
              })
          ),
        )
      );
  }
}