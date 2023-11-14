import 'package:flutter/material.dart';

class QnAPage extends StatelessWidget {
  const QnAPage({super.key});

  static final _qnaBlocks = QnA.values
      .map((node) => Container(
            margin: const EdgeInsets.only(bottom: 55),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Q. ${node.question}',
                  style: const TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
                ),
                const Divider(),
                Text(
                  node.answer,
                  style: TextStyle(color: Colors.white.withOpacity(0.85)),
                ),
              ],
            ),
          ))
      .toList(growable: false);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      alignment: Alignment.center,
      child: SizedBox(
        width: 800,
        child: Column(
          children: [
            Wrap(
              direction: Axis.horizontal,
              spacing: 40,
              children: _qnaBlocks,
            ),
            const SizedBox(height: 10),
            Container(
              margin: const EdgeInsets.only(top: 10),
              color: Colors.white.withOpacity(0.08),
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
              child: const Row(
                children: [
                  Icon(Icons.info, color: Colors.white),
                  SizedBox(width: 11),
                  Text('본 페이지 외에도 디스코드 서버에서 도움을 받으실 수 있습니다.'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

enum QnA {
  diskUsage(
    '프로그램이 시스템에 설치되나요?',
    '본 프로그램은 PC의 프로그램 폴더에 설치되지 않고 즉시 실행되는 포터블(portable) 프로그램입니다.',
  ),
  deletion(
    '프로그램을 삭제할 경우 데이터가 손실되나요?',
    '본 프로그램은 각종 설정 및 서버의 데이터를 문서 폴더 내의 "ServerEngine" 폴더에 저장합니다.\n'
        '따라서 본 프로그램의 실행 파일(.exe)를 삭제하여도 데이터는 손실되지 않습니다.\n'
        '새 버전의 프로그램을 사용할 경우 이전의 프로그램을 삭제하여도 데이터는 안전합니다.',
  ),
  javaInstallation(
    'Java 런타임이 포함되어 있나요?',
    '아닙니다. 서버가 요구하는 버전의 Java 런타임을 직접 설치하셔야 합니다.\n'
        '본 프로그램 내에 Java 런타임이 포함되어 있지 않습니다.\n'
        '설치 후 프로그램 내의 Java 런타임 자동 감지 추가 기능 혹은 수동 추가를 이용해 주세요.',
  ),
  dataLocation(
      '데이터가 저장되는 위치를 변경할 수 있나요?',
      '프로그램이 데이터 폴더로 사용하는 폴더의 위치를 변경하는 기능은 아직 구현되어 있지 않습니다.\n'
          '각 서버의 데이터가 저장되는 위치를 변경하고 싶으시면,\n'
          '서버 생성 후 서버 폴더를 원하는 위치로 옮긴 뒤 "외부 서버 추가" 기능을 사용하여 주세요.'),
  oldVersion(
    '왜 업데이트가 필수적인가요?',
    '''
본 프로그램은 서버의 데이터와 프로세스에 접근하여 다양한 분석 및 펀집 기능을 제공합니다.
버그나 오류가 남아 있는 구버전을 사용할 경우 서버의 데이터의 손실을 야기할 수 있습니다.
따라서 발견된 버그가 수정된 최신 릴리즈 외에는 사용을 제한하고 있습니다.''',
  ),
  ;

  final String question, answer;

  const QnA(this.question, this.answer);
}
