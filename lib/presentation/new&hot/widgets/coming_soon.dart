import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:netflix_clone/providers/providers.dart';

import 'coming_soon_card.dart';

class ComingSoonWidget extends ConsumerWidget {
  const ComingSoonWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final coming = ref.watch(comingSoonProvider);
    return coming.when(
      data: (data) => ListView.builder(
        itemCount: data.results?.length ?? 0,
        itemBuilder: (context, index) => ComingSoonCard(
          result: data.results?[index],
        ),
      ),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) => Text('Error: $err'),
    );
  }
}
