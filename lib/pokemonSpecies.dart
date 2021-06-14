class PokemonSpecies {

  EvolutionChain evolutionChain;
  
  PokemonSpecies(
      {
      this.evolutionChain,
      });

  PokemonSpecies.fromJson(Map<String, dynamic> json) {
    evolutionChain = json['evolution_chain'] != null
        ? new EvolutionChain.fromJson(json['evolution_chain'])
        : null;
  }
}

class EvolutionChain {
  String url;

  EvolutionChain({this.url});

  EvolutionChain.fromJson(Map<String, dynamic> json) {
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    return data;
  }
}