  import 'package:proj1/PokemonRepository.dart';
import 'package:proj1/pokemonDetail.dart';
import 'package:proj1/pokemonEvolution.dart';
import 'package:http/http.dart' as http;
import 'package:proj1/pokemonSpecies.dart';
import 'package:proj1/pokemonFullInfo.dart';
import 'dart:convert';

class PokemonRepositoryImp implements PokemonRepository{

  static int _quant = 1;
  static int _number = 10;

  Future<PokemonFullInfo> fetchDataPokemon(String name) async {
    List<PokemonDetail> pokemonsDetails = [];
    List<PokemonSpecies> pokemonSpecies = [];
    PokemonFullInfo pokemonFullInfo;
      final response = await http.get(
        Uri.encodeFull("https://pokeapi.co/api/v2/pokemon/$name"),
        headers: {"Accept": "application;json"});
      if (response.statusCode == 200) {
        final body = json.decode(response.body);
        pokemonsDetails.add(PokemonDetail.fromJson(body));
        pokemonSpecies.add(await fetchDataPokemonSpecies(pokemonsDetails.last.name));
      }else {
        throw Exception();
      }
    pokemonFullInfo = PokemonFullInfo(pokemonDetail: pokemonsDetails, pokemonSpecies: pokemonSpecies);

    return pokemonFullInfo;
  }

  @override
  Future<PokemonFullInfo> fetchDataPokemonDetail() async {
    List<PokemonDetail> pokemonsDetails = [];
    List<PokemonSpecies> pokemonSpecies = [];
    PokemonFullInfo pokemonFullInfo;
    for (; _quant < _number; _quant++) {
      print(_number);
      final response = await http.get(
          Uri.encodeFull("https://pokeapi.co/api/v2/pokemon/$_quant"),
          headers: {"Accept": "application;json"});
      if (response.statusCode == 200) {
        final body = json.decode(response.body);
        pokemonsDetails.add(PokemonDetail.fromJson(body));
        pokemonSpecies.add(await fetchDataPokemonSpecies(pokemonsDetails.last.name));
        
      } else {
        throw new Exception("Failed to load from API");
      }
    }
    pokemonFullInfo = PokemonFullInfo(pokemonDetail: pokemonsDetails, pokemonSpecies: pokemonSpecies);
    _number+=10;
    return pokemonFullInfo;
  }

  @override
  Future<PokemonFullInfo> fetchDataListPokemonDetail(List<String> favourite) async {
    List<PokemonDetail> pokemonsDetails = [];
    List<PokemonSpecies> pokemonSpecies = [];
    PokemonFullInfo pokemonFullInfo;
    int _size = favourite.length;
    for (int i=0; i < _size; i++) {
      String name = favourite[i];
      final response = await http.get(
          Uri.encodeFull("https://pokeapi.co/api/v2/pokemon/$name"),
          headers: {"Accept": "application;json"});
      if (response.statusCode == 200) {
        final body = json.decode(response.body);
        pokemonsDetails.add(PokemonDetail.fromJson(body));
        pokemonSpecies.add(await fetchDataPokemonSpecies(pokemonsDetails.last.name));
      } else {
        throw new Exception("Failed to load from API");
      }
    }
    pokemonFullInfo = PokemonFullInfo(pokemonDetail: pokemonsDetails, pokemonSpecies: pokemonSpecies);
    
    return pokemonFullInfo;
  }

  @override
  Future<List<PokemonDetail>> fetchDataListPokemon(List<String> name) async {
    List<PokemonDetail> pokemonsDetails = [];
    
    for (int i=0; i < name.length; i++) {
      String nome = name[i];
      final response = await http.get(
          Uri.encodeFull("https://pokeapi.co/api/v2/pokemon/$nome"),
          headers: {"Accept": "application;json"});
      if (response.statusCode == 200) {
        final body = json.decode(response.body);
        pokemonsDetails.add(PokemonDetail.fromJson(body));
      } else {
        throw new Exception("Failed to load from API2");
      }
    }
    return pokemonsDetails;
  }

  @override
  Future<PokemonEvolution> fetchDataPokemonEvolutionDetail(String url) async {
    PokemonEvolution pokemonEvolution;
      final response = await http.get(
          Uri.encodeFull(url),
          headers: {"Accept": "application;json"});
      if (response.statusCode == 200) {
        final body = json.decode(response.body);
        pokemonEvolution = PokemonEvolution.fromJson(body);
      } else {
        throw new Exception("Failed to load from API");
      }
    return pokemonEvolution;
  }

  Future<PokemonSpecies> fetchDataPokemonSpecies(String pokemon) async {
    PokemonSpecies pokemonSpecies;
      final response = await http.get(
          Uri.encodeFull("https://pokeapi.co/api/v2/pokemon-species/$pokemon"),
          headers: {"Accept": "application;json"});
      if (response.statusCode == 200) {
        final body = json.decode(response.body);
        pokemonSpecies = PokemonSpecies.fromJson(body);
      } else {
        throw new Exception("Failed to load from API");
      }
    return pokemonSpecies;
  }

}