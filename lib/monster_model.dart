// To parse this JSON data, do
//
//     final monster = monsterFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

Monster monsterFromJson(String str) => Monster.fromJson(json.decode(str));

String monsterToJson(Monster data) => json.encode(data.toJson());

class Monster {
  String index;
  String name;
  String size;
  String type;
  String alignment;
  List<ArmorClass> armorClass;
  int hitPoints;
  String hitDice;
  String hitPointsRoll;
  Speed speed;
  int strength;
  int dexterity;
  int constitution;
  int intelligence;
  int wisdom;
  int charisma;
  List<ProficiencyElement> proficiencies;
  List<dynamic> damageVulnerabilities;
  List<dynamic> damageResistances;
  List<dynamic> damageImmunities;
  List<dynamic> conditionImmunities;
  Senses senses;
  String languages;
  double challengeRating;
  int xp;
  List<SpecialAbility> specialAbilities;
  List<MonsterAction> actions;
  List<LegendaryAction> legendaryActions;
  String image;
  String url;

  Monster({
    required this.index,
    required this.name,
    required this.size,
    required this.type,
    required this.alignment,
    required this.armorClass,
    required this.hitPoints,
    required this.hitDice,
    required this.hitPointsRoll,
    required this.speed,
    required this.strength,
    required this.dexterity,
    required this.constitution,
    required this.intelligence,
    required this.wisdom,
    required this.charisma,
    required this.proficiencies,
    required this.damageVulnerabilities,
    required this.damageResistances,
    required this.damageImmunities,
    required this.conditionImmunities,
    required this.senses,
    required this.languages,
    required this.challengeRating,
    required this.xp,
    required this.specialAbilities,
    required this.actions,
    required this.legendaryActions,
    required this.image,
    required this.url,
  });

  factory Monster.fromJson(Map<String, dynamic> json) => Monster(
    index: json["index"] ?? '',
    name: json["name"] ?? '',
    size: json["size"] ?? '',
    type: json["type"] ?? '',
    alignment: json["alignment"] ?? '',
    armorClass: json["armor_class"] != null ? List<ArmorClass>.from(json["armor_class"].map((x) => ArmorClass.fromJson(x))) : [],
    hitPoints: json["hit_points"] ?? -1,
    hitDice: json["hit_dice"] ?? '',
    hitPointsRoll: json["hit_points_roll"] ?? '',
    speed: json["speed"] != null ? Speed.fromJson(json["speed"]) : Speed(walk: '', swim: ''),
    strength: json["strength"] ?? -1,
    dexterity: json["dexterity"] ?? -1,
    constitution: json["constitution"] ?? -1,
    intelligence: json["intelligence"] ?? -1,
    wisdom: json["wisdom"] ?? -1,
    charisma: json["charisma"] ?? -1,
    proficiencies: json["proficiencies"] != null ? List<ProficiencyElement>.from(json["proficiencies"].map((x) => ProficiencyElement.fromJson(x))) : [],
    damageVulnerabilities: json["damage_vulnerabilities"] != null ? List<dynamic>.from(json["damage_vulnerabilities"].map((x) => x)) : [],
    damageResistances: json["damage_resistances"] != null ? List<dynamic>.from(json["damage_resistances"].map((x) => x)) : [],
    damageImmunities: json["damage_immunities"] != null ? List<dynamic>.from(json["damage_immunities"].map((x) => x)) : [],
    conditionImmunities: json["condition_immunities"] != null ? List<dynamic>.from(json["condition_immunities"].map((x) => x)) : [],
    senses: json["senses"] != null ? Senses.fromJson(json["senses"]) : Senses(darkvision: '', passivePerception: -1),
    languages: json["languages"]  ?? '',
    challengeRating: json["challenge_rating"] ?? -1,
    xp: json["xp"] ?? -1,
    specialAbilities: json["special_abilities"] != null ? List<SpecialAbility>.from(json["special_abilities"].map((x) => SpecialAbility.fromJson(x))) : [],
    actions: json["actions"] != null ? List<MonsterAction>.from(json["actions"].map((x) => MonsterAction.fromJson(x))) : [],
    legendaryActions: json["legendary_actions"] != null ? List<LegendaryAction>.from(json["legendary_actions"].map((x) => LegendaryAction.fromJson(x))) : [],
    image: json["image"] ?? '',
    url: json["url"] ?? '',
  );

