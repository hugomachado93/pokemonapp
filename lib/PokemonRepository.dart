import 'package:proj1/pokemonDetail.dart';
import 'package:proj1/pokemonEvolution.dart';
import 'package:proj1/pokemonSpecies.dart';
import 'package:proj1/pokemonFullInfo.dart';

abstract class PokemonRepository {
  Future<PokemonFullInfo> fetchDataPokemon(String name);

  Future<PokemonFullInfo> fetchDataPokemonDetail();

  Future<PokemonFullInfo> fetchDataListPokemonDetail(List<String> favourite);

  Future<PokemonEvolution> fetchDataPokemonEvolutionDetail(String url);

  Future<PokemonSpecies> fetchDataPokemonSpecies(String pokemon);

  Future<List<PokemonDetail>> fetchDataListPokemon(List<String> name);
}