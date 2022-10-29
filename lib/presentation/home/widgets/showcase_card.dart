import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:netflix_clone/providers/providers.dart';

import '../../../network/end_points.dart';
import '../../widgets/icon_title_column.dart';

class ShowcaseCard extends ConsumerWidget {
  final Size size;
  const ShowcaseCard({super.key, required this.size});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final downloads = ref.watch(downloadsProvider);
    return Stack(
      children: [
        downloads.when(
          data: (data) => Container(
            height: size.height * 0.8,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                  '$kImageAppendUrl${data.results?[3].posterPath}',
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (err, stack) => Text('Error: $err'),
        ),
        Positioned(
          bottom: 10,
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const IconTitleColumn(
                icon: Icons.add,
                title: 'My List',
              ),
              TextButton.icon(
                onPressed: () {},
                icon: const Icon(
                  Icons.play_arrow,
                  color: Colors.black,
                ),
                label: const Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: Text(
                    'Play',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.white),
                ),
              ),
              const IconTitleColumn(
                icon: Icons.info_outline,
                title: 'Info',
              ),
            ],
          ),
        )
      ],
    );
  }
}