  Map<String, dynamic> toJson() => {
    "index": index,
    "name": name,
    "size": size,
    "type": type,
    "alignment": alignment,
    "armor_class": List<dynamic>.from(armorClass.map((x) => x.toJson())),
    "hit_points": hitPoints,
    "hit_dice": hitDice,
    "hit_points_roll": hitPointsRoll,
    "speed": speed.toJson(),
    "strength": strength,
    "dexterity": dexterity,
    "constitution": constitution,
    "intelligence": intelligence,
    "wisdom": wisdom,
    "charisma": charisma,
    "proficiencies": List<dynamic>.from(proficiencies.map((x) => x.toJson())),
    "damage_vulnerabilities": List<dynamic>.from(damageVulnerabilities.map((x) => x)),
    "damage_resistances": List<dynamic>.from(damageResistances.map((x) => x)),
    "damage_immunities": List<dynamic>.from(damageImmunities.map((x) => x)),
    "condition_immunities": List<dynamic>.from(conditionImmunities.map((x) => x)),
    "senses": senses.toJson(),
    "languages": languages,
    "challenge_rating": challengeRating,
    "xp": xp,
    "special_abilities": List<dynamic>.from(specialAbilities.map((x) => x.toJson())),
    "actions": List<dynamic>.from(actions.map((x) => x.toJson())),
    "legendary_actions": List<dynamic>.from(legendaryActions.map((x) => x.toJson())),
    "image": image,
    "url": url,
  };

  static empty() {
    return Monster(
        index: '',
        name: '',
        size: '',
        type: '',
        alignment: '',
        armorClass: [],
        hitPoints: -1,
        hitDice: '',
        hitPointsRoll: '',
        speed: Speed(walk: '', swim: ''),
        strength: -1,
        dexterity: -1,
        constitution: -1,
        intelligence: -1,
        wisdom: -1,
        charisma: -1,
        proficiencies: [],
        damageVulnerabilities: [],
        damageResistances: [],
        damageImmunities: [],
        conditionImmunities: [],
        senses: Senses(darkvision: '', passivePerception: -1),
        languages: '',
        challengeRating: -1,
        xp: -1,
        specialAbilities: [],
        actions: [],
        legendaryActions: [],
        image: '',
        url: '',
    );
  }
}

class MonsterAction {
  String name;
  String multiattackType;
  String desc;
  List<ActionAction> actions;
  int attackBonus;
  Dc dc;
  List<Damage> damage;
  Usage usage;

  MonsterAction({
    required this.name,
    required this.multiattackType,
    required this.desc,
    required this.actions,
    required this.attackBonus,
    required this.dc,
    required this.damage,
    required this.usage,
  });

  factory MonsterAction.fromJson(Map<String, dynamic> json) => MonsterAction(
    name: json["name"] ?? '',
    multiattackType: json["multiattack_type"] ?? '',
    desc: json["desc"] ?? '',
    actions: List<ActionAction>.from(json["actions"].map((x) => ActionAction.fromJson(x))),
    attackBonus: json.containsKey("attack_bonus") ? json["attack_bonus"] : -1,
    dc: json.containsKey("dc") ? Dc.fromJson(json["dc"]) : Dc.empty(),
    damage: json.containsKey("damage") ? List<Damage>.from(json["damage"].map((x) => Damage.fromJson(x))) : [],
    usage: json.containsKey("usage") ? Usage.fromJson(json["usage"]) : Usage(type: '', times: -1),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "multiattack_type": multiattackType,
    "desc": desc,
    "actions": List<dynamic>.from(actions.map((x) => x.toJson())),
    "attack_bonus": attackBonus,
    "dc": dc.toJson(),
    "damage": List<dynamic>.from(damage.map((x) => x.toJson())),
    "usage": usage.toJson(),
  };
}

class ActionAction {
  String actionName;
  int count;
  String type;

  ActionAction({
    required this.actionName,
    required this.count,
    required this.type,
  });

  factory ActionAction.fromJson(Map<String, dynamic> json) => ActionAction(
    actionName: json["action_name"],
    count: json["count"],
    type: json["type"],
  );

  Map<String, dynamic> toJson() => {
    "action_name": actionName,
    "count": count,
    "type": type,
  };
}

class Damage {
  DcTypeClass damageType;
  String damageDice;

  Damage({
    required this.damageType,
    required this.damageDice,
  });

  factory Damage.fromJson(Map<String, dynamic> json) => Damage(
    damageType: DcTypeClass.fromJson(json["damage_type"]),
    damageDice: json["damage_dice"],
  );

