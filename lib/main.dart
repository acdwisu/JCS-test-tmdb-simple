import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jcs_test/injection.dart';
import 'package:jcs_test/pages/blocs/now-playing/now_playing_bloc.dart';
import 'package:jcs_test/pages/blocs/popular/popular_bloc.dart';
import 'package:jcs_test/pages/blocs/upcoming/upcoming_bloc.dart';
import 'package:jcs_test/pages/home/home.dart';
import 'package:provider/provider.dart';

import 'pages/blocs/top-rated/top_rated_bloc.dart';

void main() {
  initInjection();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'JCS Test',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MultiProvider(
        providers: [
          BlocProvider(
            create: (context) => locator<NowPlayingBloc>(),
          ),
          BlocProvider(
            create: (context) => locator<TopRatedBloc>(),
          ),
          BlocProvider(
            create: (context) => locator<PopularBloc>(),
          ),
          BlocProvider(
            create: (context) => locator<UpcomingBloc>(),
          ),
        ],
        child: const HomePage(),
      ),
      // home: const HomePage(),
    );
  }
}