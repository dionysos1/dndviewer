import 'package:dndviewer/globals.dart';
import 'package:dndviewer/misc/custom_monster_helper.dart';
import 'package:dndviewer/models/monster_model.dart';
import 'package:dndviewer/views/monster_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../misc/favo_helper.dart';
import '../models/monster_list_model.dart';
import '../controllers/monster_list_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

String searchQuery = '';
var searchController = TextEditingController();

class HomeView extends StatefulWidget {
  const HomeView({super.key, required this.startIndex});

  final int startIndex;

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>
    with AutomaticKeepAliveClientMixin {
  int _selectedIndex = 0;
  ScrollController scrollController = ScrollController();

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    Provider.of<GetMonsterList>(context, listen: false).getMonsters();
    Provider.of<FavoriteController>(context, listen: false).getFavorites();
    Provider.of<CustomMonsterController>(context, listen: false).getCustomMonsters();

    _selectedIndex = widget.startIndex;

    super.initState();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      Provider.of<FavoriteController>(context, listen: false).getFavorites();
      Provider.of<CustomMonsterController>(context, listen: false).getCustomMonsters();
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
      floatingActionButton: FloatingActionButton(
        enableFeedback: true,
        backgroundColor: Colors.red.shade700,
        // onPressed: addMonsterDialog,
        onPressed: addMonsterDialog,
        tooltip: 'add Monster',
        child: const Icon(Icons.add),
      ),
    );
  }

  addMonsterDialog() {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text(
          'Add a Simple monster',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
          ),
        ),
        content: addMonsterDialogContent(),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              customMonster = Monster.empty();
              Navigator.pop(context, 'Cancel');
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              customMonsterController.setCustomMonster(itemToAdd: customMonster);
              Navigator.pop(context, 'Add');
              },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  addMonsterDialogContent() {
    /// add an empty monster to make sure every field is filled
    customMonster = Monster.empty();
    List<Widget> customMonsterList = [];

    String startSizeSelecterOption = 'Medium';
    List<String> sizeOptions = [
      'Tiny',
      'Small',
      'Medium',
      'Large',
      'Huge',
      'Gargantuan'
    ]; // List of options

    customMonsterList.add(Column(mainAxisSize: MainAxisSize.min, children: [
      /// name
      TextFormField(
        decoration: InputDecoration(labelText: 'name'),
        onChanged: (value) {
          customMonster.name = value;
          /// replace space with dash for index
          customMonster.index = value.replaceSpacesWithDashes();
        },
      ),
      const SizedBox(
        height: 10,
      ),
      /// size
      DropdownButtonFormField<String>(
        value: startSizeSelecterOption,
        items: sizeOptions.map((String option) {
          return DropdownMenuItem<String>(
            value: option,
            child: Text(option),
          );
        }).toList(),
        onChanged: (String? newValue) {
          customMonster.size = newValue as String;
        },
        decoration: const InputDecoration(
          labelText: 'Size',
          border: OutlineInputBorder(),
        ),
      ),
      /// AC
      TextFormField(
        keyboardType: TextInputType.number,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly
        ],
        decoration: InputDecoration(labelText: 'AC'),
        onChanged: (value) {
          customMonster.armorClass.first.value = int.parse(value);
        },
      ),
      /// HP
      TextFormField(
        keyboardType: TextInputType.number,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly
        ],
        decoration: InputDecoration(labelText: 'Hitpoints'),
        onChanged: (value) {
          customMonster.hitPoints = int.parse(value);
        },
      ),
      const SizedBox(
        height: 10,
      ),
      /// picture
      InkWell(
        onTap: () => _selectImage(context, _handleImageSelected),
        child: const Icon(Icons.add_a_photo),
      ),

    ]));

    return SingleChildScrollView(child: Column(children: customMonsterList));
  }
}

void _handleImageSelected(File image) {
  // Handle the selected image here
  // You can save the image path, display the image, etc.
  print('Selected image: ${image.path}');
  customMonster.image = image.path;
}

void _selectImage(BuildContext context, Function(File) onImageSelected) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Select Image'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Camera'),
              onTap: () async {
                final image = await _getImage(ImageSource.camera);
                if (image != null) {
                  onImageSelected(image);
                  Navigator.pop(context);
                }
              },
            ),
            ListTile(
              leading: Icon(Icons.photo_library),
              title: Text('Gallery'),
              onTap: () async {
                final image = await _getImage(ImageSource.gallery);
                if (image != null) {
                  onImageSelected(image);
                  Navigator.pop(context);
                }
              },
            ),
          ],
        ),
      );
    },
  );
}

Future<File?> _getImage(ImageSource source) async {
  final picker = ImagePicker();
  final pickedFile = await picker.pickImage(source: source);

  if (pickedFile != null) {
    final appDir = await getApplicationDocumentsDirectory();
    final fileName = DateTime.now().toIso8601String();
    final savedImagePath = '${appDir.path}/$fileName.png';

    final pickedFileTemporary = File(pickedFile.path);

    final savedImage = await pickedFileTemporary.copy(savedImagePath);

    return savedImage;
  }

  return null;
}

class mainItem {
  monsterList() {
    return Consumer<GetMonsterList>(
      builder: (context, value, child) {
        /// add customMonsters
        value = insertAndCheck(value);

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
                          builder: (context) =>
                              MonsterDetailPage(value.monsters.results[index]),
                        ),
                      ).then((value) {
                        // Navigator.pushReplacement(context, MaterialPageRoute(
                        //   builder: (context) => HomeView(startIndex: 0, scrollIndex: index,),
                        // ),);
                      }));
            });
      },
    );
  }

  GetMonsterList insertAndCheck(GetMonsterList value) {
    value.monsters.results.removeWhere((result) =>
        globalCustomMonsterList.any((customResult) => customResult.index == result.index));
    value.monsters.results.insertAll(0, globalCustomMonsterList);
    return value;
  }
}

class Favorites {
  showFavorites() {
    return Consumer<FavoriteController>(builder: (context, value, child) {
      return value.favorites.isEmpty
          ? const Center(child: Text('No favorites yet..'))
          : ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: value.favorites.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                    title: Text(value.favorites[index].name),
                    subtitle: Text(value.favorites[index].url),
                    leading: Text((index + 1).toString()),
                    trailing: const Icon(Icons.arrow_forward_ios_rounded),
                    onTap: () =>
                        // Navigate to the MonsterDetailPage
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                MonsterDetailPage(value.favorites[index]),
                          ),
                        ).then((value) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HomeView(startIndex: 1),
                            ),
                          );
                        }));
              });
    });
  }
}
