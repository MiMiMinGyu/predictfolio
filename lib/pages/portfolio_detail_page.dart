import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart'; // fl_chart 패키지 import
import 'package:predictfolio_app/models/portfolio.dart';
import 'package:predictfolio_app/widgets/main_app_bar.dart';
import 'portfolio_page.dart'; // PortfolioPage 경로 import

class PortfolioDetailPage extends StatefulWidget {
  final Portfolio portfolio; // JSON 형태의 포트폴리오 데이터

  const PortfolioDetailPage({super.key, required this.portfolio});

  @override
  PortfolioDetailPageState createState() => PortfolioDetailPageState();
}

class PortfolioDetailPageState extends State<PortfolioDetailPage> {
  // 주식 성향 분석 데이터
  late Map<String, double> traitDataMap;

  // 주요 성향
  late String dominantTrait;

  // 추천 주식 데이터
  late Map<String, double> stockDataMap;

  // 색상 리스트
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

  @override
  void initState() {
    super.initState();
    generateTraitDataMap();
    generateStockDataMap();
    dominantTrait = getDominantTrait(widget.portfolio.traits);
  }

  // 주식 성향 분석 데이터 생성
  void generateTraitDataMap() {
    traitDataMap = {
      '수익추구 성향': widget.portfolio.traits.profit.toDouble(),
      '분석추구 성향': widget.portfolio.traits.analysis.toDouble(),
      '안전성추구 성향': widget.portfolio.traits.safety.toDouble(),
      '투자집착 성향': widget.portfolio.traits.obsession.toDouble(),
    };
  } // 주식 성향 분석 데이터 생성

  // 추천 주식 데이터 생성
  void generateStockDataMap() {
    final stockDetails = widget.portfolio.stockPurchaseDetails;
    stockDataMap = {
      for (var stock in stockDetails) stock.stock: stock.totalCost.toDouble()
    };
  } // 주식 성향 계산

  // 주요 성향 계산
  String getDominantTrait(Traits traits) {
    final Map<String, double> traitValues = {
      '수익추구 성향': traits.profit.toDouble(),
      '분석추구 성향': traits.analysis.toDouble(),
      '안전성추구 성향': traits.safety.toDouble(),
      '투자집착 성향': traits.obsession.toDouble(),
    }; // 성향 값 맵 생성

    final dominant = traitValues.entries.reduce(
      (a, b) => a.value > b.value ? a : b,
    ); // 가장 큰 값 찾기

    return dominant.key;
  }

