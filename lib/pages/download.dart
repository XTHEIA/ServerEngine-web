import 'dart:convert';
import 'dart:developer';
import 'dart:html' as html;

import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:http/http.dart' as http;
import 'package:server_engine_web/utils.dart';
import 'package:server_engine_web/widgets/widgets.dart';
import 'package:url_launcher/url_launcher.dart';

import '../main.dart';

final class BuildManager {
  static final apiLatestRelease =
      Uri.parse('https://api.github.com/repos/XTHEIA/ServerEngine-builds/releases/latest');

  static Future<Build> fetchLatest() async {
    log('fetching latest release from github ...');
    final response = await http.get(apiLatestRelease);
    if (response.statusCode != 200) throw Exception('response is ${response.statusCode}');

    final body = response.body;
    log(body);

    return Build.fromJson(jsonDecode(body));
  }
}

final class Build {
  final String webUrl;
  final String tag, name, branch;
  final DateTime publishDate;
  final String body;
  final List<Asset> assets;

  Build({
    required this.webUrl,
    required this.tag,
    required this.name,
    required this.branch,
    required this.publishDate,
    required this.body,
    required this.assets,
  });

  Build.fromJson(dynamic json)
      : this(
          webUrl: json['html_url'],
          tag: json['tag_name'],
          name: json['name'],
          branch: json['target_commitish'],
          publishDate: DateTime.parse(json['published_at']).add(const Duration(hours: 9)),
          body: json['body'],
          assets: (json['assets'] as List).map((json) => Asset.fromJson(json)).toList(),
        );
}

final class Asset {
  final String name;
  final String? label;
  final String downloadUrl;
  final int downloadCount, size;
  final DateTime createdDate, updatedDate;

  Asset({
    required this.name,
    required this.label,
    required this.downloadUrl,
    required this.downloadCount,
    required this.size,
    required this.createdDate,
    required this.updatedDate,
  });

  Asset.fromJson(dynamic json)
      : this(
          name: json['name'],
          label: json['label'],
          downloadUrl: json['browser_download_url'],
          createdDate: DateTime.parse(json['created_at']).add(const Duration(hours: 9)),
          updatedDate: DateTime.parse(json['updated_at']).add(const Duration(hours: 9)),
          size: json['size'],
          downloadCount: json['download_count'],
        );
}

