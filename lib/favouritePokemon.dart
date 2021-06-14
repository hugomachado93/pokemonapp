import 'package:flutter/material.dart';
import 'package:proj1/preferences.dart';
import 'package:proj1/PokemonRepository.dart';
import 'package:proj1/PokemonRepositoryImp.dart';
import 'package:proj1/pokemonFullInfo.dart';
import 'package:proj1/pokemonInfo.dart';
import 'dart:math' as math;

class FavouritePokemons extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => FavouritePokemonsState();
}

class FavouritePokemonsState extends State<FavouritePokemons> {
  final PokemonRepository pokemonRepository = PokemonRepositoryImp();

  List<String> listFav = [];
  bool isDone = false;

  void getPokemonList() async {
    listFav.addAll(await SharedPreferencesConfig.getFavorite());
    setState(() {});
  }

  @override
  void initState() {
    getPokemonList();
    super.initState();
  }

  String buildName(String name) {
    return name[0].toUpperCase() + name.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage("assets/pokemonlandscape.jpeg"))),
        child: Center(
            child: FutureBuilder<PokemonFullInfo>(
          future: pokemonRepository.fetchDataListPokemonDetail(listFav),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              throw Exception("Erro ao fazer fetch  ");
            }
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Center(child: CircularProgressIndicator());
              case ConnectionState.done:
                return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1,
                        childAspectRatio: MediaQuery.of(context).size.width /
                            (MediaQuery.of(context).size.height / 4)),
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data.pokemonDetail.length,
                    itemBuilder: (context, index) {
                      return Dismissible(
                          direction: DismissDirection.vertical,
                          key: Key(snapshot.data.pokemonDetail[index].name),
                          onDismissed: (direction) async {
                            List<String> favorite =
                              await SharedPreferencesConfig.getFavorite();
                              favorite.removeAt(index);
                              await SharedPreferencesConfig.setFavorite(
                                favorite);
                              listFav = await SharedPreferencesConfig.getFavorite();
                            setState(() {
                            });
                            Scaffold.of(context).showSnackBar(
                                SnackBar(content: Text("Deletado")));
                          },
                          child: GridTile(
                            child: Card(
                                color: Color(
                                        (math.Random().nextDouble() * 0xFFFFFF)
                                                .toInt() <<
                                            0)
                                    .withOpacity(0.5),
                                child: InkResponse(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => PokemonInfo(
                                                  pokemonDetail: snapshot.data
                                                      .pokemonDetail[index],
                                                  pokemonSpecies: snapshot.data
                                                      .pokemonSpecies[index],
                                                )));
                                  },
                                  child: Container(
                                      width: 50.0,
                                      height: 50.0,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              fit: BoxFit.contain,
                                              image: NetworkImage(snapshot
                                                  .data
                                                  .pokemonDetail[index]
                                                  .sprites
                                                  .frontDefault)))),
                                )),
                            footer: Center(
                                child: Text(
                              buildName(snapshot.data.pokemonDetail[index].name),
                              style: TextStyle(
                                  fontSize: 30.0, color: Colors.black),
                            )),
                          ));
                    });
              default:
            }
          },
        )));
  }
}
