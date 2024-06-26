import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:seo/html/seo_controller.dart';
import 'package:seo/html/tree/widget_tree.dart';
import 'package:server_engine_web/firebase_options.dart';
import 'package:server_engine_web/pages/community.dart';
import 'package:server_engine_web/pages/feature.dart';
import 'package:server_engine_web/pages/guide.dart';
import 'package:server_engine_web/pages/info.dart';
import 'package:url_launcher/url_launcher.dart';

import 'pages/download.dart';
import 'widgets/seo_text.dart';

void main() async {
  runApp(const ServerEngineWeb());
  initFirebase();
}

void initFirebase() async {
  final webInfo = await DeviceInfoPlugin().webBrowserInfo;

  final app = await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await analytics.logAppOpen(parameters: {
    'user-agent': webInfo.userAgent ?? 'null',
    'browser': webInfo.browserName.name,
  });
}

const primaryColor = Color(0xFF49BAF7);
const backgroundColor = Color(0xFF0F1519);
const nanumBarunGothic = 'NanumBarunGothic';
const jetBrainsMono = 'JetBrains Mono';
const pretendard = 'Pretendard';
const githubUrl = 'https://github.com/XTHEIA/ServerEngine-web';
const discordUrl = 'https://discord.com/invite/9942fpABeZ';

final analytics = FirebaseAnalytics.instance;

class ServerEngineWeb extends StatelessWidget {
  const ServerEngineWeb({super.key});

  @override
  Widget build(BuildContext context) {
    return SeoController(
      enabled: true,
      tree: WidgetTree(context: context),
      child: MaterialApp(
        title: 'Server Engine - 간편하고 강력한 서버 실행, 관리 프로그램',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: primaryColor,
            background: backgroundColor,
            brightness: Brightness.dark,
          ),
          fontFamily: pretendard,
          dialogTheme: DialogTheme(
            backgroundColor: Color.lerp(Colors.black, backgroundColor, 0.6),
            shape: Border.all(color: Colors.transparent),
          ),
        ),
        home: const ServerEngineWebRoot(),
      ),
    );
  }
}

class ServerEngineWebRoot extends StatefulWidget {
  const ServerEngineWebRoot({super.key});

  @override
  State<ServerEngineWebRoot> createState() => _ServerEngineWebRootState();
}

class _ServerEngineWebRootState extends State<ServerEngineWebRoot> {
  _Page _page = kReleaseMode ? _Page.features : _Page.download;

  void _setPage(_Page page) {
    if (page == _Page.guide) {
      launchUrl(Uri.parse('https://docs.server-engine.kr/'));
      return;
    }

    final isDif = page != _page;

    setState(() {
      _page = page;
    });
    if (isDif) {
      analytics.logScreenView(
        screenName: page.id,
      );
    }
  }

  late final pageButtons = _Page.values.map((p) {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: InkWell(
        onTap: () => _setPage(p),
        child: Container(
          padding: const EdgeInsets.all(5),
          alignment: Alignment.centerLeft,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                p.iconData,
                color: Colors.white,
                size: 19,
              ),
              const SizedBox(width: 4),
              SeoText(
                p.label,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }).toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Column(
        children: [
          // Navigation Bar
          Material(
            color: const Color(0xFF0F1519),
            child: Container(
              height: 90,
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 20, right: 8, top: 15, bottom: 8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        // logo
                        Image.asset(
                          'assets/image/logo.png',
                          height: 50,
                          isAntiAlias: true,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              // logo, pages
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: pageButtons,
                              ),

                              // links
                              Wrap(
                                spacing: 5,
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.discord),
                                    onPressed: () =>
                                        launchUrl(Uri.parse(discordUrl)),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          ),

          // Page
          Expanded(
            child: SingleChildScrollView(
              controller: ScrollController(),
              child: Padding(
                padding: const EdgeInsets.only(top: 40),
                child: Builder(
                  builder: (final context) {
                    final page = _page;
                    switch (page) {
                      case _Page.features:
                        return const MainPage();
                      case _Page.download:
                        return const DownloadsPage();
                      case _Page.community:
                        return const CommunityPage();
                      case _Page.guide:
                        return const GuidePage();
                      case _Page.about:
                        return const InformationPage();
                      default:
                        return const Text('NotImpl');
                    }
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

enum _Page {
  features('features', '기능', Icons.apps),
  download('download', '다운로드', Icons.download),
  community('community', '커뮤니티', Icons.people),
  guide('guide', '가이드', Icons.description),
  about('about', '정보', Icons.info),
  ;

  final IconData iconData;
  final String id, label;

  const _Page(this.id, this.label, this.iconData);
}
