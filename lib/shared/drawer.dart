import 'package:flutter/material.dart';

import '../models/menu-enum.dart';

class DrawerMenu extends StatelessWidget {
  final MenuOption menuOption;
  final VoidCallback drawerCloser;

  const DrawerMenu(
      {Key? key, required this.menuOption, required this.drawerCloser})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: MediaQuery.of(context).size.width*0.8,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          _drawerHeader(),
          _drawerItem(
              icon: Icons.home,
              menuOption: MenuOption.Home,
              text: 'Home',
              onTap: () => print('Tap My Files')),
          _drawerItem(
              icon: Icons.play_circle_fill,
              menuOption: MenuOption.NowPlaying,
              text: 'Now Playing',
              onTap: () => print('Tap Shared menu')),
          _drawerItem(
              icon: Icons.show_chart,
              menuOption: MenuOption.TopRated,
              text: 'Top Rated',
              onTap: () => print('Tap Recent menu')),
          _drawerItem(
              icon: Icons.people_alt_rounded,
              menuOption: MenuOption.Popular,
              text: 'popular',
              onTap: () => print('Tap Recent menu')),
          _drawerItem(
              icon: Icons.upcoming,
              menuOption: MenuOption.Upcoming,
              text: 'Upcoming',
              onTap: () => print('Tap Trash menu')),
          const Divider(height: 25, thickness: 1),
          _drawerItem(
              icon: Icons.help,
              menuOption: MenuOption.About,
              text: 'About',
              onTap: () => print('Tap Family menu')),
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
    GestureTapCallback? onTap,
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
      onTap: onTap,
    );
  }
}
