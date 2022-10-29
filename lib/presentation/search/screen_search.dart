import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:netflix_clone/models/Search/search_response.dart';
import 'package:netflix_clone/models/Search/search_trending_response.dart';
import 'package:netflix_clone/network/end_points.dart';

import 'package:netflix_clone/presentation/widgets/image_card.dart';
import 'package:netflix_clone/providers/providers.dart';

import '../../styles/constants/widgets.dart';
import '../widgets/card_title.dart';
import 'widgets/search_custom_listtile.dart';

class SearchScreen extends ConsumerWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<SearchTrendingResponseModel> config =
        ref.watch(trendingProvider);
    final searchIsEmpty = ref.watch(searchFieldProvider);
    AsyncValue<SearchResponseModel> search = ref.watch(getSearchProvider(''));
    ;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CupertinoSearchTextField(
                backgroundColor: Colors.grey.withOpacity(0.4),
                itemColor: Colors.grey,
                style: const TextStyle(color: Colors.white),
                onChanged: (value) {
                  value.isEmpty
                      ? ref.read(searchFieldProvider.notifier).isEmpty()
                      : ref.read(searchFieldProvider.notifier).isNotEmpty();

                  search = (value.isEmpty
                      ? null
                      : ref.watch(getSearchProvider(value)))!;
                },
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 15),
                child: CardTitle(
                  title: 'Top Searches',
                ),
              ),
              searchIsEmpty
                  ? config.when(
                      loading: () =>
                          const Center(child: CircularProgressIndicator()),
                      error: (err, stack) => Text('Error: $err'),
                      data: (data) {
                        return Expanded(
                          child: GridView.count(
                            crossAxisCount: 3,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10,
                            childAspectRatio: 1 / 1.75,
                            children: List.generate(
                                data.results?.length ?? 0,
                                (index) => ImageCard(
                                      borderRadius: kBorderRadius5,
                                      image:
                                          '$kImageAppendUrl${data.results?[index].posterPath}',
                                    )),
                          ),
                        );
                      },
                    )
                  : search.when(
                      loading: () =>
                          const Center(child: CircularProgressIndicator()),
                      error: (err, stack) => Text('Error: $err'),
                      data: (searchResults) {
                        return Expanded(
                          child: ListView.separated(
                              itemBuilder: (_, index) => SearchCustomListTile(
                                    result: searchResults.results?[index],
                                  ),
                              separatorBuilder: (_, index) => kSizedBoxH20,
                              itemCount: searchResults.results?.length ?? 0),
                        );
                      },
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
