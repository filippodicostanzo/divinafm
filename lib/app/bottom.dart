import 'package:divinafm/tabs/player.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../tabs/home.dart';

class Bottom extends StatefulWidget {
  const Bottom({Key? key}) : super(key: key);

  @override
  _BottomState createState() => _BottomState();
}

class _BottomState extends State<Bottom> {
  int _selectedIndex = 2;

  final List<Widget> _widgetOptions = <Widget>[
    Home(),
    Player(),
    Home(),
    Home(),
    Home(),
  ];

  @override
  void initState() {
    super.initState();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff6f6f6),
      //body: Center(child: _widgetOptions[_selectedIndex]),
      body: IndexedStack(children: _widgetOptions, index: _selectedIndex),
      bottomNavigationBar: SizedBox(
        height: 70,
        child: Container(
          decoration: const BoxDecoration(),
          child: ClipRRect(
            child: BottomNavigationBar(
              elevation: 0.0,
              backgroundColor: Colors.white,
              type: BottomNavigationBarType.fixed,
              showSelectedLabels: false,
              showUnselectedLabels: false,
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(
                    FontAwesomeIcons.users,
                    size: 25.0,
                  ),
                  label: "person_outline",
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.pin_drop,
                    size: 30.0,
                  ),
                  label: "home_filled",
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home_filled,
                    size: 30.0,
                  ),
                  label: "home_filled",
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.workspaces_outline,
                    size: 30.0,
                  ),
                  label: "grid_view",
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    FontAwesomeIcons.heart,
                    size: 25.0,
                  ),
                  label: "grid_view",
                ),
              ],
              currentIndex: _selectedIndex,
              unselectedItemColor: const Color(0xffd0cedb),
              selectedItemColor: const Color(0xff7a6fb3),
              onTap: _onItemTapped,
            ),
          ),
        ),
      ),
    );
  }
}
