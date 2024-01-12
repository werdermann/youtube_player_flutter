import 'dart:async';

import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

const _secondsUntilLoadVideoTimeoutError = 3;

enum _VideoStatus {
  loading,
  success,
  loadingFailed,
  invalidUrl;

  bool get isLoadingOrHasError => this == loading || this == loadingFailed;

  bool get isLoading => this == loading;

  bool get isSuccess => this == success;
}

/// {@template demo_video}
/// Display a YoutubePlayer with a simple reload ui.
/// {@endtemplate}
class DemoVideo extends StatefulWidget {
  /// {@macro demo_video}
  const DemoVideo({
    required this.youtubeUrl,
    required this.localeLanguageCode,
    super.key,
  });

  /// Url of the youtube video.
  final String youtubeUrl;

  /// Locale must be inserted as a parameter because the controller can't access
  /// the widget tree during the initState method.
  final String localeLanguageCode;

  @override
  State<DemoVideo> createState() => _DemoVideoState();
}

class _DemoVideoState extends State<DemoVideo> {
  late final YoutubePlayerController _controller;

  _VideoStatus _status = _VideoStatus.loading;
  Timer? _timeoutTimer;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(params: _youtubeParams);

    _loadVideo();
  }

  @override
  Future<void> deactivate() async {
    await _controller.close();
    super.deactivate();
  }

  @override
  void dispose() {
    _timeoutTimer?.cancel();
    super.dispose();
  }

  YoutubePlayerParams get _youtubeParams => YoutubePlayerParams(
        interfaceLanguage: widget.localeLanguageCode,
        captionLanguage: widget.localeLanguageCode,
        strictRelatedVideos: true,
        showFullscreenButton: true,
      );

  @override
  Widget build(BuildContext context) {
    if (_status == _VideoStatus.invalidUrl) {
      return const Text('Invalid Url');
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Container(
            width: constraints.maxWidth,
            constraints: const BoxConstraints(
              maxHeight: 200,
              minWidth: 400,
              maxWidth: 400,
            ),
            child: Stack(
              fit: StackFit.expand,
              children: [
                AnimatedOpacity(
                  duration: const Duration(milliseconds: 150),
                  opacity: _status.isSuccess ? 1 : 0,
                  child: YoutubePlayer(
                    controller: _controller,
                  ),
                ),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 150),
                  child: switch (_status) {
                    _VideoStatus.loading => Container(
                        key: const ValueKey('loadingVideo'),
                        height: 400,
                        color: Colors.red,
                        child: const Center(
                          child: SizedBox(
                            height: 32,
                            width: 32,
                            child: CircularProgressIndicator(),
                          ),
                        ),
                      ),
                    _VideoStatus.loadingFailed => Container(
                        height: 400,
                        color: Colors.red,
                        width: MediaQuery.sizeOf(context).width,
                        key: const ValueKey('loadingVideoFailed'),
                        child: const Text('Error'),
                      ),
                    _ => const SizedBox(),
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Future<void> _loadVideo() async {
    final youtubeUrl =
        YoutubePlayerController.convertUrlToId(widget.youtubeUrl);

    if (youtubeUrl == null) {
      return setState(() => _status = _VideoStatus.invalidUrl);
    }

    _timeoutTimer = Timer(
      const Duration(seconds: _secondsUntilLoadVideoTimeoutError),
      () {
        if (_status == _VideoStatus.loading) {
          setState(() => _status = _VideoStatus.loadingFailed);
        }
        _timeoutTimer = null;
      },
    );

    await _controller.load(params: _youtubeParams);
    await _controller.cueVideoById(videoId: youtubeUrl);
    _timeoutTimer?.cancel();
    setState(() => _status = _VideoStatus.success);
  }
}
