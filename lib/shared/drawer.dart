import 'package:flutter/material.dart';
import 'package:jcs_test/pages/home/home.dart';
import 'package:jcs_test/pages/now-playing/main.dart';

import '../models/menu-enum.dart';

class DrawerMenu extends StatelessWidget {
  final MenuOption menuOption;
  final VoidCallback drawerCloser;
  final void Function(MenuOption) onMenuSelected;

  const DrawerMenu(
      {Key? key,
      required this.menuOption,
      required this.drawerCloser,
      required this.onMenuSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: MediaQuery.of(context).size.width * 0.8,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          _drawerHeader(),
          _drawerItem(
              icon: Icons.home,
              menuOption: MenuOption.Home,
              text: 'Home',
              ),
          _drawerItem(
              icon: Icons.play_circle_fill,
              menuOption: MenuOption.NowPlaying,
              text: 'Now Playing',
              ),
          _drawerItem(
              icon: Icons.show_chart,
              menuOption: MenuOption.TopRated,
              text: 'Top Rated',
              ),
          _drawerItem(
              icon: Icons.people_alt_rounded,
              menuOption: MenuOption.Popular,
              text: 'Popular',
              ),
          _drawerItem(
              icon: Icons.upcoming,
              menuOption: MenuOption.Upcoming,
              text: 'Upcoming',
              ),
          const Divider(height: 25, thickness: 1),
          _drawerItem(
              icon: Icons.help,
              menuOption: MenuOption.About,
              text: 'About',
              ),
        ],
      ),
    );
  }

  Widget _drawerHeader() {
    return const UserAccountsDrawerHeader(
      currentAccountPicture: ClipOval(
        child: Image(
            image: AssetImage('assets/images/ava.jpg'), fit: BoxFit.cover),
      ),
      accountName: Text('Tejo'),
      accountEmail: Text('test@gmail.com'),
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/drawer-header-bg.jpg'),
              fit: BoxFit.cover)),
    );
  }

  Widget _drawerItem({
    required MenuOption menuOption,
    required IconData icon,
    required String text,
  }) {
    final selected = this.menuOption == menuOption;

    return ListTile(
      selected: selected,
      style: ListTileStyle.drawer,
      title: Row(
        children: <Widget>[
          Icon(icon),
          Padding(
            padding: const EdgeInsets.only(left: 25.0),
            child: Text(
              text,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      onTap: () => _menuSelectHandler(menuOption),
    );
  }

  void _menuSelectHandler(MenuOption menuOption) {
    if(this.menuOption != menuOption) {
      onMenuSelected(menuOption);
    }
  }
}
