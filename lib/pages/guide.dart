import 'package:flutter/material.dart';
import 'package:server_engine_web/pages/qna.dart';
import 'package:server_engine_web/pages/tutorial.dart';
import 'package:url_launcher/url_launcher.dart';

class GuidePage extends StatefulWidget {
  const GuidePage({super.key});

  @override
  State<GuidePage> createState() => _GuidePageState();
}

class _GuidePageState extends State<GuidePage> {
  _Page? _currentPage;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        onTap: () {
          launchUrl(Uri.parse('https://docs.server-engine.kr/'));
        },
        child: Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Colors.blueGrey.withOpacity(0.4),
            borderRadius: BorderRadius.circular(5),
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.document_scanner, size: 34),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '가이드 문서',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  Text('가이드 문서로 이동'),
                ],
              ),
            ],
          ),
        ),
      ),
    );

    final page = _currentPage;
    if (page == null) {
      return Container(
        height: 500,
        width: 999999,
        alignment: Alignment.bottomCenter,
        child: Wrap(
          spacing: 20,
          children: _Page.values
              .map((page) => InkWell(
                    onTap: () => setState(() {
                      _currentPage = page;
                    }),
                    child: Container(
                      height: 200,
                      width: 200,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                      ),
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(height: 3),
                          Icon(
                            page.iconData,
                            size: 70,
                          ),
                          const SizedBox(height: 13),
                          Text(
                            page.label,
                            style: const TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ))
              .toList(growable: false),
        ),
      );
    }
    return page.content;
  }
}

enum _Page {
  // TODO 생성자에 위젯을 넣은 건 정말 안 좋은 생각인듯

  tutorial(
    '시작 가이드',
    '다운로드부터 실행까지의 과정',
    Icons.download,
    TutorialPage(),
  ),
  qna(
    '자주 묻는 질문',
    '자주 묻는 질문',
    Icons.question_answer,
    QnAPage(),
  ),
  ;

  final IconData iconData;
  final String label, description;
  final Widget content;

  const _Page(
    this.label,
    this.description,
    this.iconData,
    this.content,
  );
}
