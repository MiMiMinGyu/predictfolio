import 'package:flutter/material.dart'; // Material package import
import 'package:flutter_localizations/flutter_localizations.dart'; // 다국어 및 지역화 지원
import 'package:provider/provider.dart'; // Provider 패키지 import (상태 관리를 위해 사용)
import 'package:fl_chart/fl_chart.dart'; // fl_chart 패키지 import (차트를 사용하기 위해 사용)
import 'package:predictfolio_app/providers/portfolio_provider.dart'; // PortfolioProvider import
import 'package:predictfolio_app/providers/survey_provider.dart'; // SurveyProvider import (Survey 관련 상태 관리를 위해 사용)
import 'package:predictfolio_app/pages/splash_screen.dart'; // SplashScreen import (첫 화면)
import 'package:predictfolio_app/widgets/main_app_bar.dart'; // main_app_bar import
import 'package:predictfolio_app/pages/survey_pages/survey_page1.dart'; // SurveyPage1 import
import 'package:predictfolio_app/pages/portfolio_page.dart'; // PortfolioPage import

// 앱 실행
void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => PortfolioProvider(), // PortfolioProvider로 상태 관리 설정
        ),
        ChangeNotifierProvider(
          create: (_) => SurveyProvider(), // SurveyProvider로 상태 관리 설정
        ),
      ],
      child: const MyApp(), // MyApp이 최상위 위젯
    ),
  );
}

// 최상위 MyApp 클래스
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      locale: Locale('ko', 'KR'), // 기본 언어를 한국어로 설정
      supportedLocales: [
        Locale('en', 'US'), // 영어 지원
        Locale('ko', 'KR'), // 한국어 지원
      ],
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate, // Material 디자인 지역화
        GlobalWidgetsLocalizations.delegate, // Flutter 위젯 지역화
        GlobalCupertinoLocalizations.delegate, // iOS 스타일 위젯 지역화
      ],
      home: SplashScreen(), // 시작 화면 설정
      debugShowCheckedModeBanner: false, // 디버그 배너 숨김
    );
  }
}

// 메인 페이지 클래스
class MainPage extends StatelessWidget {
  const MainPage({super.key});

  // 색상 리스트 (PortfolioDetailPage와 동일하게 설정)
  final List<Color> colorList = const [
    Color(0xFF002D62), // 짙은 파랑
    Color(0xFF0056B3), // 파랑
    Color(0xFF336699), // 적당한 채도의 파란색
    Color(0xFFB3D4FC), // 연한 파랑
    Color(0xFF6082B6), // 회색빛이 섞인 파랑
    Color(0xFF4A90E2), // 밝은 파랑
    Color(0xFFE8F0FA), // 아주 연한 회색 파랑
    Color(0xFF001F3F), // 깊고 어두운 남색
  ];

