import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:netflix_clone/providers/providers.dart';
import 'everyones_watching_card.dart';

class EveryonesWatchingWidget extends ConsumerWidget {
  const EveryonesWatchingWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final config = ref.watch(downloadsProvider);
    return config.when(
      data: (data) => ListView.builder(
        itemCount: data.results?.length ?? 0,
        itemBuilder: (context, index) => EveryonesWatchingCard(
          result: data.results?[index],
        ),
      ),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) => Text('Error: $err'),
    );
  }
}