class DownloadsPage extends StatelessWidget {
  const DownloadsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),

        // 추후 여러 개의 빌드를 ListView 형태로 렌더링해야 할 수 있기 떄문에
        // 일단 통째로 FutureBuilder
        child: SizedBox(
          width: 1000,
          child: FutureBuilder(
            future: BuildManager.fetchLatest(),
            builder: (final context, final snapshot) {
              final build = snapshot.data;
              if (build == null) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: snapshot.hasError
                        ? const [
                            Icon(Icons.error),
                            SizedBox(height: 10),
                            Text('빌드 정보를 가져오지 못했습니다.'),
                            Text('일시적인 오류일 수 있습니다.'),
                            Text('같은 문제가 계속 발생할 경우 디스코드 서버를 참고해주세요.')
                          ]
                        : const [
                            CircularProgressIndicator(),
                            SizedBox(height: 10),
                            Text('빌드 정보 가져오는 중 ...'),
                          ],
                  ),
                );
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  Container(
                    color: Colors.amber.withOpacity(0.1),
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    child: const Row(
                      children: [
                        Icon(Icons.warning, color: Colors.amber),
                        SizedBox(width: 9),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('프로그램이 아직 개발 단계이므로 예상치 못한 버그가 발생할 수 있습니다.'),
                            Text('서버 손상이나 손해 발생 시 책임지지 않습니다. 간단한 서버 관리에만 사용해 주세요.'),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // latest
                  const Row(
                    children: [
                      Icon(Icons.new_releases),
                      Text(
                        ' 최신 릴리즈',
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                  const Divider(),
                  BuildTile(build),
                  const SizedBox(height: 20),

                  // others
                  const Text(
                    '기타 릴리즈',
                    style: TextStyle(fontSize: 18),
                  ),
                  const Divider(),
                  Container(
                    color: Colors.amber.withOpacity(0.1),
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    child: const Row(
                      children: [
                        Icon(Icons.warning, color: Colors.amber),
                        SizedBox(width: 9),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('성능, 보안 및 안전성을 위하여 최신 릴리즈를 사용해 주세요.'),
                            Text('구버전의 프로그램은 사용이 제한됩니다.'),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class BuildTile extends StatelessWidget {
  final Build _build;

  const BuildTile(this._build, {super.key});

  @override
  Widget build(BuildContext context) {
    final assets = _build.assets;
    return Container(
      decoration: BoxDecoration(
        color: Colors.blueGrey.withOpacity(0.16),
      ),
      padding: const EdgeInsets.all(15),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // name
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _build.name,
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.tealAccent),
              ),
              IconButton(
                  tooltip: '해당 빌드의 정보를 GitHub에서 엽니다.\n${_build.webUrl}',
                  onPressed: () => launchUrl(Uri.parse(_build.webUrl)),
                  icon: const Icon(Icons.open_in_new))
            ],
          ),
          const SizedBox(height: 10),

          // meta
          textDiv(Icons.info_rounded, '정보'),
          prop('버전', _build.tag),
          prop('채널', _build.branch),
          prop('배포',
              '${_build.publishDate.formatGeneral()} (${_build.publishDate.getElapsedTimeFormatted()})'),
          const SizedBox(height: 10),

          // body
          textDiv(Icons.document_scanner, '본문'),
          MarkdownBody(
            data: _build.body,
            selectable: true,
            styleSheet: MarkdownStyleSheet(
              blockquoteDecoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
              ),
              code: TextStyle(
                fontFamily: jetBrainsMono,
                backgroundColor: Colors.white.withOpacity(0.1),
              ),
            ),
          ),
          const SizedBox(height: 10),

          // assets
          textDiv(Icons.download, '파일'),
          Builder(builder: (context) {
            final assetsCount = assets.length;
            if (assetsCount == 0) {
              return const Padding(
                padding: EdgeInsets.only(top: 12, bottom: 2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Icon(
                      Icons.warning,
                      size: 20,
                      color: Colors.amber,
                    ),
                    Text(' 추가된 파일이 없습니다.'),
                  ],
                ),
              );
            }
            return ListView.separated(
              shrinkWrap: true,
              itemCount: assetsCount,
              separatorBuilder: (c, i) => const SizedBox(height: 10),
              itemBuilder: (final context, final idx) => AssetTile(assets[idx]),
            );
          }),
        ],
      ),
    );
  }

  static Widget textDiv(IconData iconData, String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(iconData, size: 18),
          const SizedBox(width: 3),
          Text('$label  '),
          const Expanded(child: Divider()),
        ],
      ),
    );
  }

  static Widget prop(String key, String value) {
    return Row(
      children: [
        Text(
          key,
          style: const TextStyle(color: Colors.white),
        ),
        const SizedBox(width: 6),
        Text(
          value,
          style: TextStyle(
            fontFamily: jetBrainsMono,
            color: Colors.white.withOpacity(0.7),
          ),
        ),
      ],
    );
  }
}

class AssetTile extends StatelessWidget {
  final Asset asset;

  const AssetTile(this.asset, {super.key});

  @override
  Widget build(BuildContext context) {
    late final label = asset.label;
    return Tooltip(
      message: asset.downloadUrl,
      child: InkWell(
        onTap: () {
          html.AnchorElement(href: asset.downloadUrl)
            ..target = 'file_download'
            ..click();
        },
        child: Container(
          color: Colors.blueGrey.withOpacity(0.2),
          padding: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 12,
          ),
          child: Row(
            children: [
              const Icon(Icons.download, size: 30),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${asset.name}${label == null ? '' : ' ($label)'}',
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      fontFamily: jetBrainsMono,
                      letterSpacing: 0,
                    ),
                  ),
                  const SizedBox(height: 4),
                  IconText(
                    Icons.calendar_month,
                    '${asset.updatedDate.formatGeneral()} (${asset.updatedDate.getElapsedTimeFormatted()})',
                    tooltip: '마지막 업데이트 일시',
                    color: Colors.white.withOpacity(0.55),
                  ),
                  Row(
                    children: [
                      IconText(
                        Icons.insert_drive_file,
                        '${(asset.size / (1024 * 1024)).toStringAsFixed(1)} MB',
                        tooltip: '파일 크기',
                        color: Colors.white.withOpacity(0.55),
                      ),
                      const SizedBox(width: 6),
                      IconText(
                        Icons.download,
                        '${asset.downloadCount}',
                        tooltip: '총 다운로드 수',
                        color: Colors.white.withOpacity(0.55),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