  // 금액 형식으로 변환
  String _formatCurrency(int value) {
    return value.toInt().toString().replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+$)'),
          (Match match) => '${match[1]},',
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // 배경색을 흰색으로 설정
      appBar: const MainAppBar(), // 커스텀 MainAppBar 추가
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 20), // 앱바와 포트폴리오 컨테이너 사이의 간격
          Consumer<PortfolioProvider>(
            builder: (context, portfolioProvider, child) {
              return GestureDetector(
                onTap: () {
                  // PortfolioPage로 이동
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PortfolioPage(),
                    ),
                  );
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.9, // 컨테이너 너비
                  height: 280, // 컨테이너 높이
                  decoration: BoxDecoration(
                    color: Colors.white, // 배경색 흰색
                    borderRadius: BorderRadius.circular(20), // 둥근 모서리
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5), // 그림자 설정
                        spreadRadius: 2,
                        blurRadius: 7,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(18.0), // 내부 여백 설정
                    child: portfolioProvider.portfolios.isNotEmpty
                        ? Stack(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  // 왼쪽: 파이차트 (텍스트 추가 포함)
                                  Column(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 5),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          boxShadow: [
                                            // 그림자 설정
                                            BoxShadow(
                                              color: Colors.grey
                                                  .withOpacity(0.3), // 그림자 색상
                                              spreadRadius: 1.5, // 그림자 확산 정도
                                              blurRadius: 4, // 그림자 흐림 정도
                                              offset: const Offset(
                                                  0, 2), // 그림자 위치 설정
                                            ),
                                          ],
                                        ),
                                        // 텍스트 추가
                                        child: const Text(
                                          '최근 생성된 포트폴리오',
                                          style: TextStyle(
                                            fontSize: 14, // 텍스트 크기
                                            fontWeight:
                                                FontWeight.bold, // 텍스트 강조
                                            color: Colors.black, // 텍스트 색상
                                          ),
                                        ),
                                      ),

                                      const SizedBox(
                                          height: 8), // 텍스트와 파이차트 사이 간격

                                      SizedBox(
                                        width: 180, // 파이차트 고정 너비
                                        height: 180, // 파이차트 고정 높이
                                        child: PieChart(
                                          PieChartData(
                                            sections: portfolioProvider
                                                .portfolios
                                                .last
                                                .stockPurchaseDetails
                                                .asMap()
                                                .entries
                                                .map((entry) {
                                              final index = entry.key;
                                              final stock = entry.value;
                                              return PieChartSectionData(
                                                value: stock.totalCost
                                                    .toDouble(), // 주식 투자 금액
                                                color: colorList[index %
                                                    colorList.length], // 색상
                                                radius: 50, // 차트 반지름
                                                title: '', // 제목은 비움
                                              );
                                            }).toList(),
                                            sectionsSpace: 2, // 파이 섹션 간격
                                            centerSpaceRadius: 30, // 차트 가운데 공간
                                            pieTouchData: PieTouchData(
                                                enabled: false), // 터치 비활성화
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(width: 20), // 차트와 텍스트 사이 간격

                                  // 오른쪽: 주식 목록 (텍스트와 원형 색상 표시)
                                  Expanded(
                                    child: SingleChildScrollView(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          ...portfolioProvider.portfolios.last
                                              .stockPurchaseDetails
                                              .asMap()
                                              .entries
                                              .map((entry) {
                                            final index = entry.key;
                                            final stock = entry.value;

                                            return Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 8.0), // 항목 간 간격
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  // 색상 원형 추가
                                                  Container(
                                                    width: 12,
                                                    height: 12,
                                                    decoration: BoxDecoration(
                                                      color: colorList[index %
                                                          colorList.length],
                                                      shape: BoxShape.circle,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                      width: 8), // 간격
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        // 주식명
                                                        Text(
                                                          stock.stock,
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                          overflow: TextOverflow
                                                              .ellipsis, // 텍스트 넘침 방지
                                                        ),
                                                        // 금액
                                                        Align(
                                                          alignment: Alignment
                                                              .centerRight,
                                                          child: Text(
                                                            '${_formatCurrency(stock.totalCost)}원',
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 10,
                                                              color: Colors
                                                                  .black54,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          }),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              // 총 투자 금액
                              Positioned(
                                bottom: 0,
                                left: 14, // 좌측 고정
                                child: Text(
                                  '총 투자 금액: ${_formatCurrency(portfolioProvider.portfolios.last.stockPurchaseDetails.fold<int>(0, (sum, stock) => sum + stock.totalCost))}원',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          )
                        : const Center(
                            child: Text(
                              '생성된 포트폴리오가 없습니다.', // 포트폴리오가 없을 때 표시할 메시지
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                fontFamily: '.SF Pro Text',
                                color: Colors.black,
                              ),
                            ),
                          ),
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 12), // 하단 버튼과 간격
          Row(
            children: [
              const Spacer(), // 왼쪽 공간 추가
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const SurveyPage1(), // SurveyPage로 이동
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25), // 둥근 모서리
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    '새 포트폴리오 생성',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      fontFamily: '.SF Pro Text',
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 20), // 오른쪽 여백
            ],
          ), // Row 종료
        ], // Column 종료
      ), // body 종료
    ); // Scaffold 종료
  }
}
