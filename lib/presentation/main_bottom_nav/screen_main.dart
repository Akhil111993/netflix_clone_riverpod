import 'package:flutter/material.dart';
import 'package:netflix_clone/presentation/downloads/screen_downloads.dart';
import 'package:netflix_clone/presentation/fast_laughs/screen_fast_laughs.dart';
import 'package:netflix_clone/presentation/home/screen_home.dart';
import 'package:netflix_clone/presentation/main_bottom_nav/widgets/bottom_nav.dart';
import 'package:netflix_clone/presentation/new&hot/screen_new_hot.dart';
import 'package:netflix_clone/presentation/search/screen_search.dart';

class ScreenMainPage extends StatelessWidget {
  ScreenMainPage({super.key});

  final screenList = [
    const HomeScreen(),
    const NewAndHotScreen(),
    const FastLaughsScreen(),
    const SearchScreen(),
    const DownloadsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ValueListenableBuilder(
          valueListenable: valueNotifier,
          builder: ((context, int value, child) => screenList[value]),
        ),
      ),
      bottomNavigationBar: const BottomNavigationWidget(),
    );
  }
}
