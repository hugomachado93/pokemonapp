class PokemonDetail {
  List<Abilities> abilities;
  int baseExperience;
  int height;
  int id;
  String locationAreaEncounters;
  List<Moves> moves;
  String name;
  Species species;
  Sprites sprites;
  List<Types> types;
  int weight;

  PokemonDetail(
      {this.abilities,
      this.baseExperience,
      this.height,
      this.id,
      this.locationAreaEncounters,
      this.moves,
      this.name,
      this.species,
      this.sprites,
      this.types,
      this.weight});

  PokemonDetail.fromJson(Map<String, dynamic> json) {
    if (json['abilities'] != null) {
      abilities = new List<Abilities>();
      json['abilities'].forEach((v) {
        abilities.add(new Abilities.fromJson(v));
      });
    }
    baseExperience = json['base_experience'];
    height = json['height'];

    id = json['id'];
    locationAreaEncounters = json['location_area_encounters'];
    if (json['moves'] != null) {
      moves = new List<Moves>();
      json['moves'].forEach((v) {
        moves.add(new Moves.fromJson(v));
      });
    }
    name = json['name'];
    species =
        json['species'] != null ? new Species.fromJson(json['species']) : null;
    sprites =
        json['sprites'] != null ? new Sprites.fromJson(json['sprites']) : null;
    if (json['types'] != null) {
      types = new List<Types>();
      json['types'].forEach((v) {
        types.add(new Types.fromJson(v));
      });
    }
    weight = json['weight'];
  }
}

class Abilities {
  Ability ability;
  bool isHidden;
  int slot;

  Abilities({this.ability, this.isHidden, this.slot});

  Abilities.fromJson(Map<String, dynamic> json) {
    ability =
        json['ability'] != null ? new Ability.fromJson(json['ability']) : null;
    isHidden = json['is_hidden'];
    slot = json['slot'];
  }

}

class Ability {
  String name;
  String url;

  Ability({this.name, this.url});

  Ability.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    url = json['url'];
  }

}

class Forms {
  String name;
  String url;

  Forms({this.name, this.url});

  Forms.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    url = json['url'];
  }

}

class GameIndices {
  int gameIndex;
  Version version;

  GameIndices({this.gameIndex, this.version});

  GameIndices.fromJson(Map<String, dynamic> json) {
    gameIndex = json['game_index'];
    version =
        json['version'] != null ? new Version.fromJson(json['version']) : null;
  }

}

class Version {
  String name;
  String url;

  Version({this.name, this.url});

  Version.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    url = json['url'];
  }

}

class Moves {
  Move move;
  List<VersionGroupDetails> versionGroupDetails;

  Moves({this.move, this.versionGroupDetails});

  Moves.fromJson(Map<String, dynamic> json) {
    move = json['move'] != null ? new Move.fromJson(json['move']) : null;
    if (json['version_group_details'] != null) {
      versionGroupDetails = new List<VersionGroupDetails>();
      json['version_group_details'].forEach((v) {
        versionGroupDetails.add(new VersionGroupDetails.fromJson(v));
      });
    }
  }

}

class Move {
  String name;
  String url;

  Move({this.name, this.url});

  Move.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    url = json['url'];
  }

}

class VersionGroupDetails {
  int levelLearnedAt;
  MoveLearnMethod moveLearnMethod;
  VersionGroup versionGroup;

  VersionGroupDetails(
      {this.levelLearnedAt, this.moveLearnMethod, this.versionGroup});

  VersionGroupDetails.fromJson(Map<String, dynamic> json) {
    levelLearnedAt = json['level_learned_at'];
    moveLearnMethod = json['move_learn_method'] != null
        ? new MoveLearnMethod.fromJson(json['move_learn_method'])
        : null;
    versionGroup = json['version_group'] != null
        ? new VersionGroup.fromJson(json['version_group'])
        : null;
  }

}

class MoveLearnMethod {
  String name;
  String url;

  MoveLearnMethod({this.name, this.url});

  MoveLearnMethod.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['url'] = this.url;
    return data;
  }
}

class VersionGroup {
  String name;
  String url;

  VersionGroup({this.name, this.url});

  VersionGroup.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    url = json['url'];
  }

}

class Species {
  String name;
  String url;

  Species({this.name, this.url});

  Species.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    url = json['url'];
  }

}

class Sprites {
  String backDefault;
  String backFemale;
  String backShiny;
  String backShinyFemale;
  String frontDefault;
  String frontFemale;
  String frontShiny;
  String frontShinyFemale;

  List<String> listSprites = [];

  Sprites(
      {this.backDefault,
      this.backFemale,
      this.backShiny,
      this.backShinyFemale,
      this.frontDefault,
      this.frontFemale,
      this.frontShiny,
      this.frontShinyFemale});

  Sprites.fromJson(Map<String, dynamic> json) {
    backDefault = json['back_default'];
    backFemale = json['back_female'];
    backShiny = json['back_shiny'];
    backShinyFemale = json['back_shiny_female'];
    frontDefault = json['front_default'];
    frontFemale = json['front_female'];
    frontShiny = json['front_shiny'];
    frontShinyFemale = json['front_shiny_female'];

    listSprites.add(backDefault);
    listSprites.add(backShiny);
    listSprites.add(frontDefault);
    listSprites.add(frontShiny);
  }

}

class Types {
  int slot;
  Type type;

  Types({this.slot, this.type});

  Types.fromJson(Map<String, dynamic> json) {
    slot = json['slot'];
    type = json['type'] != null ? new Type.fromJson(json['type']) : null;
  }

}

class Type {
  String name;
  String url;

  Type({this.name, this.url});

  Type.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    url = json['url'];
  }

}
