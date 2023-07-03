import 'dart:ui';
import 'package:dndviewer/globals.dart';
import 'package:dndviewer/views/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../misc/favo_helper.dart';
import '../models/monster_list_model.dart';
import '../models/monster_model.dart';
import '../controllers/monster_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';

class MonsterDetailPage extends StatefulWidget {
  final Result monster;

  const MonsterDetailPage(this.monster, {super.key});

  @override
  State<MonsterDetailPage> createState() => MonsterDetailPageState();
}

class MonsterDetailPageState extends State<MonsterDetailPage> {
  bool isFavorite = false;

  @override
  void initState() {
    var fetchData = Provider.of<GetMonster>(context, listen: false);
    fetchData.getMonsterInfo(widget.monster.url);
    isFavoriteCheck();
    super.initState();
  }

  isFavoriteCheck(){
    for (Result resultObject in globalFavorites) {
      print('${resultObject.index} =? ${widget.monster.index}');
      if (resultObject.index == widget.monster.index) {
        isFavorite = true;
        break;
      }
    }
  }

  addOrRemoveFavorite() async {
    if (isFavorite) {
      bool succes = await favos.removeFavorite(itemToRemove: widget.monster);
      SnackBar snackBar = SnackBar(
        backgroundColor: succes ? Colors.green : Colors.red,
        content: Text('Your favorite was ${succes ? '' : 'not'}removed.'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);

      setState(() {
        isFavorite = false;
      });
    } else {
      bool succes = await favos.setFavorite(itemToAdd: widget.monster);
      SnackBar snackBar = SnackBar(
        backgroundColor: succes ? Colors.green : Colors.red,
        content: Text('Your favorite was ${succes ? '' : 'not'}saved.'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      setState(() {
        isFavorite = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GetMonster>(
        builder: (context, value, child) {
          bool imageAvailable = value.monster.image.isNotEmpty;
          return value.monster.name == '' ? Center(child:SizedBox(width: 100, height: 100, child: CircularProgressIndicator())) : DefaultTabController(
            length: imageAvailable ? 3 : 2,
            child: Scaffold(
              appBar: AppBar(
                bottom: TabBar(tabs: [
                  Tab(child: Text('Stats')),
                  Tab(child: Text('Actions')),
                  if(value.monster.image.isNotEmpty) Tab(child: Text('Image')),
                ]),
                backgroundColor: Colors.red.shade700,
                title: Center(child: Text(widget.monster.name)),
                actions: [Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: InkResponse(
                    onTap: () => addOrRemoveFavorite(),
                    child: isFavorite ? const Icon(Icons.favorite) : const Icon(
                        Icons.favorite_border_rounded),
                  ),
                )
                ],
              ),
              body: TabBarView(children: [
                monsterInfo(value.monster),
                actionInfo(value.monster),
                if(value.monster.image.isNotEmpty) imageTab(value.monster.image),
              ]),

            ),
          );
        });
  }

  monsterInfo(Monster value) {
    return SingleChildScrollView(
      child: Column(
        children: mainStats(value)



      ),
    );
  }

  mainStats(Monster value){
    List<Widget> statblocks = [];
    // statblocks.add();
    statblocks.add(const SizedBox(height: 15,));
    /// size type and alignment
    statblocks.add(Text('${value.size} ${value.type}, ${value.alignment}'));
    /// Divider
    statblocks.add(Padding(
      padding: const EdgeInsets.all(8.0),
      child: Divider(color: Colors.red.shade700, indent: 10, endIndent: 10,),
    ));
    /// Challenge Rating
    statblocks.add(Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: Row(
        children: [
          const Text('Challenge Rating: ', style: TextStyle(fontWeight: FontWeight.bold),),
          Text('${value.challengeRating} (${value.xp} XP)'),
        ],
      ),
    ));
    /// AC
    statblocks.add(Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: Row(
        children: [
          const Text('Armor Class: ', style: TextStyle(fontWeight: FontWeight.bold),),
          Text('${value.armorClass.first.value} (${value.armorClass.first.type})'),
        ],
      ),
    ));
    /// HP and avg. roll
    statblocks.add(Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: Row(
        children: [
          const Text('Hit Points: ', style: TextStyle(fontWeight: FontWeight.bold),),
          Text('${value.hitPoints}'),
          Text(' (hp roll: ${value.hitPointsRoll})', style: TextStyle(fontStyle: FontStyle.italic),)
        ],
      ),
    ));
    /// Speed
    statblocks.add(Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: Row(
        children: [
          const Text('Speed: ', style: TextStyle(fontWeight: FontWeight.bold),),
          Flexible(
            child: Wrap(
              children: checkSpeed(value.speed),
            ),
          ),
        ],
      ),
    ));
    /// Hit Die
    statblocks.add(Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: Row(
        children: [
          const Text('Hit Die: ', style: TextStyle(fontWeight: FontWeight.bold),),
          Text('${value.hitDice}'),
        ],
      ),
    ));
    /// Divider
    statblocks.add(Padding(
      padding: const EdgeInsets.all(8.0),
      child: Divider(color: Colors.red.shade700, indent: 10, endIndent: 10,),
    ));
    /// Stats
    statblocks.add(Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          miniStatBlock(stat: 'STR', value: value.strength.toString()),
          miniStatBlock(stat: 'DEX', value: value.dexterity.toString()),
          miniStatBlock(stat: 'CON', value: value.constitution.toString()),
      ],),
      const SizedBox(height: 15,),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          miniStatBlock(stat: 'INT', value: value.intelligence.toString()),
          miniStatBlock(stat: 'WIS', value: value.wisdom.toString()),
          miniStatBlock(stat: 'CHA', value: value.charisma.toString()),
      ],)
    ],));
    /// Divider
    statblocks.add(Padding(
      padding: const EdgeInsets.all(8.0),
      child: Divider(color: Colors.red.shade700, indent: 10, endIndent: 10,),
    ));
    /// saving throws
    statblocks.add(Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: Row(children: [
        const Text('Saving Throws: ', style: TextStyle(fontWeight: FontWeight.bold),),
        const SizedBox(width: 2,),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (ProficiencyElement i in value.proficiencies)
              if (i.proficiency.index.contains('saving')) Text('${i.proficiency.name.replaceFirst('Saving Throw: ', '')}: ${i.value}'),
          ],
        ),
      ],),
    ));
    /// Divider
    statblocks.add(Align(alignment: Alignment.centerLeft, child: Padding(
      padding: const EdgeInsets.only(left: 150),
      child: SizedBox(width: 100, child: Divider(color: Colors.red.shade700, )),
    )));
    /// Skills
    statblocks.add(Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: Row(children: [
        const Text('Skills: ', style: TextStyle(fontWeight: FontWeight.bold),),
        const SizedBox(width: 62,),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (ProficiencyElement i in value.proficiencies)
              if (i.proficiency.index.contains('skill')) Text('${i.proficiency.name.replaceFirst('Skill: ', '')}: ${i.value}'),
          ],
        ),
      ],),
    ));
    /// Divider
    statblocks.add(Align(alignment: Alignment.centerLeft, child: Padding(
      padding: const EdgeInsets.only(left: 150),
      child: SizedBox(width: 100, child: Divider(color: Colors.red.shade700, )),
    )));
    /// senses
    statblocks.add(Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: Row(children: [
        const Text('Senses: ', style: TextStyle(fontWeight: FontWeight.bold),),
        const SizedBox(width: 50,),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if(value.senses.darkvision.isNotEmpty) Text('Darkvision: ${value.senses.darkvision}'),
            Text('Passive perception: ${value.senses.passivePerception}'),
          ],
        ),
      ],),
    ));
    /// Divider
    statblocks.add(Align(alignment: Alignment.centerLeft, child: Padding(
      padding: const EdgeInsets.only(left: 150),
      child: SizedBox(width: 100, child: Divider(color: Colors.red.shade700, )),
    )));
    /// Languages
    statblocks.add(Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: Row(
        children: [
          const Text('Languages: ', style: TextStyle(fontWeight: FontWeight.bold),),
          const SizedBox(width: 26,),
          Flexible(child: Wrap(children: [Text('${value.languages}', softWrap: true,)])),
        ],
      ),
    ));
    /// Divider
    statblocks.add(Padding(
      padding: const EdgeInsets.all(8.0),
      child: Divider(color: Colors.red.shade700, indent: 10, endIndent: 10,),
    ));
    /// special abilities
    if (value.specialAbilities.isNotEmpty){
      List<Widget> abilities = [];
      for (SpecialAbility i in value.specialAbilities) {
        abilities.add(Row(children: [
          Text('${i.name}. ', style: const TextStyle(fontWeight: FontWeight.bold),),
          if (i.dc != Dc.empty()) Text('(DC: ${i.dc.dcType.name} ${i.dc.dcValue})', style: const TextStyle(fontStyle: FontStyle.italic)),
        ],));
        abilities.add(Align(alignment: Alignment.centerLeft,child: Text('${i.desc}', softWrap: true, textAlign: TextAlign.left,)),);
        abilities.add(Divider(color: Colors.red.shade700, indent: 132, endIndent: 132,));
      }
      statblocks.add(Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: Column(children: abilities),
      )

    );
    }

    return statblocks;
  }

  checkSpeed(Speed value) {

    final speeds = {
      'walk': value.walk,
      'swim': value.swim,
      'burrow': value.burrow,
      'fly': value.fly,
      'climb': value.climb,
      'hover': value.hover,
    };

    return speeds.entries
        .where((entry) => entry.value.isNotEmpty && entry.value != 'null')
        .map((entry) => Text('${entry.key}: ${entry.value} '))
        .toList();

  }

  miniStatBlock({required String stat, required String value}){
    return Container(
      width: 50,
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0), // Set rounded corners
        border: Border.all(width: 2.0, color: Colors.red.shade700), // Set 2px border

      ),
      child: Column(mainAxisAlignment: MainAxisAlignment.center,
        children: [
        Text(stat, style: TextStyle(fontWeight: FontWeight.bold),),
        Text(value, style: TextStyle(color: Colors.grey, fontStyle: FontStyle.italic),)
      ],),
    );
  }

  actionInfo(Monster value) {
    return SingleChildScrollView(
      child: Column(mainAxisAlignment: MainAxisAlignment.start,
          children: [

        for (MonsterAction action in value.actions)
          ExpansionTile(
              title: Text(action.name),
              subtitle: fillSubtitle(action),
            children: fillActionsTile(action),
          ),
        for (LegendaryAction action in value.legendaryActions)
          ExpansionTile(
            childrenPadding: const EdgeInsets.only(bottom: 10),
            title: Text(action.name),
            children: fillLegendaryTile(action),

          )
      ]),
    );
  }

  fillSubtitle(MonsterAction actions) {
    String subtitleString = '';

    if (actions.actions.isNotEmpty) {
      for (int i = 0; i < actions.actions.length; i++) {
        ActionAction action = actions.actions[i];
        subtitleString += i == 0 ? action.actionName : ' | ${action.actionName}';
      }
      return Text(subtitleString.trim());
    }
    return Text(subtitleString.trim());
  }

  fillActionsTile(MonsterAction action) {
    List<Widget> expansionList = [];

    expansionList.add(Padding(
      padding: const EdgeInsets.all(15.0),
      child: Text(action.desc),
    ));

    return expansionList;
  }

  imageTab(String imageUrl) {
      return SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Positioned.fill(
              child: ImageBlurBackground(imageUrl: apiUrl + imageUrl,),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(5.0),
              child: CachedNetworkImage(
                imageUrl: apiUrl + imageUrl,
                imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    image: DecorationImage(
                      fit: BoxFit.contain,
                      image: imageProvider,
                    ),
                  ),
                ),
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    Center(child: CircularProgressIndicator(value: downloadProgress.progress)),
                errorWidget: (context, url, error) =>
                const Icon(Icons.error_outline),
              ),
            ),
          ],
        ),
      );
  }

  fillLegendaryTile(LegendaryAction action) {
    List<Widget> expansionList = [];

    expansionList.add(Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(action.desc),
    ));


    if(action.attackBonus != -1) {
      expansionList.add(Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text('Attack Bonus: ${action.attackBonus}'),
      ));
    }

    if(action.damage.isNotEmpty) {
      for (Damage dmg in action.damage) {
        expansionList.add(Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('Damage Type: ${dmg.damageType.name}'),
        ));
        expansionList.add(Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('Damage Dice: ${dmg.damageDice}'),
        ));
      }

    }
    return expansionList;
  }


}

class ImageBlurBackground extends StatelessWidget {
  final String imageUrl;

  const ImageBlurBackground({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        /// Background image
        CachedNetworkImage(
          imageUrl: imageUrl,
          imageBuilder: (context, imageProvider) => Container(
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: imageProvider,
              ),
            ),
          ),
        ),
        /// Blurred overlay
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            color: Colors.black.withOpacity(0.4),
          ),
        ),
      ],
    );
  }
}