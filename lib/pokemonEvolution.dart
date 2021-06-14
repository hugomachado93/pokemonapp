class PokemonEvolution {
  Null babyTriggerItem;
  Chain chain;
  int id;

  PokemonEvolution({this.babyTriggerItem, this.chain, this.id});

  PokemonEvolution.fromJson(Map<String, dynamic> json) {
    babyTriggerItem = json['baby_trigger_item'];
    chain = json['chain'] != null ? new Chain.fromJson(json['chain']) : null;
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['baby_trigger_item'] = this.babyTriggerItem;
    if (this.chain != null) {
      data['chain'] = this.chain.toJson();
    }
    data['id'] = this.id;
    return data;
  }
}

class Chain {
  List<EvolvesTo> evolvesTo;
  bool isBaby;
  Species species;

  Chain({this.evolvesTo, this.isBaby, this.species});

  Chain.fromJson(Map<String, dynamic> json) {
    if (json['evolves_to'] != null) {
      evolvesTo = new List<EvolvesTo>();
      json['evolves_to'].forEach((v) {
        evolvesTo.add(new EvolvesTo.fromJson(v));
      });
    }
    isBaby = json['is_baby'];
    species =
        json['species'] != null ? new Species.fromJson(json['species']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.evolvesTo != null) {
      data['evolves_to'] = this.evolvesTo.map((v) => v.toJson()).toList();
    }
    data['is_baby'] = this.isBaby;
    if (this.species != null) {
      data['species'] = this.species.toJson();
    }
    return data;
  }
}

class EvolvesTo {
  List<EvolutionDetails> evolutionDetails;
  List<EvolvesToPoke> evolvesToPoke;
  bool isBaby;
  Species species;

  EvolvesTo({this.evolutionDetails, this.evolvesToPoke, this.isBaby, this.species});

  EvolvesTo.fromJson(Map<String, dynamic> json) {
    if (json['evolves_to'] != null) {
      evolvesToPoke = new List<EvolvesToPoke>();
      json['evolves_to'].forEach((v) {
        evolvesToPoke.add(new EvolvesToPoke.fromJson(v));
      });
    }
    isBaby = json['is_baby'];
    species =
        json['species'] != null ? new Species.fromJson(json['species']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.evolvesToPoke != null) {
      data['evolves_to'] = this.evolvesToPoke.map((v) => v.toJson()).toList();
    }
    data['is_baby'] = this.isBaby;
    if (this.species != null) {
      data['species'] = this.species.toJson();
    }
    return data;
  }
}

class EvolutionDetails {
  int minLevel;
  bool needsOverworldRain;
  String timeOfDay;
  Trigger trigger;
  bool turnUpsideDown;

  EvolutionDetails(
      {
      this.minLevel,
      this.needsOverworldRain,
      this.timeOfDay,
      this.trigger,
      this.turnUpsideDown});

  EvolutionDetails.fromJson(Map<String, dynamic> json) {
    minLevel = json['min_level'];
    needsOverworldRain = json['needs_overworld_rain'];
    timeOfDay = json['time_of_day'];
    trigger =
        json['trigger'] != null ? new Trigger.fromJson(json['trigger']) : null;
    turnUpsideDown = json['turn_upside_down'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['needs_overworld_rain'] = this.needsOverworldRain;
    data['time_of_day'] = this.timeOfDay;
    if (this.trigger != null) {
      data['trigger'] = this.trigger.toJson();
    }
    data['turn_upside_down'] = this.turnUpsideDown;
    return data;
  }
}

class Trigger {
  String name;
  String url;

  Trigger({this.name, this.url});

  Trigger.fromJson(Map<String, dynamic> json) {
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

class EvolvesToPoke {
  List<EvolutionDetails> evolutionDetails;
  bool isBaby;
  Species species;

  EvolvesToPoke({this.evolutionDetails, this.isBaby, this.species});

  EvolvesToPoke.fromJson(Map<String, dynamic> json) {
    isBaby = json['is_baby'];
    species =
        json['species'] != null ? new Species.fromJson(json['species']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['is_baby'] = this.isBaby;
    if (this.species != null) {
      data['species'] = this.species.toJson();
    }
    return data;
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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['url'] = this.url;
    return data;
  }
}
