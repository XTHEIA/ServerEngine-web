import 'package:flutter/material.dart';

enum ImageID {
  // screenshots
  config.screen('config', '서버 기본 설정'),
  configAdvanced.screen('configAdvanced', '서버 고급 실행 설정'),
  configRun.screen('configRun', '서버 실행 설정'),
  eula.screen('eula', 'EULA 동의 페이지'),
  events.screen('events', '이벤트 분석 유틸리티'),
  itemgiver.screen('itemgiver', '아이템 지급 유틸리티'),
  javas.screen('javas', 'Java 런타임 관리 페이지'),
  langs.screen('langs', '언어 파일 관리 페이지'),
  listPing.screen('listPing', '서버 연결 테스트 페이지'),
  main.screen('main', '메인 화면'),
  paperDownloader.screen('paperDownloader', 'PaperMC 빌드 다운로드 유틸리티'),
  playerData.screen('playerData', '플레이어 데이터 분석 유틸리티'),
  playerCommands.screen('playerActions', '플레이어 명령어 팔레트'),
  players.screen('players', '플레이어 목록 페이지'),
  plugins.screen('plugins', '플러그인 페이지'),
  runConsole0.screen('runConsole0', '서버 실행 중 화면 - 1'),
  runConsole1.screen('runConsole1', '서버 실행 중 화면 - 2'),
  runWait.screen('runWait', '서버 실행 대기 화면'),
  worlds.screen('worlds', '월드 목록 페이지'),
  serverIcon.screen('serverIcon', '서버 아이콘 설정 페이지'),
  serverProperties.screen('serverProperties', '서버 설정(server.properties) 에디터'),
  serverCreationPaper.screen('serverCreationPaper', 'PaperMC 서버 자동 생성 페이지'),
  serverCreations.screen('serverCreations', '서버 생성/추가 페이지'),
  settingSave.screen('settingSave', '앱 설정 저장 페이지'),
  worldCommands.screen('worldCommands', '월드 명령어 팔레트'),
  ngrokRun.screen('ngrokRun','실행 페이지 ngrok 터널링 정보'),
  ngrokInstances.screen('ngrokInstances','ngrok 인스턴스 목록 페이지'),
  ngrokStarter0.screen('ngrokStarter0','ngrok 인스턴스 옵션 구성 페이지'),

  // feature
  eulaFocus.feature('eula', 'EULA 동의 페이지'),
  eventsFocus.feature('events', '이벤트 분석 유틸리티'),
  itemGiverFocus.feature('itemGiver', '아이템 지급 유틸리티'),
  javaFocus.feature('java', 'Java 런타임 페이지'),
  javaDetailFocus.feature('javaDetail', 'Java 런타임 세부사항'),
  listPingFocus.feature('listPing', '서버 연결 테스트 페이지'),
  playerCommandsFocus.feature('playerCommands', '플레이어 명령어 팔레트'),
  playerDataFocus.feature('playerData', '플레이어 데이터 분석 유틸리티'),
  playersFocus.feature('players', '플레이어 목록 페이지'),
  runConsoleFocus.feature('runConsole', '서버 실행 화면(콘솔)'),
  runWaitFocus.feature('runWait', '서버 실행 대기 화면'),
  serverCreationPaperFocus.feature('serverCreationPaper', 'PaperMC 서버 생성'),
  serverIconFocus.feature('serverIcon', '서버 아이콘 설정 페이지'),
  worldCommandsFocus.feature('worldCommands', '월드 명령어 팔레트'),
  configRunFocus.feature('configRun', '서버 실행 설정 페이지'),
  serverProperties0Focus.feature('serverProperties0', '서버 설정(server.properties) 에디터 - 1'),
  serverProperties1Focus.feature('serverProperties1', '서버 설정(server.properties) 에디터 - 2'),
  pluginsFocus.feature('plugins', '서버 플러그인 관리 페이지'),
  discordRpcFocus.feature('discordRpc','디스코드 활동 상태 표시 기능 (서버 홍보 가능)'),
  ngrokInstancesFocus.feature('ngrokInstances','ngrok 인스턴스 목록 페이지'),
  ngrokRunFocus.feature('ngrokRun','서버 실행 중 ngrok 터널링 정보 위젯'),

  // tutorial
  tutorialDownload.windowsTutorial('download', '릴리즈 압축 파일 다운로드'),
  tutorialUnzip.windowsTutorial('unzip', '압축 해제'),
  tutorialUnzipped.windowsTutorial('unzipped', '압축 해제 후 실행'),
  ;

  final String assetPath, label;
  final String? desc;

  const ImageID(this.assetPath, this.label, [this.desc]);

  const ImageID.screen(String assetId, String label, [String? desc])
      : this('assets/image/screen/$assetId.png', label, desc);

  const ImageID.feature(String assetId, String label, [String? desc])
      : this('assets/image/feature/$assetId.png', label, desc);

  const ImageID.windowsTutorial(String assetId, String label)
      : this('assets/image/tutorial/win/$assetId.png', label);
}

class LabelledImage extends StatelessWidget {
  final ImageID imageID;
  final BoxFit? fit;

  const LabelledImage(
    this.imageID, {
    super.key,
    this.fit,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showDialog(
            context: context,
            builder: (final context) {
              return Dialog(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      InkWell(
                        onTap: () => Navigator.pop(context),
                        child: Image.asset(
                          imageID.assetPath,
                          width: 1300,
                          fit: BoxFit.contain,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(imageID.label),
                    ],
                  ),
                ),
              );
            });
      },
      child: Image.asset(
        imageID.assetPath,
        fit: fit,
      ),
    );
  }
}
