import 'package:dndviewer/globals.dart';
import 'package:dndviewer/monster_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'favo_helper.dart';
import 'monster_list_model.dart';
import 'monster_list_provider.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key, required this.startIndex});

  final int startIndex;

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with AutomaticKeepAliveClientMixin {
  int _selectedIndex = 0;
  ScrollController scrollController = ScrollController();

  @override
  bool get wantKeepAlive => true;


  @override
  void initState() {
    Provider.of<GetMonsterList>(context, listen: false).getMonsters();
    Provider.of<FavoriteController>(context, listen: false).getFavorites();

    _selectedIndex = widget.startIndex;

    super.initState();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      var fetchFavorites = Provider.of<FavoriteController>(context, listen: false);
      fetchFavorites.getFavorites();
    });
  }

  static final List<Widget> _widgetOptions = <Widget>[
    mainItem().monsterList(),
    Favorites().showFavorites(),
  ];

  @override
  Widget build(BuildContext context) {
    super.build(context);
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red.shade700,
        title: const Text('DnD Monster viewer'),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.red.shade700,
        onTap: _onItemTapped,
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
    );
  }
}

class mainItem {

  monsterList() {
    return Consumer<GetMonsterList>(
      builder: (context, value, child) {
        return ListView.builder(
            controller: ScrollController(),
            padding: const EdgeInsets.all(8),
            cacheExtent: value.monsters.results.length * 100,
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
                    builder: (context) => MonsterDetailPage(value.monsters.results[index]),
                  ),
                ).then((value) {
                  // Navigator.pushReplacement(context, MaterialPageRoute(
                  //   builder: (context) => HomeView(startIndex: 0, scrollIndex: index,),
                  // ),);
                })
              );
            });
      },
    );
  }
}

class Favorites {
  showFavorites() {
    return Consumer<FavoriteController>(
    builder: (context, value, child)
    {
      return value.favorites.isEmpty ? Center(child: Text('No favorites yet..')) : ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: value.favorites.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Text(value. favorites[index].name),
              subtitle: Text(value. favorites[index].url),
              leading: Text((index + 1).toString()),
              trailing: const Icon(Icons.arrow_forward_ios_rounded),
              onTap: () =>
              // Navigate to the MonsterDetailPage
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MonsterDetailPage(value.favorites[index]),
                ),
              ).then((value) {
                Navigator.pushReplacement(context, MaterialPageRoute(
                  builder: (context) => HomeView(startIndex: 1),
                ),);
              })
            );
          });
    });
  }
}
