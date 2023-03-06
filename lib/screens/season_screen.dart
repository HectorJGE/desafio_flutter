import 'package:desafio_flutter/providers/api_provider.dart';
import 'package:flutter/material.dart';

class SeasonScreen extends StatefulWidget {
  const SeasonScreen({super.key});

  @override
  State<SeasonScreen> createState() => _SeasonScreenState();
}

class _SeasonScreenState extends State<SeasonScreen> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class SeasonScreen2 extends StatelessWidget {
  const SeasonScreen2({super.key});
  
  @override
  Widget build(BuildContext context) {
    final dynamic season = ModalRoute.of(context)?.settings.arguments ?? 'no-serie'; 
    return Scaffold(
        appBar: AppBar(
          title: Text("Season ${season['number']}"),
        ),
        body: Column(
          children: [
            Expanded(
                child:StreamBuilder(
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
