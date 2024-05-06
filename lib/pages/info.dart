import 'package:flutter/material.dart';
import 'package:server_engine_web/main.dart';
import 'package:server_engine_web/widgets/fonttile.dart';
import 'package:url_launcher/url_launcher.dart';

class InformationPage extends StatelessWidget {
  const InformationPage({super.key});

  static const textStyle = TextStyle(fontSize: 24, fontWeight: FontWeight.bold);

  static void launchGitHubActions() {
    launchUrl(Uri.parse('https://docs.github.com/actions'));
  }

  static void launchGitHubPages() {
    launchUrl(Uri.parse('https://pages.github.com/'));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      alignment: Alignment.topCenter,
      child: const SizedBox(
        width: 460,
        child: Column(
          children: [
            // framework
            Text('프레임워크', style: textStyle),
            Divider(),
            SizedBox(
              height: 100,
              child: FlutterLogo(
                  style: FlutterLogoStyle.horizontal,
                  size: 250,
                  textColor: Colors.white),
            ),
            SizedBox(height: 60),

            // ci/cd
            Text('CI/CD', style: textStyle),
            Divider(),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 230,
                  child: InkWell(
                    onTap: launchGitHubActions,
                    child: Text(
                      'GitHub Actions',
                      textAlign: TextAlign.right,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                    ),
                  ),
                ),
                SizedBox(
                  height: 40,
                  child: VerticalDivider(),
                ),
                SizedBox(
                  width: 230,
                  child: InkWell(
                    onTap: launchGitHubPages,
                    child: Text(
                      'GitHub Pages',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 60),

            // font
            Text('글꼴', style: textStyle),
            Divider(),
            SizedBox(height: 10),
            FontBlock(
              fontName: '네이버 나눔바른고딕',
              fontFamilly: nanumBarunGothic,
              url: 'https://hangeul.naver.com/font/nanum',
              color: Color(0xFF2DB400),
            ),
            SizedBox(height: 10),
            FontBlock(
              fontName: 'JetBrains Mono',
              fontFamilly: jetBrainsMono,
              url: 'https://www.jetbrains.com/lp/mono/',
              color: Colors.white,
            ),
            SizedBox(height: 10),
            FontBlock(
              fontName: 'Noto Sans KR',
              fontFamilly: 'Noto Sans',
              url: 'https://fonts.google.com/noto/specimen/Noto+Sans+KR',
              color: Colors.redAccent,
            ),
            SizedBox(height: 10),
            FontBlock(
              fontName: 'Pretendard',
              fontFamilly: pretendard,
              url: 'https://github.com/orioncactus/pretendard',
              color: Colors.amberAccent,
            ),
          ],
        ),
      ),
    );
  }
}
