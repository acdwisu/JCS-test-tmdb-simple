import 'package:flutter/material.dart';
import 'package:jcs_test/models/menu-enum.dart';
import 'package:jcs_test/pages/home/home.dart';
import 'package:jcs_test/pages/popular/main.dart';
import 'package:jcs_test/pages/top-rated/main.dart';
import 'package:jcs_test/pages/upcoming/main.dart';

import '../models/search-result.dart';
import '../shared/drawer.dart';
import 'now-playing/main.dart';
import 'search/search-delegate.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  MenuOption _currentMenu = MenuOption.Home;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return await showDialog<bool>(
            context: context,
            builder: (context) => WillPopScope(
              onWillPop: () async => false,
              child: AlertDialog(
                title: const Text('Konfirmasi'),
                content: const Text('Anda akan keluar, yakin?'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context, false);
                    },
                    style: TextButton.styleFrom(
                        backgroundColor: Colors.red,
                        primary: Colors.white
                    ),
                    child: const Text('Batal'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context, true);
                    },
                    style: TextButton.styleFrom(
                        backgroundColor: Colors.green,
                        primary: Colors.white
                    ),
                    child: const Text('Ya'),
                  ),
                ],
              ),
            ),
            barrierDismissible: false
        ) ?? false;
      },
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text(_titleText),
          leading: IconButton(
            onPressed: () {
              _scaffoldKey.currentState?.openDrawer();
            },
            icon: const Icon(Icons.menu),
          ),
          actions: [
            IconButton(
              icon: const Icon(
                Icons.search,
              ),
              onPressed: () async {
                final temp = await showSearch<SearchResultModel?>(
                    context: context, delegate: MovieSearcher());
              },
            )
          ],
        ),
        drawer: DrawerMenu(
          menuOption: _currentMenu,
          drawerCloser: () {
            _scaffoldKey.currentState?.closeDrawer();
          },
          onMenuSelected: (value) => setState(() {
            _currentMenu = value;
            _scaffoldKey.currentState?.closeDrawer();
          }),
        ),
        body: _content,
      ),
    );
  }

  String get _titleText {
    switch(_currentMenu) {
      case MenuOption.About:
        return 'About';
      case MenuOption.Home:
        return 'Home';
      case MenuOption.Popular:
        return 'Popular';
      case MenuOption.NowPlaying:
        return 'Now Playing';
      case MenuOption.Upcoming:
        return 'Upcoming';
      case MenuOption.TopRated:
        return 'Top Rated';
    }
  }

  Widget get _content {
    switch(_currentMenu) {
      case MenuOption.About:
        return Container();
      case MenuOption.Home:
        return const HomePage();
      case MenuOption.Popular:
        return const PopularPage();
      case MenuOption.NowPlaying:
        return const NowPlayingPage();
      case MenuOption.Upcoming:
        return const UpcomingPage();
      case MenuOption.TopRated:
        return const TopRatedPage();
    }
  }
}
