import 'package:dndviewer/globals.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'monster_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';

class MonsterDetailPage extends StatefulWidget {
  const MonsterDetailPage({super.key, required this.url, required this.index, required this.name});

  final String url;
  final String index;
  final String name;

  @override
  State<MonsterDetailPage> createState() => MonsterDetailPageState();
}

class MonsterDetailPageState extends State<MonsterDetailPage> {
  @override
  void initState() {
    var fetchData = Provider.of<GetMonster>(context, listen: false);
    fetchData.getMonsterInfo(widget.url);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red.shade700,
        title: Text(widget.name),
      ),
      body: monsterInfo(),

    );
  }

  monsterInfo() {
    return Consumer<GetMonster>(
      builder: (context, value, child) {


        return value.monster.name == '' ? const LinearProgressIndicator() : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CachedNetworkImage(
              imageUrl: apiUrl + value.monster.image,
              imageBuilder: (context, imageProvider) => Container(
                width: 400,
                height: 400,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.fitWidth,
                    image: imageProvider,
                  ),
                ),
              ),
              placeholder: (BuildContext context, String url) =>
              const Icon(Icons.file_download),
              errorWidget: (context, url, error) =>
              const Icon(Icons.error_outline),
            ),
            Center(child: Text(value.monster.name,)),
          ],
        );
      },
    );
  }
}
