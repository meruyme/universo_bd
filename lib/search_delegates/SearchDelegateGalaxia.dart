import 'package:flutter/material.dart';
import 'package:universo_bd/classes/Galaxia.dart';

class SearchDelegateGalaxia extends SearchDelegate<String>{

  List<Galaxia> galaxias;

  SearchDelegateGalaxia(this.galaxias);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [IconButton(
      icon: Icon(Icons.clear),
      onPressed: (){
        query = "";
      },
    ),
      IconButton(
        icon: Icon(Icons.done),
        onPressed: (){
          close(context, query);
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: (){
        close(context, "");
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    close(context, query);
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {

    final suggestions = query.isEmpty ? List()
        : galaxias.where((check) => check.nome.toLowerCase().startsWith(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, position){
        return ListTile(
          title: Text(suggestions[position].nome),
          onTap: (){
            showResults(context);
            close(context, suggestions[position].nome);
          },
        );
      },
    );
  }

}