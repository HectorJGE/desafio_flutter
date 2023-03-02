

import 'package:flutter/material.dart';

import '../providers/series_bloc.dart';

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
    return const Text('');
  }

  @override
  Widget buildSuggestions(BuildContext context) {

    if( query.isEmpty){
      return const Center(
        child: Icon(Icons.tv, color: Colors.black38, size:100)
      );
    }else{
      final searchBloc= SearchBloc(query:query);
      return Column(
          children: [
            Expanded(
                child:StreamBuilder(
                  stream:searchBloc.getSearch,
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
        );
    }
  }

}

class _SerieContainer extends StatelessWidget {

  final dynamic instanceSerie;

  const _SerieContainer({required this.instanceSerie});
  
  @override
  Widget build(BuildContext context) {
    String urlImg = '';
    if(instanceSerie['show']['image'] != null){
      urlImg= instanceSerie['show']['image']['original'];
    }else{
      urlImg= 'https://www.classify24.com/wp-content/uploads/2015/11/no-image.png';
    }
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context,'details',arguments:instanceSerie['show']),
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
                image: NetworkImage(urlImg),
                width: 80,
                height: 110,
                fit:BoxFit.cover,
              ),
            ),
            
            Flexible(
              child: Text(
                instanceSerie['show']['name'],
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
