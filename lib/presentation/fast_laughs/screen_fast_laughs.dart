import 'package:flutter/material.dart';

import 'package:video_player/video_player.dart';
import 'package:wakelock/wakelock.dart';

import '../widgets/volume_button_widget.dart';
import 'widgets/fast_laugh_side_menu.dart';
import 'widgets/video_player.dart';

List<String> videoList = [
  "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4",
  "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4",
  "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4",
  "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerEscapes.mp4",
  "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerFun.mp4",
  "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerJoyrides.mp4",
  "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerMeltdowns.mp4",
  "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/Sintel.mp4",
  "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/SubaruOutbackOnStreetAndDirt.mp4",
  "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/TearsOfSteel.mp4",
  "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/VolkswagenGTIReview.mp4",
  "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/WeAreGoingOnBullrun.mp4",
  "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/WhatCarCanYouGetForAGrand.mp4"
];

class FastLaughsScreen extends StatefulWidget {
  const FastLaughsScreen({super.key});

  @override
  State<FastLaughsScreen> createState() => _FastLaughsScreenState();
}

class _FastLaughsScreenState extends State<FastLaughsScreen> {
  @override
  void initState() {
    Wakelock.enable();
    super.initState();
  }

  @override
  void dispose() {
    Wakelock.disable();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: PageView.builder(
          itemBuilder: (context, index) => Stack(
            children: [
              CustomVideoPlayer(url: videoList[index % videoList.length]),
              Positioned(
                left: 15,
                bottom: 15,
                child: GestureDetector(
                  onTap: () {},
                  child: const VolumeButtonWidget(),
                ),
              ),
              const Positioned(
                right: 0,
                bottom: 0,
                child: FastLaughSideMenu(),
              ),
            ],
          ),
          scrollDirection: Axis.vertical,
        ),
      ),
    );
  }
}
