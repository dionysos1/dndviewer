import 'package:flutter/material.dart';
import 'Monster_Provider.dart';
import 'package:provider/provider.dart';

import 'monsterModel.dart';


class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    var fetchData = Provider.of<getData>(context, listen: false);
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
    return Consumer<getData>(
      builder: (context, value, child) {

        List<Monsters> monsterList = value.monsters;
        monsterList.sort((a, b) => a.challengeRating.compareTo(b.challengeRating));

        monsterList.sort((a, b) {
          int challengeRatingComp = a.challengeRating.compareTo(b.challengeRating);
          if (challengeRatingComp == 0) {
            return a.name.compareTo(b.name); // '-' for descending
          }
          return challengeRatingComp;
        });

        return ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: value.monsters.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text(monsterList[index].name),
                subtitle: Text(monsterList[index].type.name),
                leading: Text(monsterList[index].challengeRating.toString()),
                trailing: const Icon(Icons.arrow_forward_ios_rounded),
                onTap: () => (),
              );
            });
      },
    );
  }
}
