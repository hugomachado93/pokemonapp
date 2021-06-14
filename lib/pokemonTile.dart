import 'package:proj1/pokemonDetail.dart';
import 'package:flutter/material.dart';
import 'package:proj1/pokemonInfo.dart';
import 'package:proj1/PokemonRepository.dart';
import 'package:proj1/PokemonRepositoryImp.dart';
import 'package:proj1/preferences.dart';
import 'package:proj1/pokemonFullInfo.dart';
import 'dart:math' as math;

enum PokemonLoadMoreStatus { LOADING, STABLE }

class PokemonTile extends StatefulWidget {
  final PokemonFullInfo pokemons;

  PokemonTile({this.pokemons});

  @override
  _PokemonTileState createState() =>
      _PokemonTileState(pokemonFullInfo: pokemons);
}

class _PokemonTileState extends State<PokemonTile> {
  PokemonLoadMoreStatus loadMoreStatus = PokemonLoadMoreStatus.STABLE;
  PokemonFullInfo pokemonFullInfo;
  final ScrollController scrollController = ScrollController();
  PokemonRepository pokemonRepository = PokemonRepositoryImp();

  _PokemonTileState({this.pokemonFullInfo});

  

  Widget build(BuildContext context) {
    return NotificationListener(
        onNotification: _onNotification,
        child: GridView.builder(
            controller: scrollController,
            itemCount: pokemonFullInfo.pokemonDetail.length,
            scrollDirection: Axis.vertical,
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            itemBuilder: (context, index) {
              return Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      color: Color((math.Random().nextDouble() * 0xFFFFFF).toInt() << 0).withOpacity(0.5),
                      child: InkResponse(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PokemonInfo(
                                        pokemonDetail: pokemonFullInfo.pokemonDetail[index], pokemonSpecies: pokemonFullInfo.pokemonSpecies[index],
                                            )));
                          },
                          onDoubleTap: () async {
                            List<String> favoritePokemons;
                            favoritePokemons = await SharedPreferencesConfig.getFavorite();
                            if(favoritePokemons == null){
                              favoritePokemons = [];
                            }

                            favoritePokemons.add(pokemonFullInfo.pokemonDetail[index].name);
                            favoritePokemons = favoritePokemons.toSet().toList();
                            print(await SharedPreferencesConfig.setFavorite(
                                favoritePokemons));
                            print(await SharedPreferencesConfig
                                .getFavorite());
                            setState(() {});
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Hero(
                                tag: pokemonFullInfo
                                    .pokemonDetail[index].sprites.frontDefault,
                                child: Container(
                                    height: 150.0,
                                    width: 150.0,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(pokemonFullInfo
                                                .pokemonDetail[index]
                                                .sprites
                                                .frontDefault)))),
                              ),
                              Text(
                                  buildName(
                                      pokemonFullInfo.pokemonDetail[index].name),
                                  style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold))
                            ],
                          ))));
            }));
  }

  String buildName(String name) {
    return name[0].toUpperCase() + name.substring(1);
  }

  bool _onNotification(ScrollNotification notification) {
    if (notification is ScrollUpdateNotification) {
      if (scrollController.position.maxScrollExtent > scrollController.offset &&
          scrollController.position.maxScrollExtent - scrollController.offset <=
              50) {
        if (loadMoreStatus != null &&
            loadMoreStatus == PokemonLoadMoreStatus.STABLE) {
          loadMoreStatus = PokemonLoadMoreStatus.LOADING;
          print("estavel");
          pokemonRepository.fetchDataPokemonDetail().then((pokemonObject) {
            loadMoreStatus = PokemonLoadMoreStatus.STABLE;
            pokemonFullInfo.pokemonDetail.addAll(pokemonObject.pokemonDetail);
            pokemonFullInfo.pokemonSpecies.addAll(pokemonObject.pokemonSpecies);
            setState(() {});
          });
        }
      }
    }
    return true;
  }
}
