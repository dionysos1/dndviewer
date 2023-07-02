import 'package:dndviewer/monster_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'monster_list_model.dart';
import 'monster_list_provider.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    var fetchData = Provider.of<GetMonsterList>(context, listen: false);
    fetchData.getMonsters();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red.shade700,
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 25.0, bottom: 15),
            child: Center(
              child: Text(
                'Monsters',
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
          Expanded(
            child: monsterList(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        enableFeedback: true,
        backgroundColor: Colors.red.shade700,
        onPressed: addMonster,
        tooltip: 'add Monster',
        child: const Icon(Icons.add),
      ),
    );
  }

  addMonster() {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Simple add Monster'),
        content: const Text('Hier komt iets'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, 'Add'),
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  monsterList() {
    return Consumer<GetMonsterList>(
      builder: (context, value, child) {
        /// sort on challenge rating
        // List<Result> monsterList = value.monsters.results;
        // monsterList.sort((a, b) => a.challengeRating.compareTo(b.challengeRating));
        //
        // monsterList.sort((a, b) {
        //   int challengeRatingComp = a.challengeRating.compareTo(b.challengeRating);
        //   if (challengeRatingComp == 0) {
        //     return a.name.compareTo(b.name); // '-' for descending
        //   }
        //   return challengeRatingComp;
        // });

        return ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: value.monsters.results.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text(value.monsters.results[index].name),
                subtitle: Text(value.monsters.results[index].url),
                leading: Text((index + 1).toString()),
                trailing: const Icon(Icons.arrow_forward_ios_rounded),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MonsterDetailPage(
                          url: value.monsters.results[index].url,
                          index: value.monsters.results[index].index,
                          name: value.monsters.results[index].name)),
                ),
              );
            });
      },
    );
  }
}
