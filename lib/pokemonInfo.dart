import 'package:flutter/material.dart';
import 'package:proj1/pokemonDetail.dart';
import 'package:proj1/PokemonRepository.dart';
import 'package:proj1/PokemonRepositoryImp.dart';
import 'package:proj1/pokemonEvolution.dart';
import 'package:proj1/pokemonSpecies.dart';
import 'dart:math' as math;

String buildName(String name) {
  return name[0].toUpperCase() + name.substring(1);
}

class PokemonInfo extends StatefulWidget {
  final PokemonDetail pokemonDetail;
  final PokemonSpecies pokemonSpecies;

  PokemonInfo({this.pokemonDetail, this.pokemonSpecies});

  @override
  State<StatefulWidget> createState() => PokemonInfoState(
      pokemonDetail: pokemonDetail, pokemonSpecies: pokemonSpecies);
}

class PokemonInfoState extends State<PokemonInfo> {
  final PokemonDetail pokemonDetail;
  final PokemonSpecies pokemonSpecies;
  List<String> url = [];
  bool isDone = false;
  List<double> offset;

  PokemonInfoState({this.pokemonDetail, this.pokemonSpecies});

  void get() async {

    String firstEvolution;
    String secondEvolution;
    String thirdEvolution;
    List<String> names;
    PokemonRepository pokemonRepository = new PokemonRepositoryImp();
    PokemonEvolution pokemonEvolution = await pokemonRepository
        .fetchDataPokemonEvolutionDetail(pokemonSpecies.evolutionChain.url);
    try {
      firstEvolution = pokemonEvolution.chain.species.name;
      secondEvolution = pokemonEvolution.chain.evolvesTo[0].species.name;
      thirdEvolution = pokemonEvolution.chain.evolvesTo[0].evolvesToPoke[0].species.name;  
    } catch (Exception) {
      thirdEvolution = null;
    }
    if(secondEvolution == null){
      names = [firstEvolution];
      offset = [1000.0, 1000.0];
    }else if(thirdEvolution == null){
      names = [firstEvolution, secondEvolution];
      offset = [190.0, 190.0];
    }else {
      names = [firstEvolution, secondEvolution, thirdEvolution];
      offset = [255.0, 140.0];
    }

    List<PokemonDetail> pokemonDetails = await pokemonRepository.fetchDataListPokemon(names);
    
    url = pokemonDetails.map((f) => f.sprites.frontDefault).toList();
    isDone = true;
    setState(() {
    });
  }

  @override
  void initState() {
    get();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color((math.Random().nextDouble() * 0xFFFFFF).toInt() << 0).withOpacity(0.5),
        appBar: AppBar(
          centerTitle: true,
          title: Text(buildName(pokemonDetail.name)),
        ),
        body: isDone == false ? Center(child: CircularProgressIndicator()) : Stack(children: <Widget>[
          Positioned(
              height: MediaQuery.of(context).size.height / 1.35 ,
              width: MediaQuery.of(context).size.width - 30,
              left: 15,
              top: MediaQuery.of(context).size.height - 625,
              child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0)),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(height: 100.0),
                        Text(
                          "Altura: " + pokemonDetail.height.toString(),
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text("Experiencia Base: " +
                            pokemonDetail.baseExperience.toString(), style: TextStyle(fontWeight: FontWeight.bold),),
                        Text("Peso: " + pokemonDetail.weight.toString(), style: TextStyle(fontWeight: FontWeight.bold),),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text("Habilidades", style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
                        Wrap(
                            spacing: 30.0,
                            children: pokemonDetail.abilities
                                .map((f) => FilterChip(
                                      label: Text(f.ability.name),
                                      backgroundColor: Colors.yellow,
                                      onSelected: (b) {},
                                    ))
                                .toList()),
                        Text("Tipos", style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
                        Wrap(
                            spacing: 30.0,
                            children: pokemonDetail.types
                                .map((f) => FilterChip(
                                      label: Text(f.type.name),
                                      backgroundColor: Colors.red,
                                      onSelected: (b) {},
                                    ))
                                .toList()),
                        Text("Movimentos", style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
                        Expanded(
                            child: ListView.builder(
                          shrinkWrap: true,
                          padding: EdgeInsets.all(0.5),
                          scrollDirection: Axis.horizontal,
                          itemCount: pokemonDetail.moves.length,
                          itemBuilder: (context, index) {
                            return Container(
                                margin: EdgeInsets.all(10.0),
                                child: FilterChip(
                                    label: Text(
                                        pokemonDetail.moves[index].move.name),
                                    backgroundColor: Colors.blue,
                                    onSelected: (a) {}));
                          },
                        )),
                        Text("Evolucoes", style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: url.map((f) => Container(
                            width: 90.0,
                            height: 90.0,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(f)
                              )
                            ),
                          )).toList()
                        )
                        
                      ]))),
          Positioned(
            top: -25.0,
            right: 100.0,
            child: Hero(
              tag: pokemonDetail.sprites.frontDefault,
              child: Container(
                height: 200.0,
                width: 200.0,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image:
                            NetworkImage(pokemonDetail.sprites.frontDefault))),
              ),
            ),
          ),
          Positioned(
            top: 500.0,
            right: offset[0],
            child: Container(
              height: 30.0,
              width: 30.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage("assets/arrow.png")
                )
              ),
            ),
          ),
          Positioned(
            top: 500.0,
            right: offset[1],
            child: Container(
              height: 30.0,
              width: 30.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage("assets/arrow.png")
                )
              ),
            ),
          )
        ]));
  }
}
