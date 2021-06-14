import 'package:flutter/material.dart';
import 'package:proj1/PokemonRepository.dart';
import 'package:proj1/PokemonRepositoryImp.dart';
import 'package:proj1/pokemonDetail.dart';
import 'package:proj1/preferences.dart';
import 'package:proj1/pokemonInfo.dart';
import 'package:proj1/pokemonFullInfo.dart';
import 'package:proj1/pokemonSpecies.dart';

class DataSearch extends SearchDelegate<String> {

  PokemonDetail pokemonDetail;
  PokemonSpecies pokemonSpecies;

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = "";
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return PokemonInfo(pokemonDetail: pokemonDetail, pokemonSpecies: pokemonSpecies);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    PokemonRepository pokemonRepository = PokemonRepositoryImp();

    return Container(
        child: FutureBuilder<PokemonFullInfo>(
      future: pokemonRepository.fetchDataPokemon(query),
      builder: (context, snapshot) {
        if(snapshot.hasError){
          return Container(
            child: ListTile(
              title: Text("Nenhum resultado")));
        }
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Center(child: CircularProgressIndicator());
          case ConnectionState.done:
            return ListView.builder(
                itemCount: 1,
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () async {
                      pokemonDetail = snapshot.data.pokemonDetail[index]; 
                      pokemonSpecies = snapshot.data.pokemonSpecies[index];
                      showResults(context);
                    },
                    leading: CircleAvatar(
                      radius: 40.0,
                      backgroundColor: Colors.transparent,
                      backgroundImage: NetworkImage(
                          snapshot.data.pokemonDetail[index].sprites.frontDefault),
                    ),
                    title: Text(snapshot.data.pokemonDetail[index].name),
                  );
                });
          default:
        }
      },
    ));
  }
}