  @override
  Widget build(BuildContext context) {
    // totalCost 기준으로 내림차순 정렬
    final sortedStockDetails = widget.portfolio.stockPurchaseDetails
      ..sort((a, b) => b.totalCost.compareTo(a.totalCost));

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const MainAppBar(),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0), // 전체 여백
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 주식 성향 분석 차트
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 24.0, vertical: 32.0), // 내부 여백
                  margin: const EdgeInsets.symmetric(vertical: 8.0), // 박스 간 간격
                  decoration: BoxDecoration(
                    color: const Color(0xFFF5F5F5), // 연한 회색 배경
                    borderRadius: BorderRadius.circular(30.0), // 둥근 모서리
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Image.asset(
                            'assets/bar.png',
                            width: 32, // 이미지 너비 설정
                            height: 32, // 이미지 높이 설정
                            fit: BoxFit.contain, // 이미지가 잘 맞도록 설정
                          ),
                          const SizedBox(width: 5),
                          const Text(
                            '주식 성향 분석',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 50),
                      AspectRatio(
                        aspectRatio: 1.5,
                        child: PieChart(
                          PieChartData(
                            sections: _generateTraitSections(),
                            sectionsSpace: 4,
                            centerSpaceRadius: 50,
                            pieTouchData: PieTouchData(enabled: false),
                          ),
                        ),
                      ),
                      const SizedBox(height: 50),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          '사용자의 투자 성향: $dominantTrait',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 0),

                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 24.0, vertical: 32.0), // 내부 여백
                  margin: const EdgeInsets.symmetric(vertical: 8.0), // 박스 간 간격
                  decoration: BoxDecoration(
                    color: const Color(0xFFF5F5F5), // 연한 회색 배경
                    borderRadius: BorderRadius.circular(30.0), // 둥근 모서리
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Image.asset(
                            'assets/bar.png', // 아이콘 대신 사용할 로고 이미지
                            width: 32, // 이미지 너비 설정
                            height: 32, // 이미지 높이 설정
                            fit: BoxFit.contain, // 이미지가 잘 맞도록 설정
                          ),
                          const SizedBox(width: 5),
                          const Text(
                            '추천 주식',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 50),
                      AspectRatio(
                        aspectRatio: 1.5,
                        child: PieChart(
                          PieChartData(
                            sections: _generateStockSections(),
                            sectionsSpace: 4,
                            centerSpaceRadius: 50,
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // 모든 주식 세부 정보 나열 (라운드된 박스 형태)
                const Text(
                  '세부 정보',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: '.SF Pro Text',
                  ),
                ),

                const SizedBox(height: 15),

                // 주식 정보 리스트 생성
                ...sortedStockDetails.map((stockDetails) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 16.0), // 박스 간 간격
                    padding: const EdgeInsets.all(16.0), // 내부 여백
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.0), // 라운딩 처리
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          blurRadius: 8,
                          spreadRadius: 2,
                          offset: const Offset(0, 2), // 그림자 방향
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildDetailRow('주식명', stockDetails.stock),
                        const SizedBox(height: 8), // 항목 간 간격
                        _buildDetailRow(
                            '가격', '${_formatCurrency(stockDetails.price)}원'),
                        const SizedBox(height: 8),
                        _buildDetailRow('수량', '${stockDetails.shares}주'),
                        const SizedBox(height: 8),
                        _buildDetailRow('총 투자 금액',
                            '${_formatCurrency(stockDetails.totalCost)}원'),
                      ],
                    ),
                  );
                }),

                const SizedBox(height: 60), // 하단 추가 여백
              ],
            ),
          ),

          // 고정된 버튼
          Positioned(
            bottom: 16,
            right: 16,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PortfolioPage(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                    horizontal: 25, vertical: 15), // 버튼 크기
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25), // 둥근 모서리
                ),
                elevation: 5, // 그림자 효과
              ),
              child: const Text(
                '포트폴리오 페이지로 이동',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  fontFamily: '.SF Pro Text',
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 주식 성향 섹션 생성
  List<PieChartSectionData> _generateTraitSections() {
    final List<String> keys = traitDataMap.keys.toList();
    final List<double> values = traitDataMap.values.toList();

    return List.generate(traitDataMap.length, (index) {
      final String key = keys[index];
      return PieChartSectionData(
        value: values[index],
        title: '${values[index].toStringAsFixed(1)}%',
        color: colorList[index % colorList.length],
        radius: 70,
        titleStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        badgeWidget: _buildStockBadge(key),
        badgePositionPercentageOffset: 1.4,
      );
    });
  }

  // 추천 주식 섹션 생성
  List<PieChartSectionData> _generateStockSections() {
    final List<String> keys = stockDataMap.keys.toList();
    final List<double> values = stockDataMap.values.toList();

    return List.generate(stockDataMap.length, (index) {
      final String key = keys[index];
      return PieChartSectionData(
        value: values[index],
        title: '',
        color: colorList[index % colorList.length],
        radius: 70,
        badgeWidget: _buildStockBadge(key),
        badgePositionPercentageOffset: 1.55,
      );
    });
  }

  // 주식 배지 생성
  Widget _buildStockBadge(String stockName) {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 2,
          ),
        ],
      ),
      child: Text(
        stockName,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  // 세부 정보 행 생성
  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              fontFamily: '.SF Pro Text',
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontFamily: '.SF Pro Text',
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  // 금액을 3자리마다 쉼표로 포맷팅
  String _formatCurrency(int value) {
    return value.toInt().toString().replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+$)'),
          (Match match) => '${match[1]},',
        );
  }
}
