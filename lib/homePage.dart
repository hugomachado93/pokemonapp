import 'package:flutter/material.dart';
import 'package:proj1/pokemonDetail.dart';
import 'package:proj1/pokemonTile.dart';
import 'package:proj1/PokemonRepositoryImp.dart';
import 'package:proj1/pokemonFullInfo.dart';

class HomePage extends StatelessWidget {

  final PokemonRepositoryImp pokemonRepository = PokemonRepositoryImp();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage("assets/pokemonlandscape2.jpg")
        )
      ),
        child: Center(
            child: FutureBuilder<PokemonFullInfo>(
              future: pokemonRepository.fetchDataPokemonDetail(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  throw Exception("Erro ao fazer fetch");
                }
                switch(snapshot.connectionState){
                  case ConnectionState.waiting:
                    return Center(child: CircularProgressIndicator());
                  case ConnectionState.done:
                    return PokemonTile(pokemons: snapshot.data);
                  default:
                }
              },
            )));
  }
}
