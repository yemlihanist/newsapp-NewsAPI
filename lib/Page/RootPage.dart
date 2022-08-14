import 'package:flutter/material.dart';
import 'package:newsapp/Page/Favoritepage.dart';
import 'package:newsapp/Page/HomePage.dart';

class Rootpage extends StatefulWidget {
  const Rootpage({Key? key}) : super(key: key);

  @override
  State<Rootpage> createState() => _RootpageState();
}

class _RootpageState extends State<Rootpage> {
  List<Widget> pages = [HomePage(), FavoritePage()];
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorite',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: (tap) {
          _selectedIndex = tap;
          setState(() {});
        },
      ),
    );
  }
}
