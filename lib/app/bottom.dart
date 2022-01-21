import 'package:divinafm/tabs/events.dart';
import 'package:divinafm/tabs/infinity.dart';
import 'package:divinafm/tabs/player.dart';
import 'package:divinafm/tabs/sliver.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Bottom extends StatefulWidget {
  const Bottom({Key? key}) : super(key: key);

  @override
  _BottomState createState() => _BottomState();
}

class _BottomState extends State<Bottom> {
  int _selectedIndex = 2;

  final List<Widget> _widgetOptions = <Widget>[
    Infinity(),
    Player(),
    Infinity(),
    Events(),
    Sliver(),
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
                    FontAwesomeIcons.headphonesAlt,
                    size: 25.0,
                  ),
                  label: "person_outline",
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    FontAwesomeIcons.playCircle,
                    size: 25.0,
                  ),
                  label: "playcircle",
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    FontAwesomeIcons.newspaper,
                    size: 25.0,
                  ),
                  label: "newspaper",
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    FontAwesomeIcons.calendarAlt,
                    size: 25.0,
                  ),
                  label: "events",
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    FontAwesomeIcons.at,
                    size: 25.0,
                  ),
                  label: "contacts",
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
