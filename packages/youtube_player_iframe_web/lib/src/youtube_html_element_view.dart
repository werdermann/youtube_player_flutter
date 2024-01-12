import 'dart:async';
import 'dart:html';

import 'package:flutter/material.dart';
import 'package:webview_flutter_platform_interface/webview_flutter_platform_interface.dart';

/// {@template youtube_html_element_view}
/// A stateful view that listen to the messages of the youtube api.
///
/// It disposes the stream whenever the view is disposed.
/// {@endtemplate}
class YoutubeHtmlElementView extends StatefulWidget {
  /// {@macro youtube_html_element_view}
  const YoutubeHtmlElementView({
    required this.viewType,
    required this.channelParams,
    super.key,
  });

  final String viewType;

  final JavaScriptChannelParams channelParams;

  @override
  State<YoutubeHtmlElementView> createState() => _YoutubeHtmlElementViewState();
}

class _YoutubeHtmlElementViewState extends State<YoutubeHtmlElementView> {
  StreamSubscription<MessageEvent>? _messageSubscription;

  @override
  void dispose() {
    _messageSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return HtmlElementView(
      key: widget.key,
      viewType: widget.viewType,
      onPlatformViewCreated: (_) {
        _messageSubscription = window.onMessage.listen(
          (event) {
            if (widget.channelParams.name == 'YoutubePlayer') {
              widget.channelParams.onMessageReceived(
                JavaScriptMessage(message: event.data),
              );
            }
          },
        );
      },
    );
  }
}
