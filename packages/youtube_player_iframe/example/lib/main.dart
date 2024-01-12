// Copyright 2020 Sarbagya Dhaubanjar. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:youtube_player_iframe_example/widgets/demo_video.dart';

void main() {
  runApp(const _YoutubeApp());
}

class _YoutubeApp extends StatelessWidget {
  const _YoutubeApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Youtube Player IFrame Demo',
      theme: ThemeData.from(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const _DemoPage(),
    );
  }
}

class _DemoPage extends StatelessWidget {
  const _DemoPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Youtube Player IFrame Demo'),
      ),
      body: const SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              DemoVideo(
                youtubeUrl: 'https://youtu.be/dQw4w9WgXcQ?si=fPuSSa-lJ4TdVZoC',
                localeLanguageCode: 'de',
              ),
              const SizedBox(height: 32),
              DemoVideo(
                youtubeUrl: 'https://youtu.be/dQw4w9WgXcQ?si=fPuSSa-lJ4TdVZoC',
                localeLanguageCode: 'de',
              ),
              const SizedBox(height: 32),
              DemoVideo(
                youtubeUrl: 'https://youtu.be/dQw4w9WgXcQ?si=fPuSSa-lJ4TdVZoC',
                localeLanguageCode: 'de',
              ),
              const SizedBox(height: 32),
              DemoVideo(
                youtubeUrl: 'https://youtu.be/dQw4w9WgXcQ?si=fPuSSa-lJ4TdVZoC',
                localeLanguageCode: 'de',
              ),
              const SizedBox(height: 32),
              DemoVideo(
                youtubeUrl: 'https://youtu.be/dQw4w9WgXcQ?si=fPuSSa-lJ4TdVZoC',
                localeLanguageCode: 'de',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
