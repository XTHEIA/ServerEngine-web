import 'package:flutter/material.dart';
import 'package:server_engine_web/main.dart';
import 'package:url_launcher/url_launcher.dart';

class CommunityPage extends StatelessWidget {
  static final _nodeBlocks = CommunityNode.values
      .map((node) => Padding(
            padding: const EdgeInsets.only(top: 10),
            child: InkWell(
              onTap: () => launchUrl(Uri.parse(node.url)),
              child: Container(
                width: 999,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: node.color.withOpacity(0.19),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(node.iconData, size: 31, color: node.color),
                        const SizedBox(width: 8),
                        Text(
                          node.label,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Text(
                      node.url,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.45),
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(height: 15),
                    Text(node.description),
                  ],
                ),
              ),
            ),
          ))
      .toList();

  const CommunityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SizedBox(
        width: 800,
        child: Column(
          children: _nodeBlocks,
        ),
      ),
    );
  }
}

enum CommunityNode {
  discord(
    'Server Engine Discord Server',
    Icons.discord,
    discordUrl,
    Color(0xFF5865F2),
    'Server Engine 사용자를 위한 공식 디스코드 서버\n버그 제보, 기능 요청 등',
  ),
  github(
    'Server Engine web GitHub Repository',
    Icons.code,
    githubUrl,
    Colors.grey,
    '현재 웹 페이지의 소스 코드',
  ),
  distribution(
    'Server Engine Distribution Repository',
    Icons.webhook,
    'https://github.com/XTHEIA/ServerEngine-builds',
    Colors.tealAccent,
    'Server Engine 빌드 저장소',
  ),
  youtube(
    'SBXT YouTube Channel',
    Icons.personal_video_outlined,
    'https://youtube.com/@sb.xtheia',
    Color(0xFFFF0000),
    '개발자 유튜브 채널',
  );

  final String label, description, url;
  final IconData iconData;
  final Color color;

  const CommunityNode(
    this.label,
    this.iconData,
    this.url,
    this.color,
    this.description,
  );
}
