import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:netflix_clone/models/Downloads/downloads_response_model.dart';
import 'package:netflix_clone/models/Search/search_trending_response.dart';
import 'package:netflix_clone/models/hot&new/coming_soon_response_model.dart';
import 'package:netflix_clone/network/base_client.dart';
import 'package:netflix_clone/network/end_points.dart';

import '../models/Search/search_response.dart';

final downloadsProvider = FutureProvider<DownloadsResponseModel>((ref) async {
  final content = await BaseClient.get(ApiEndPoints.downloads);
  return downloadsResponseModelFromJson(content);
});

final trendingProvider =
    FutureProvider<SearchTrendingResponseModel>((ref) async {
  final content = await BaseClient.get(ApiEndPoints.trending);
  return searchTrendingResponseModelFromJson(content);
});

final comingSoonProvider = FutureProvider<ComingSoonResponseModel>((ref) async {
  final content = await BaseClient.get(ApiEndPoints.comingSoon);
  return comingSoonResponseModelFromJson(content);
});

FutureProvider<SearchResponseModel> getSearchProvider(String query) {
  var searchProvider = FutureProvider<SearchResponseModel>((ref) async {
    final content = await BaseClient.get(ApiEndPoints.getSearch(query));
    return searchResponseModelFromJson(content);
  });
  return searchProvider;
}

final searchFieldProvider = StateNotifierProvider<SearchField, bool>((ref) {
  return SearchField();
});

class SearchField extends StateNotifier<bool> {
  SearchField() : super(true);
  void isEmpty() => state = true;
  void isNotEmpty() => state = false;
}
