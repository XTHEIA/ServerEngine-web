import 'package:flutter/material.dart';
import 'package:server_engine_web/images.dart';

class TutorialPage extends StatelessWidget {
  const TutorialPage({super.key});

  static final _tutorialBlocks = TutorialStep.values.map((final step) {
    final comments = step.comments;
    return Padding(
      padding: const EdgeInsets.only(bottom: 70),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${step.index}. ${step.title}',
            style: const TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Divider(),
          Text(step.content),
          const SizedBox(height: 20),
          ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Image.asset(
              step.imageID.assetPath,
              fit: BoxFit.contain,
            ),
          ),
          ...comments.map((comment) => Container(
                margin: const EdgeInsets.only(top: 10),
                color: Colors.white.withOpacity(0.08),
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                child: Row(
                  children: [
                    const Icon(Icons.info, color: Colors.white),
                    const SizedBox(width: 11),
                    Text(comment),
                  ],
                ),
              )),
        ],
      ),
    );
  }).toList(growable: false);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40).copyWith(bottom: 20),
      child: Container(
        width: 99999,
        alignment: Alignment.topCenter,
        child: SizedBox(
          width: 650,
          child: Column(
            children: [
              // info
              Container(
                margin: const EdgeInsets.only(top: 10),
                color: Colors.white.withOpacity(0.08),
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                child: const Row(
                  children: [
                    Icon(Icons.info, color: Colors.white),
                    SizedBox(width: 11),
                    Text('본 프로그램은 시스템에 설치되지 않고 즉시 실행되는 "포터블" 프로그램입니다.'),
                  ],
                ),
              ),
              const SizedBox(height: 30),

              // tutorials
              ..._tutorialBlocks,

              // others
              Container(
                margin: const EdgeInsets.only(top: 10),
                color: Colors.white.withOpacity(0.08),
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                child: const Row(
                  children: [
                    Icon(Icons.info, color: Colors.white),
                    SizedBox(width: 11),
                    Text('더 자세한 정보는 "자주 묻는 질문" 페이지 혹은 디스코드 서버에서 확인하실 수 있습니다.'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

enum TutorialStep {
  download(
    '다운로드',
    ImageID.tutorialDownload,
    '최신 릴리즈 파일을 다운로드합니다.',
    [
      '파일 이름과 확장명은 릴리즈에 따라 변경될 수 있습니다.',
    ],
  ),
  unzip(
    '압축 해제',
    ImageID.tutorialUnzip,
    '다운로드한 파일을 원하는 위치에 압축 해제합니다.',
    [
      'Windows 탐색기로 압축 해제가 불가능한 경우, 제 3자 압축 해제 프로그램을 사용해주세요,\n(반디집, 알집 등)',
      '''
Server Engine 프로그램의 위치와 서버 생성 및 저장 위치는 무관합니다.
실행하기 편한 위치에 압축 해제해 주세요.''',
      '''
프로그램이 데이터를 저장하는 방식은 "자주 묻는 질문"을 참고해주세요.'''
    ],
  ),
  run(
    '실행',
    ImageID.tutorialUnzipped,
    '압축 해제 내용 중 실행 파일을 찾아 실행하여 주세요.',
  );

  final ImageID imageID;
  final String title, content;
  final List<String> comments;

  const TutorialStep(this.title, this.imageID, this.content, [this.comments = const []]);
}
