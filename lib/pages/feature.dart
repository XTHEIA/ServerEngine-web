import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:seo/seo.dart';
import 'package:server_engine_web/images.dart';
import 'package:server_engine_web/main.dart';
import 'package:server_engine_web/slideshow.dart';
import 'package:server_engine_web/widgets/seo_text.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  static int c = 0;
  static final featureBlocks = ImagedFeature.values.map((feature) {
    final isImageLeft = c++ % 2 == 0;
    final images = feature.images;
    final show = Flexible(
      flex: 5,
      child: Container(
        decoration: const BoxDecoration(boxShadow: [
          BoxShadow(
            offset: Offset(.5, .5),
            blurRadius: 10,
            spreadRadius: 0,
          ),
        ]),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(13),
          child: Slideshow(
            transitionMili: 400,
            children: images
                .map((imageID) => LabelledImage(
                      imageID,
                      key: UniqueKey(),
                      fit: BoxFit.contain,
                    ))
                .toList(),
          ),
        ),
      ),
    );

    const space = SizedBox(width: 35);

    final words = Flexible(
      flex: 4,
      child: Container(
        alignment: Alignment.topLeft,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            SeoText(feature.label,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                )),
            const Divider(),
            const SizedBox(height: 10),
            Text.rich(
              feature.description,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );

    return Container(
      margin: const EdgeInsets.only(bottom: 120),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.transparent),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: isImageLeft ? [show, space, words] : [words, space, show],
      ),
    );
  }).toList(growable: false);

  static final List<Widget> bannerImages = _Banner.values
      .map((banner) => Column(
            key: UniqueKey(),
            children: [
              Image.asset(
                banner.assetPath,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 15),
              Text(banner.label),
            ],
          ))
      .toList();

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  static final chipColor = Colors.blueGrey.withOpacity(0.15);
  static final selectedChipColor = Colors.blueGrey.withOpacity(0.5);
  Timer? _rotationTimer;
  Feature _currentFeature = Feature.servers;
  int _currentImageIdx = 0;

  void _setCurrentFeature(Feature feature) {
    setState(() {
      _currentFeature = feature;
      _currentImageIdx = 0;
    });
  }

  void _rotateImage() {
    setState(() {
      _currentImageIdx += 1;
      if (_currentImageIdx >= _currentFeature.images.length) {
        _currentImageIdx = 0;
        _currentFeature = Feature.getNextFeature(_currentFeature);
      }
    });
  }

  void _startRotationTimer() {
    _rotationTimer?.cancel();
    _rotationTimer = Timer.periodic(
      const Duration(milliseconds: 3000),
      (timer) {
        _rotateImage();
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _startRotationTimer();
  }

  @override
  void dispose() {
    super.dispose();
    _rotationTimer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    final currentFeature = _currentFeature;
    final currentImageIdx = _currentImageIdx;
    final currentImage = currentFeature.images[currentImageIdx];

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            backgroundColor,
            Color.lerp(backgroundColor, Colors.black, 0.4)!,
          ],
          transform: const GradientRotation(pi / 2),
        ),
      ),
      child: Column(
        children: [
          const SizedBox(height: 40),
          Container(
            width: 1400,
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: Column(
              children: [
                Seo.text(
                  text: '서버 통합 관리 엔진',
                  child: const Text.rich(
                    TextSpan(children: [
                      TextSpan(
                        text: 'Server Engine',
                        style: TextStyle(
                            fontFamily: jetBrainsMono, letterSpacing: -2.5),
                      ),
                      TextSpan(text: ' : 통합 서버 관리 엔진'),
                    ]),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 46,
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(
                            color: Colors.black,
                            blurRadius: 3,
                            offset: Offset(1, 1)),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 150),
                  child: Column(
                    key: UniqueKey(),
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        // show fullscreen
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
                                            currentImage.assetPath,
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        Text(currentImage.label),
                                      ],
                                    ),
                                  ),
                                );
                              });
                        },

                        // main slide
                        child: Container(
                          decoration: const BoxDecoration(boxShadow: [
                            BoxShadow(
                              offset: Offset(2, 2),
                              spreadRadius: 1,
                              blurRadius: 12,
                              color: Colors.black,
                            ),
                          ]),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: AspectRatio(
                              aspectRatio: 1080 / 815,
                              child: Image.asset(
                                currentImage.assetPath,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 13),
                        child: Tooltip(
                          message: '현재 이미지 : ${currentImage.label}',
                          child: Text(
                            currentFeature.description,
                            maxLines: 1,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // line
          Container(
            width: 9999,
            alignment: Alignment.center,
            color: Colors.blueGrey.withOpacity(0.06),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 30),
            child: Wrap(
              spacing: 25,
              runSpacing: 22,
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: Feature.values.map((feature) {
                final isCurrent = _currentFeature == feature;
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    InkWell(
                      onTap: () {
                        _setCurrentFeature(feature);
                        _startRotationTimer();
                        analytics
                            .logEvent(name: 'feature-selected', parameters: {
                          'feature': feature.name,
                          'label': feature.label,
                        });
                      },
                      child: Container(
                        width: 70,
                        height: 70,
                        margin: const EdgeInsets.only(bottom: 8),
                        decoration: BoxDecoration(
                          color: isCurrent ? selectedChipColor : chipColor,
                          border: Border.all(color: Colors.transparent),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Icon(feature.iconData, size: 27),
                      ),
                    ),
                    Seo.text(
                      text: feature.label,
                      child: Text(
                        feature.label,
                        maxLines: 1,
                        style: const TextStyle(
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 60),

          // feature blocks
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            width: 1400,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: MainPage.featureBlocks,
            ),
          ),
        ],
      ),
    );
  }
}

enum _Banner {
  main('main', '메인 페이지'),
  run0('run0', '서버 실행 대기 화면'),
  run1('run1', '서버 실행 중 화면'),
  players('players', '플레이어 목록'),
  playerData('playerData', '플레이어 데이터'),
  playerAction('playerAction', '플레이어 명령어 팔레트'),
  itemGiver('itemGiver', '아이템 지급 화면'),
  events('events', '이벤트(채팅 등) 분석'),
  serverProperties('serverProperties', '서버 설정(server.properties) 에디터'),
  worldCommands('worldCommands', '월드 명령어 팔레트'),
  serverIcon('serverIcon', '서버 아이콘 설정 유틸리티'),
  eula('eula', 'EULA(최종 사용자 계약) 동의 화면'),
  config0('config0', '기본 설정 화면'),
  config1('config1', '실행 설정 화면'),
  config2('config2', '고급 실행 설정 화면'),
  listPing('listPing', '서버 연결 유틸리티'),
  ;

  final String id, label, assetPath;

  const _Banner(this.id, this.label)
      : assetPath = 'assets/image/banner/$id.png';
}

enum Feature {
  servers(Icons.dns, '서버 통합 관리', '여러 개의 서버를 프로그램 내에서 간편하게 관리합니다.', [
    ImageID.main,
  ]),
  serverCreation(Icons.download, '자동 서버 생성', '원하는 버전의 서버를 자동으로 다운로드하여 생성합니다.', [
    ImageID.serverCreationPaper,
    ImageID.serverCreations,
    ImageID.paperDownloader,
  ]),
  run(Icons.play_arrow, '커스텀 실행', '클릭 한 번으로 서버를 실행하고 다양한 설정을 구성합니다.', [
    ImageID.runWait,
    ImageID.configRun,
    ImageID.configAdvanced,
  ]),
  ngrok(Icons.lan, 'ngrok 포트포워딩', 'ngrok를 사용하여 포트포워딩 없이 서버를 개방합니다.', [
    ImageID.ngrokStarter0,
    ImageID.ngrokInstances,
    ImageID.ngrokRun,
  ]),
  performance(Icons.memory, '리소스 모니터링', '각 서버가 사용하는 리소스를 모니터링합니다.', [
    ImageID.runConsole0,
    ImageID.runConsole1,
  ]),
  player(Icons.people, '플레이어 분석',
      '서버로부터 플레이어 데이터를 추출하여 분석합니다. 인벤토리, 통계 등의 데이터를 시각화합니다.', [
    ImageID.players,
    ImageID.playerData,
  ]),
  commands(Icons.terminal, '명령어 팔레트', '유용한 월드, 플레이어 명령어를 간편하게 실행합니다.', [
    ImageID.worldCommands,
    ImageID.playerCommands,
  ]),
  events(Icons.chat, '이벤트 분석', '채팅 등의 서버 이벤트를 분석합니다.', [
    ImageID.events,
  ]),
  serverIcon(
      Icons.image, '아이콘 설정', '서버 아이콘을 간편하게 설정합니다. 알맞는 크기와 포맷으로 자동 변환됩니다.', [
    ImageID.serverIcon,
  ]),
  configuration(Icons.settings, '설정 구성', '다양한 서버의 설정을 간편하게 구성합니다.', [
    ImageID.serverProperties,
    ImageID.plugins,
    ImageID.eula,
  ]),
  listPing(Icons.hub_outlined, '서버 연결', '실제 마인크래프트 서버와의 연결을 테스트합니다.', [
    ImageID.listPing,
  ]),
  java(Icons.code, 'Java 관리', '서버 실행에 사용할 Java 런타임을 관리합니다.', [
    ImageID.javas,
  ]),
  ;

  final IconData iconData;
  final String label, description;
  final List<ImageID> images;

  const Feature(this.iconData, this.label, this.description, this.images);

  static const _values = values;
  static final _valuesLength = _values.length;

  static Feature getNextFeature(Feature current) {
    final nextIdx = current.index + 1;
    if (nextIdx >= Feature._valuesLength) {
      return _values[0];
    }
    return _values[nextIdx];
  }
}

enum ImagedFeature {
  creation(
    '간편한 서버 생성',
    [ImageID.serverCreationPaperFocus],
    TextSpan(
        text: ('''
버전 선택만으로 원하는 버전의 서버가 자동 생성됩니다.
번거로운 서버 코어(버킷) 다운로드 없이 빠르게 서버를 구축할 수 있습니다.''')),
  ),
  run(
    '빠르고 강력한 구동',
    [ImageID.runWaitFocus, ImageID.runConsoleFocus, ImageID.configRunFocus],
    TextSpan(text: '프로그램 내에서 서버를 쉽고 빠르게 실행합니다.\n다양한 실행 옵션을 간편하게 구성합니다.'),
  ),
  ngrok(
    '포트포워딩 없는 서버 개방',
    [ImageID.ngrokInstancesFocus, ImageID.ngrokRunFocus],
    TextSpan(text: '''
복잡한 과정 없이 주소 하나로 누구나 서버에 접속할 수 있게 서버를 개방합니다.
복잡한 포트포워딩, Hamachi 없이 서버에 접속할 수 있습니다.

(비교적 지연시간이 높습니다.)
'''),
  ),
  players(
    '플레이어 데이터 분석',
    [ImageID.playerDataFocus, ImageID.playersFocus],
    TextSpan(text: '''
서버의 플레이어 접속 캐시와 저장 데이터, 그리고 실시간 접속 로그를 분석합니다.
플레이어의 온라인 상태 및 다양한 데이터를 시각화하여 제공합니다.
체력, 포만감, 레벨, 현재 위치, 사망 위치, 첫 접속 시간, 
통계, 인벤토리 심지어 엔더 상자의 아이템까지 파악 가능합니다.

플레이어 고유 ID를 Mojang에 쿼리하여 닉네임을 변경하더라도 실제 닉네임이 표시됩니다.'''),
  ),
  commands(
    '명령어 팔레트',
    [
      ImageID.playerCommandsFocus,
      ImageID.worldCommandsFocus,
      ImageID.itemGiverFocus
    ],
    TextSpan(text: '''
클릭 한 번으로 다양한 기능을 수행하는 유틸리티를 제공합니다.
        
[월드 명령어 팔레트]
월드를 대상으로 한 다양한 액션을 제공합니다.
날씨 조정, 인벤세이브 토글, 시간대 변경, 게임 속도 조절, 몬스터 스폰 조절 등
       
[플레이어 명령어 팔레트]
플레이어를 대상으로 한 다양한 액션을 제공합니다.
OP 부여/박탈, 게임모드 변경, 인벤토리 초기화, 추방, 처치, 회복 등
       
[아이템 지급 유틸리티]
원하는 플레이어에게 아이템을 빠르게 지급합니다.
복잡한 아이템 ID 검색 없이 아이템의 이름을 검색하여 지급할 수 있습니다.'''),
  ),
  events(
    '이벤트 로그 분석',
    [ImageID.eventsFocus],
    TextSpan(text: '''
서버에 저장된 로그 파일을 분석하여 주요 이벤트를 찾아냅니다.
발견된 이벤트는 적절히 번역되어 강력하게 시각화됩니다.
복잡하고 딱딱한 로그 파일 대신 마치 채팅방을 보는 듯한 경험을 제공합니다.

모든 이벤트는 초 단위로 발생한 시간이 포함되어 제공됩니다.

분석 가능 항목 : 플레이어 로그인, 접속, 퇴장, 채팅, 사망, 도전 과제, 서버 구동 등
'''),
  ),
  configuration(
    '서버 설정 에디터',
    [
      ImageID.serverProperties0Focus,
      ImageID.serverProperties1Focus,
      ImageID.pluginsFocus
    ],
    TextSpan(text: '''
서버의 다양한 설정 및 확장을 쉽고 간편하게 관리할 수 있습니다.

[서버 설정 에디터]
번거로운 server.properties 편집 작업 없이 서버의 설정을 빠르게 구성할 수 있습니다.
(더 이상 메모장으로 파일을 열지 않아도 됩니다.

[플러그인 관리]
플러그인 관리 페이지에 플러그인 파일을 드래그하면 서버 폴더로 파일이 복사됩니다.
또한 서버에 적용된 플러그인의 메타데이터를 파악하여 데이터 폴더를 정리하여 보여줍니다.'''),
  ),
  icon(
    '서버 아이콘 설정(변환) 유틸리티',
    [ImageID.serverIconFocus],
    TextSpan(text: '''
이미지 파일 선택만으로 서버 아이콘을 설정할 수 있습니다.
서버 이미지의 까다로운 조건(64*64, .png 형식)에 맞게
자동으로 이미지가 변환되어 적용됩니다.

(본 프로그램의 아이콘으로 설정할 수도 있습니다.)'''),
  ),
  listping(
    '서버 연결 유틸리티',
    [ImageID.listPingFocus],
    TextSpan(text: '''
게임을 켜지 않고도 실제 서버에 연결하여 
온라인 상태, MOTD, 플레이어 목록을 파악할 수 있습니다.

본 프로그램이 실행 중인 시스템의 로컬 서버에 대해서도
서버가 잘 동작하고 있는지 파악할 수 있습니다.'''),
  ),
  discordRpc(
    'Discord 활동 상태',
    [
      ImageID.discordRpcFocus,
    ],
    TextSpan(text: '''
디스코드에 현재 프로그램 사용 상태를 표시합니다.
실행 중인 서버의 수가 표시되고,
서버 주소를 기재해 멀티플레이 인원을 모집할 수 있습니다.'''),
  ),
  java(
    'Java 런타임 관리',
    [ImageID.javaFocus, ImageID.javaDetailFocus],
    TextSpan(text: '''
시스템에 설치된 Java 런타임의 버전 및 세부사항을 파악합니다.
여러 개의 Java 런타임을 관리하고,
각 서버별로 원하는 런타임을 사용하여 서버를 실행할 수 있습니다.'''),
  ),
  ;

  final String label;
  final List<ImageID> images;
  final TextSpan description;

  const ImagedFeature(this.label, this.images, this.description);
}
