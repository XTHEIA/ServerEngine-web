import 'dart:html' show IFrameElement;
import 'dart:ui_web' as ui;

import 'package:flutter/material.dart';
import 'package:server_engine_web/main.dart';
import 'package:url_launcher/url_launcher.dart';

class DiscordPage extends StatelessWidget {

  DiscordPage({super.key}) {
    final iframe = IFrameElement()
      ..src = 'https://discord.com/widget?id=1170504859045335162&theme=dark'
      ..width = '350px'
      ..height = '500px'
      ..id = 'iframe'
      ..style.border = 'none'
      ..allow = 'popups popups-to-escape-sandbox same-origin scripts';

    ui.platformViewRegistry
        .registerViewFactory('iframeElement', (int viewId) => iframe);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          child: const Text(
            discordUrl,
            style: TextStyle(
              color: Colors.blue,
            ),
          ),
          onTap: () => launchUrl(Uri.parse(discordUrl)),
        ),
        const SizedBox(height:10),
        const SizedBox(
          height: 550,
          width: 400,
          child: HtmlElementView(
            viewType: 'iframeElement',
          ),
        ),
      ],
    );
  }
}
