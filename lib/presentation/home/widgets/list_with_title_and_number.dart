import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../network/end_points.dart';
import '../../../providers/providers.dart';
import '../../../styles/constants/widgets.dart';
import '../../widgets/card_title.dart';
import 'card_with_number.dart';

class ListWithTitleAndNumber extends ConsumerWidget {
  final String title;
  const ListWithTitleAndNumber({
    Key? key,
    required this.size,
    required this.title,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final downloads = ref.watch(downloadsProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        kSizedBoxH10,
        CardTitle(title: title),
        kSizedBoxH10,
        LimitedBox(
          maxHeight: size.width * 0.57,
          child: downloads.when(
            data: (data) => ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => ImageCardWithNumber(
                      width: size.width * 0.35,
                      image:
                          '$kImageAppendUrl${data.results?[index].posterPath}',
                      index: (index + 1).toString(),
                    ),
                separatorBuilder: ((context, index) => kSizedBoxW10),
                itemCount: data.results?.length ?? 0),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (err, stack) => Text('Error: $err'),
          ),
        )
      ],
    );
  }
}
