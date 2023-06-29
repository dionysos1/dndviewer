// To parse this JSON data, do
//
//     final monsters = monstersFromJson(jsonString);

import 'dart:convert';

List<Monsters> monstersFromJson(String str) => List<Monsters>.from(json.decode(str).map((x) => Monsters.fromJson(x)));

String monstersToJson(List<Monsters> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Monsters {
  final String name;
  final String slug;
  final double challengeRating;
  final Size size;
  final Type type;
  final Subtype subtype;
  final Alignment alignment;
  final ArmorClass armorClass;
  final HitPoints hitPoints;
  final Speed speed;
  final AbilityScores abilityScores;
  final SavingThrows savingThrows;
  final Map<String, dynamic> properties;
  final List<String> languages;
  final Senses senses;
  final List<Trait> traits;
  final List<Action> actions;
  final List<String> tags;
  final List<String>? damageImmunities;
  final List<ConditionImmunity>? conditionImmunities;
  final List<String>? damageResistances;
  final List<String>? damageVulnerabilities;

  Monsters({
    required this.name,
    required this.slug,
    required this.challengeRating,
    required this.size,
    required this.type,
    required this.subtype,
    required this.alignment,
    required this.armorClass,
    required this.hitPoints,
    required this.speed,
    required this.abilityScores,
    required this.savingThrows,
    required this.properties,
    required this.languages,
    required this.senses,
    required this.traits,
    required this.actions,
    required this.tags,
    this.damageImmunities,
    this.conditionImmunities,
    this.damageResistances,
    this.damageVulnerabilities,
  });

  factory Monsters.fromJson(Map<String, dynamic> json) => Monsters(
    name: json["name"],
    slug: json["slug"],
    challengeRating: json["challenge_rating"]?.toDouble(),
    size: sizeValues.map[json["size"]]!,
    type: typeValues.map[json["type"]]!,
    subtype: subtypeValues.map[json["subtype"]]!,
    alignment: alignmentValues.map[json["alignment"]]!,
    armorClass: ArmorClass.fromJson(json["armor_class"]),
    hitPoints: HitPoints.fromJson(json["hit_points"]),
    speed: Speed.fromJson(json["speed"]),
    abilityScores: AbilityScores.fromJson(json["ability_scores"]),
    savingThrows: SavingThrows.fromJson(json["saving_throws"]),
    properties: Map.from(json["properties"]).map((k, v) => MapEntry<String, dynamic>(k, v)),
    languages: List<String>.from(json["languages"].map((x) => x)),
    senses: Senses.fromJson(json["senses"]),
    traits: List<Trait>.from(json["traits"].map((x) => Trait.fromJson(x))),
    actions: List<Action>.from(json["actions"].map((x) => Action.fromJson(x))),
    tags: List<String>.from(json["tags"].map((x) => x)),
    damageImmunities: json["damage_immunities"] == null ? [] : List<String>.from(json["damage_immunities"]!.map((x) => x)),
    conditionImmunities: json["condition_immunities"] == null ? [] : List<ConditionImmunity>.from(json["condition_immunities"]!.map((x) => conditionImmunityValues.map[x]!)),
    damageResistances: json["damage_resistances"] == null ? [] : List<String>.from(json["damage_resistances"]!.map((x) => x)),
    damageVulnerabilities: json["damage_vulnerabilities"] == null ? [] : List<String>.from(json["damage_vulnerabilities"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "slug": slug,
    "challenge_rating": challengeRating,
    "size": sizeValues.reverse[size],
    "type": typeValues.reverse[type],
    "subtype": subtypeValues.reverse[subtype],
    "alignment": alignmentValues.reverse[alignment],
    "armor_class": armorClass.toJson(),
    "hit_points": hitPoints.toJson(),
    "speed": speed.toJson(),
    "ability_scores": abilityScores.toJson(),
    "saving_throws": savingThrows.toJson(),
    "properties": Map.from(properties).map((k, v) => MapEntry<String, dynamic>(k, v)),
    "languages": List<dynamic>.from(languages.map((x) => x)),
    "senses": senses.toJson(),
    "traits": List<dynamic>.from(traits.map((x) => x.toJson())),
    "actions": List<dynamic>.from(actions.map((x) => x.toJson())),
    "tags": List<dynamic>.from(tags.map((x) => x)),
    "damage_immunities": damageImmunities == null ? [] : List<dynamic>.from(damageImmunities!.map((x) => x)),
    "condition_immunities": conditionImmunities == null ? [] : List<dynamic>.from(conditionImmunities!.map((x) => conditionImmunityValues.reverse[x])),
    "damage_resistances": damageResistances == null ? [] : List<dynamic>.from(damageResistances!.map((x) => x)),
    "damage_vulnerabilities": damageVulnerabilities == null ? [] : List<dynamic>.from(damageVulnerabilities!.map((x) => x)),
  };
}

class AbilityScores {
  final int str;
  final int dex;
  final int con;
  final int abilityScoresInt;
  final int wis;
  final int cha;

  AbilityScores({
    required this.str,
    required this.dex,
    required this.con,
    required this.abilityScoresInt,
    required this.wis,
    required this.cha,
  });

  factory AbilityScores.fromJson(Map<String, dynamic> json) => AbilityScores(
    str: json["str"],
    dex: json["dex"],
    con: json["con"],
    abilityScoresInt: json["int"],
    wis: json["wis"],
    cha: json["cha"],
  );

  Map<String, dynamic> toJson() => {
    "str": str,
    "dex": dex,
    "con": con,
    "int": abilityScoresInt,
    "wis": wis,
    "cha": cha,
  };
}

class Action {
  final String name;
  final String description;
  final int attackBonus;
  final Die? damageDice;
  final bool? legendary;
  final bool? reaction;

  Action({
    required this.name,
    required this.description,
    required this.attackBonus,
    this.damageDice,
    this.legendary,
    this.reaction,
  });

  factory Action.fromJson(Map<String, dynamic> json) => Action(
    name: json["name"],
    description: json["description"],
    attackBonus: json["attack_bonus"],
    damageDice: json["damage_dice"] == null ? null : Die.fromJson(json["damage_dice"]),
    legendary: json["legendary"],
    reaction: json["reaction"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "description": description,
    "attack_bonus": attackBonus,
    "damage_dice": damageDice?.toJson(),
    "legendary": legendary,
    "reaction": reaction,
  };
}

class Die {
  final int sides;
  final int count;
  final int mod;

  Die({
    required this.sides,
    required this.count,
    required this.mod,
  });

  factory Die.fromJson(Map<String, dynamic> json) => Die(
    sides: json["sides"],
    count: json["count"],
    mod: json["mod"],
  );

  Map<String, dynamic> toJson() => {
    "sides": sides,
    "count": count,
    "mod": mod,
  };
}

enum Alignment { LAWFUL_EVIL, ANY_ALIGNMENT, CHAOTIC_EVIL, CHAOTIC_GOOD, LAWFUL_GOOD, NEUTRAL, LAWFUL_NEUTRAL, UNALIGNED, ANY_NON_GOOD_ALIGNMENT, ANY_NON_LAWFUL_ALIGNMENT, NEUTRAL_EVIL, ANY_CHAOTIC_ALIGNMENT, NEUTRAL_GOOD, CHAOTIC_NEUTRAL, NEUTRAL_GOOD_50_OR_NEUTRAL_EVIL_50, ANY_EVIL_ALIGNMENT }

final alignmentValues = EnumValues({
  "Any Alignment": Alignment.ANY_ALIGNMENT,
  "Any Chaotic Alignment": Alignment.ANY_CHAOTIC_ALIGNMENT,
  "Any Evil Alignment": Alignment.ANY_EVIL_ALIGNMENT,
  "Any Non-good Alignment": Alignment.ANY_NON_GOOD_ALIGNMENT,
  "Any Non-lawful Alignment": Alignment.ANY_NON_LAWFUL_ALIGNMENT,
  "Chaotic Evil": Alignment.CHAOTIC_EVIL,
  "Chaotic Good": Alignment.CHAOTIC_GOOD,
  "Chaotic Neutral": Alignment.CHAOTIC_NEUTRAL,
  "Lawful Evil": Alignment.LAWFUL_EVIL,
  "Lawful Good": Alignment.LAWFUL_GOOD,
  "Lawful Neutral": Alignment.LAWFUL_NEUTRAL,
  "Neutral": Alignment.NEUTRAL,
  "Neutral Evil": Alignment.NEUTRAL_EVIL,
  "Neutral Good": Alignment.NEUTRAL_GOOD,
  "Neutral Good (50%) Or Neutral Evil (50%)": Alignment.NEUTRAL_GOOD_50_OR_NEUTRAL_EVIL_50,
  "Unaligned": Alignment.UNALIGNED
});

class ArmorClass {
  final int value;
  final Description description;

  ArmorClass({
    required this.value,
    required this.description,
  });

  factory ArmorClass.fromJson(Map<String, dynamic> json) => ArmorClass(
    value: json["value"],
    description: descriptionValues.map[json["description"]]!,
  );

  Map<String, dynamic> toJson() => {
    "value": value,
    "description": descriptionValues.reverse[description],
  };
}

enum Description { NATURAL_ARMOR, EMPTY, NATURAL_ARMOR_SHIELD, HIDE_ARMOR_SHIELD, THE_16_WITH_BARKSKIN, SCALE_MAIL_SHIELD, PLATE, PATCHWORK_ARMOR, LEATHER_ARMOR_SHIELD, CHAIN_MAIL_SHIELD, HIDE_ARMOR, CHAIN_MAIL, LEATHER_ARMOR, ARMOR_SCRAPS, SCALE_MAIL, BARDING_SCRAPS, STUDDED_LEATHER }

final descriptionValues = EnumValues({
  "armor scraps": Description.ARMOR_SCRAPS,
  "barding scraps": Description.BARDING_SCRAPS,
  "chain mail": Description.CHAIN_MAIL,
  "chain mail, shield": Description.CHAIN_MAIL_SHIELD,
  "": Description.EMPTY,
  "hide armor": Description.HIDE_ARMOR,
  "hide armor, shield": Description.HIDE_ARMOR_SHIELD,
  "leather armor": Description.LEATHER_ARMOR,
  "leather armor, shield": Description.LEATHER_ARMOR_SHIELD,
  "natural armor": Description.NATURAL_ARMOR,
  "natural armor, shield": Description.NATURAL_ARMOR_SHIELD,
  "patchwork armor": Description.PATCHWORK_ARMOR,
  "plate": Description.PLATE,
  "scale mail": Description.SCALE_MAIL,
  "scale mail, shield": Description.SCALE_MAIL_SHIELD,
  "studded leather": Description.STUDDED_LEATHER,
  "16 with _barkskin_": Description.THE_16_WITH_BARKSKIN
});

enum ConditionImmunity { CHARMED, EXHAUSTION, FRIGHTENED, PARALYZED, POISONED, GRAPPLED, PETRIFIED, PRONE, RESTRAINED, UNCONSCIOUS, BLINDED, DEAFENED, NECROTIC, STUNNED }

final conditionImmunityValues = EnumValues({
  "Blinded": ConditionImmunity.BLINDED,
  "Charmed": ConditionImmunity.CHARMED,
  "Deafened": ConditionImmunity.DEAFENED,
  "Exhaustion": ConditionImmunity.EXHAUSTION,
  "Frightened": ConditionImmunity.FRIGHTENED,
  "Grappled": ConditionImmunity.GRAPPLED,
  "Necrotic": ConditionImmunity.NECROTIC,
  "Paralyzed": ConditionImmunity.PARALYZED,
  "Petrified": ConditionImmunity.PETRIFIED,
  "Poisoned": ConditionImmunity.POISONED,
  "Prone": ConditionImmunity.PRONE,
  "Restrained": ConditionImmunity.RESTRAINED,
  "Stunned": ConditionImmunity.STUNNED,
  "Unconscious": ConditionImmunity.UNCONSCIOUS
});

class HitPoints {
  final int max;
  final List<Die> dice;

  HitPoints({
    required this.max,
    required this.dice,
  });

  factory HitPoints.fromJson(Map<String, dynamic> json) => HitPoints(
    max: json["max"],
    dice: List<Die>.from(json["dice"].map((x) => Die.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "max": max,
    "dice": List<dynamic>.from(dice.map((x) => x.toJson())),
  };
}

class SavingThrows {
  final dynamic str;
  final dynamic dex;
  final dynamic con;
  final dynamic savingThrowsInt;
  final dynamic wis;
  final dynamic cha;

  SavingThrows({
    required this.str,
    required this.dex,
    required this.con,
    required this.savingThrowsInt,
    required this.wis,
    required this.cha,
  });

  factory SavingThrows.fromJson(Map<String, dynamic> json) => SavingThrows(
    str: json["str"],
    dex: json["dex"],
    con: json["con"],
    savingThrowsInt: json["int"],
    wis: json["wis"],
    cha: json["cha"],
  );

  Map<String, dynamic> toJson() => {
    "str": str,
    "dex": dex,
    "con": con,
    "int": savingThrowsInt,
    "wis": wis,
    "cha": cha,
  };
}

class Senses {
  final Darkvision? darkvision;
  final Blindsight? blindsight;
  final Blindsight? truesight;
  final Blindsight? tremorsense;

  Senses({
    this.darkvision,
    this.blindsight,
    this.truesight,
    this.tremorsense,
  });

  factory Senses.fromJson(Map<String, dynamic> json) => Senses(
    darkvision: darkvisionValues.map[json["Darkvision"]],
    blindsight: blindsightValues.map[json["Blindsight"]],
    truesight: blindsightValues.map[json["Truesight"]],
    tremorsense: blindsightValues.map[json["Tremorsense"]],
  );

  Map<String, dynamic> toJson() => {
    "Darkvision": darkvisionValues.reverse[darkvision],
    "Blindsight": blindsightValues.reverse[blindsight],
    "Truesight": blindsightValues.reverse[truesight],
    "Tremorsense": blindsightValues.reverse[tremorsense],
  };
}

enum Blindsight { THE_60_FT, THE_60_FT_BLIND_BEYOND_THIS_RADIUS, THE_10_FT, THE_30_FT, THE_30_FT_OR_10_FT_WHILE_DEAFENED_BLIND_BEYOND_THIS_RADIUS, THE_120_FT, THE_30_FT_BLIND_BEYOND_THIS_RADIUS }

final blindsightValues = EnumValues({
  "10 ft.": Blindsight.THE_10_FT,
  "120 ft.": Blindsight.THE_120_FT,
  "30 ft.": Blindsight.THE_30_FT,
  "30 ft. (blind beyond this radius)": Blindsight.THE_30_FT_BLIND_BEYOND_THIS_RADIUS,
  "30 ft. or 10 ft. while deafened (blind beyond this radius)": Blindsight.THE_30_FT_OR_10_FT_WHILE_DEAFENED_BLIND_BEYOND_THIS_RADIUS,
  "60 ft.": Blindsight.THE_60_FT,
  "60 ft. (blind beyond this radius)": Blindsight.THE_60_FT_BLIND_BEYOND_THIS_RADIUS
});

enum Darkvision { THE_120_FT, THE_60_FT, THE_30_FT, THE_90_FT, THE_60_FT_RAT_FORM_ONLY }

final darkvisionValues = EnumValues({
  "120 ft.": Darkvision.THE_120_FT,
  "30 ft.": Darkvision.THE_30_FT,
  "60 ft.": Darkvision.THE_60_FT,
  "60 ft. (rat form only)": Darkvision.THE_60_FT_RAT_FORM_ONLY,
  "90 ft.": Darkvision.THE_90_FT
});

enum Size { LARGE, MEDIUM, HUGE, GARGANTUAN, SMALL, TINY }

final sizeValues = EnumValues({
  "Gargantuan": Size.GARGANTUAN,
  "Huge": Size.HUGE,
  "Large": Size.LARGE,
  "Medium": Size.MEDIUM,
  "Small": Size.SMALL,
  "Tiny": Size.TINY
});

class Speed {
  final int walk;
  final dynamic burrow;
  final int climb;
  final dynamic fly;
  final bool hover;
  final int swim;

  Speed({
    required this.walk,
    required this.burrow,
    required this.climb,
    required this.fly,
    required this.hover,
    required this.swim,
  });

  factory Speed.fromJson(Map<String, dynamic> json) => Speed(
    walk: json["Walk"],
    burrow: json["Burrow"],
    climb: json["Climb"],
    fly: json["Fly"],
    hover: json["Hover"],
    swim: json["Swim"],
  );

  Map<String, dynamic> toJson() => {
    "Walk": walk,
    "Burrow": burrow,
    "Climb": climb,
    "Fly": fly,
    "Hover": hover,
    "Swim": swim,
  };
}

enum Subtype { EMPTY, ANY_RACE, DEMON, DEVIL, GOBLINOID, GNOME, SHAPECHANGER, ELF, DWARF, GNOLL, GRIMLOCK, HUMAN, KOBOLD, TITAN, LIZARDFOLK, MERFOLK, ORC, SAHUAGIN }

final subtypeValues = EnumValues({
  "Any race": Subtype.ANY_RACE,
  "Demon": Subtype.DEMON,
  "Devil": Subtype.DEVIL,
  "Dwarf": Subtype.DWARF,
  "Elf": Subtype.ELF,
  "": Subtype.EMPTY,
  "Gnoll": Subtype.GNOLL,
  "Gnome": Subtype.GNOME,
  "Goblinoid": Subtype.GOBLINOID,
  "Grimlock": Subtype.GRIMLOCK,
  "Human": Subtype.HUMAN,
  "Kobold": Subtype.KOBOLD,
  "Lizardfolk": Subtype.LIZARDFOLK,
  "Merfolk": Subtype.MERFOLK,
  "Orc": Subtype.ORC,
  "Sahuagin": Subtype.SAHUAGIN,
  "Shapechanger": Subtype.SHAPECHANGER,
  "Titan": Subtype.TITAN
});

class Trait {
  final String name;
  final String description;
  final int attackBonus;

  Trait({
    required this.name,
    required this.description,
    required this.attackBonus,
  });

  factory Trait.fromJson(Map<String, dynamic> json) => Trait(
    name: json["name"],
    description: json["description"],
    attackBonus: json["attack_bonus"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "description": description,
    "attack_bonus": attackBonus,
  };
}

enum Type { ABERRATION, HUMANOID, DRAGON, UNDEAD, ELEMENTAL, MONSTROSITY, CONSTRUCT, BEAST, PLANT, FIEND, OOZE, FEY, GIANT, CELESTIAL, SWARM_OF_TINY_BEASTS }

final typeValues = EnumValues({
  "Aberration": Type.ABERRATION,
  "Beast": Type.BEAST,
  "Celestial": Type.CELESTIAL,
  "Construct": Type.CONSTRUCT,
  "Dragon": Type.DRAGON,
  "Elemental": Type.ELEMENTAL,
  "Fey": Type.FEY,
  "Fiend": Type.FIEND,
  "Giant": Type.GIANT,
  "Humanoid": Type.HUMANOID,
  "Monstrosity": Type.MONSTROSITY,
  "Ooze": Type.OOZE,
  "Plant": Type.PLANT,
  "Swarm of Tiny beasts": Type.SWARM_OF_TINY_BEASTS,
  "Undead": Type.UNDEAD
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
