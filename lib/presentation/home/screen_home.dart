import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:netflix_clone/presentation/home/widgets/custom_app_bar.dart';
import 'package:netflix_clone/presentation/home/widgets/list_with_title_and_number.dart';
import 'package:netflix_clone/presentation/home/widgets/showcase_card.dart';
import 'package:netflix_clone/providers/providers.dart';

import 'widgets/list_with_tile.dart';

ValueNotifier<bool> isAppBarVisible = ValueNotifier(true);
const List titles = [
  'Released in the past year',
  'Trending now',
  'Tense dramas',
  'Top trending',
  'South indian cinemas',
];

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final trending = ref.watch(trendingProvider);
    final comingSoon = ref.watch(comingSoonProvider);
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: NotificationListener<UserScrollNotification>(
        onNotification: (notification) {
          isAppBarVisible.value =
              notification.direction == ScrollDirection.reverse ? false : true;
          return true;
        },
        child: ValueListenableBuilder(
          valueListenable: isAppBarVisible,
          builder: (BuildContext context, value, Widget? child) {
            return Stack(
              children: [
                ListView(
                  children: [
                    ShowcaseCard(
                      size: size,
                    ),
                    ...List.generate(
                      titles.length,
                      (index) => index == 3
                          ? ListWithTitleAndNumber(
                              size: size,
                              title: titles[index],
                            )
                          : (index == 0 || index == 2
                              ? trending.when(
                                  data: (data) {
                                    return ListWithTitle(
                                      size: size,
                                      title: titles[index],
                                      list: data.results,
                                    );
                                  },
                                  loading: () => const Center(
                                      child: CircularProgressIndicator()),
                                  error: (err, stack) => Text('Error: $err'),
                                )
                              : comingSoon.when(
                                  data: (data) {
                                    return ListWithTitle(
                                      size: size,
                                      title: titles[index],
                                      list: data.results,
                                    );
                                  },
                                  loading: () => const Center(
                                      child: CircularProgressIndicator()),
                                  error: (err, stack) => Text('Error: $err'),
                                )),
                    ),
                  ],
                ),
                AnimatedOpacity(
                  opacity: value ? 1.0 : 0.0,
                  duration: const Duration(seconds: 1),
                  child: const CustomAppBar(),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
