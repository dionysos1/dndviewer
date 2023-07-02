import 'dart:ui';

import 'package:dndviewer/globals.dart';
import 'package:dndviewer/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'favo_helper.dart';
import 'monster_list_model.dart';
import 'monster_model.dart';
import 'monster_provider.dart';
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(child: Text(value.name,)),
      ],
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
            childrenPadding: EdgeInsets.only(bottom: 10),
            title: Text(action.name),
            children: fillLegendaryTile(action),

          )
      ]),
    );
  }

  fillSubtitle(MonsterAction actions) {
    String subtileString = '';

    if (actions.actions.isNotEmpty) {
      for (ActionAction i in actions.actions) {
        subtileString += ' ${i.actionName}';
      }
      return Text(subtileString.trim());
    }
    return Text(subtileString.trim());
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