  Map<String, dynamic> toJson() => {
    "damage_type": damageType.toJson(),
    "damage_dice": damageDice,
  };
}

class DcTypeClass {
  String index;
  String name;
  String url;

  DcTypeClass({
    required this.index,
    required this.name,
    required this.url,
  });

  factory DcTypeClass.fromJson(Map<String, dynamic> json) => DcTypeClass(
    index: json["index"],
    name: json["name"],
    url: json["url"],
  );

  Map<String, dynamic> toJson() => {
    "index": index,
    "name": name,
    "url": url,
  };

  static empty() {
    return DcTypeClass(index: '', name: '', url: '');
  }
}

class Dc {
  DcTypeClass dcType;
  int dcValue;
  String successType;

  Dc({
    required this.dcType,
    required this.dcValue,
    required this.successType,
  });

  factory Dc.fromJson(Map<String, dynamic> json) => Dc(
    dcType: DcTypeClass.fromJson(json["dc_type"]),
    dcValue: json["dc_value"],
    successType: json["success_type"],
  );

  Map<String, dynamic> toJson() => {
    "dc_type": dcType.toJson(),
    "dc_value": dcValue,
    "success_type": successType,
  };

  static empty() {
    return Dc(dcType: DcTypeClass.empty(), dcValue: -1, successType: '');
  }
}

class Usage {
  String type;
  int times;

  Usage({
    required this.type,
    required this.times,
  });

  factory Usage.fromJson(Map<String, dynamic> json) => Usage(
    type: json["type"] ?? '',
    times: json["times"] ?? -1,
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "times": times,
  };
}

class ArmorClass {
  String type;
  int value;

  ArmorClass({
    required this.type,
    required this.value,
  });

  factory ArmorClass.fromJson(Map<String, dynamic> json) => ArmorClass(
    type: json["type"],
    value: json["value"],
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "value": value,
  };
}

class LegendaryAction {
  String name;
  String desc;
  int attackBonus;
  List<Damage> damage;

  LegendaryAction({
    required this.name,
    required this.desc,
    required this.attackBonus,
    required this.damage,
  });

  factory LegendaryAction.fromJson(Map<String, dynamic> json) => LegendaryAction(
    name: json["name"],
    desc: json["desc"],
    attackBonus: json.containsKey("attack_bonus") ? json["attack_bonus"] ?? -1 : -1,
    damage: json.containsKey("damage") ? List<Damage>.from(json["damage"].map((x) => Damage.fromJson(x))) : [],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "desc": desc,
    "attack_bonus": attackBonus,
    "damage": List<dynamic>.from(damage.map((x) => x.toJson())),
  };
}

class ProficiencyElement {
  int value;
  DcTypeClass proficiency;

  ProficiencyElement({
    required this.value,
    required this.proficiency,
  });

  factory ProficiencyElement.fromJson(Map<String, dynamic> json) => ProficiencyElement(
    value: json["value"],
    proficiency: DcTypeClass.fromJson(json["proficiency"]),
  );

  Map<String, dynamic> toJson() => {
    "value": value,
    "proficiency": proficiency.toJson(),
  };
}

class Senses {
  String darkvision;
  int passivePerception;

  Senses({
    required this.darkvision,
    required this.passivePerception,
  });

  factory Senses.fromJson(Map<String, dynamic> json) => Senses(
    darkvision: json["darkvision"] ?? '',
    passivePerception: json["passive_perception"] ?? -1,
  );

  Map<String, dynamic> toJson() => {
    "darkvision": darkvision,
    "passive_perception": passivePerception,
  };
}

class SpecialAbility {
  String name;
  String desc;
  Dc dc;

  SpecialAbility({
    required this.name,
    required this.desc,
    required this.dc,
  });

  factory SpecialAbility.fromJson(Map<String, dynamic> json) => SpecialAbility(
    name: json["name"] ?? '',
    desc: json["desc"] ?? '',
    dc: json.containsKey("dc") ? Dc.fromJson(json["dc"]) : Dc.empty(),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "desc": desc,
    "dc": dc.toJson(),
  };
}

class Speed {
  String walk;
  String swim;

  Speed({
    required this.walk,
    required this.swim,
  });

  factory Speed.fromJson(Map<String, dynamic> json) => Speed(
    walk: json["walk"] ?? '',
    swim: json["swim"] ?? '',
  );

  Map<String, dynamic> toJson() => {
    "walk": walk,
    "swim": swim,
  };
}
