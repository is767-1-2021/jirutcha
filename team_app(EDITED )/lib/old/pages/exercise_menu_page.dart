import 'package:flutter/material.dart';
import 'exercise_menu_detail.dart';

class ExerciseMenu extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    final List<String> entries = <String>[
      'Cycling', 
      'Boxing',
      'Running', 
      'Swimming',
      'Pilatis', 
      'Jogging',
      'Badminton', 
      'Football'];
    final List<String> entries2 = <String>[
      ' ', 
      ' ',
      ' ', 
      ' ',
      ' ', 
      ' ', 
      ' ',
      ' '];
    final List<int> colorCodes = <int>[400, 200, 100]; 
    final List<Image> menu = <Image>[
      Image.network('https://www.pngrepo.com/png/86340/512/bicycle-rider.png'),
      Image.network('https://image.flaticon.com/icons/png/512/92/92779.png'),
      Image.network('https://cdn.pixabay.com/photo/2014/03/24/17/16/stick-man-295293_1280.png'),
      Image.network('https://www.shareicon.net/data/512x512/2016/02/19/721522_sport_512x512.png'),
      Image.network('https://www.clipartmax.com/png/middle/234-2347101_yoga-for-cyclists-stick-man-exercising.png'),
      Image.network('https://cdn.pixabay.com/photo/2014/03/24/17/16/stick-man-295293_1280.png'),
      Image.network('https://www.shareicon.net/data/512x512/2016/04/06/745471_player_512x512.png'),
      Image.network('https://library.kissclipart.com/20180829/eyq/kissclipart-stickman-playing-soccer-png-clipart-olympic-games-88eefc43491dbd38.jpg')];
    return Scaffold(
      appBar: AppBar(
        title: Text('Exercise Table',
        style: TextStyle(
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.bold,
          fontSize: 25.0)
        ), 
        centerTitle: true,   
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          }
          ,icon: Icon(Icons.menu),
        ),
        actions: [
          IconButton(
            onPressed: () {}, 
            icon: Icon(
              Icons.notification_add
            )
          ),
          IconButton(
            onPressed: () {}, 
            icon: Icon(
              Icons.person
            )
          ),
          IconButton(
            onPressed: () {}, 
            icon: Icon(
              Icons.settings
            )
          ),
        ],
      ),          
      body:  ListView.separated(
        padding: EdgeInsets.all(8.0), 
        itemCount: entries.length, 
        itemBuilder: (context, index){
          return MenuTile(
            item: MenuItem(
              name: '${entries[index]}',
              cal: '${entries2[index]}',
              colorShade: colorCodes[index % 3],
              menu: menu[index],
            ),
          );
        },
        separatorBuilder: (context, index) => Divider(),
      ),
    );
  }
}

class MenuItem {
  final String name;
  final String cal;
  final int colorShade;
  final Image menu;

  const MenuItem(
    {Key? key, required this.name, 
    required this.cal, required this.colorShade, required this.menu,}); 
}

class MenuTile extends StatelessWidget {
  final MenuItem item;

  const MenuTile({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, 
          MaterialPageRoute(
            builder: (context) => ExerciseDetail(item: item),
          ),
        );
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(    
            padding: EdgeInsets.all(5.0),
            height: 80,
            width: 100,
            child: item.menu
          ),
          Container(
            padding: EdgeInsets.all(5.0),
            height: 80,
            width: 240,
            decoration: BoxDecoration(
              color: Colors.lightGreen[item.colorShade],
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Center(
              child: Text('${item.name}',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 16.0)
              ),    
            ),
          ),
        ],
      ),   
    );
  }
}

