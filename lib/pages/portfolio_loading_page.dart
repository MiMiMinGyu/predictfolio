import 'package:flutter/material.dart';
import 'package:predictfolio_app/pages/portfolio_detail_page.dart';
import 'package:provider/provider.dart';
import 'package:predictfolio_app/providers/portfolio_provider.dart'; // PortfolioProvider import
import 'package:predictfolio_app/providers/survey_provider.dart'; // SurveyProvider import
import 'dart:async';

class PortfolioLoadingPage extends StatefulWidget {
  const PortfolioLoadingPage({super.key});

  @override
  PortfolioLoadingPageState createState() =>
      PortfolioLoadingPageState(); // 상태 객체 PortfolioLoadingPageState를 생성
}

class PortfolioLoadingPageState extends State<PortfolioLoadingPage> {
  String _loadingText = '포트폴리오 생성 중'; // 로딩 중 표시할 기본 텍스트
  int _dotCount = 0; // 애니메이션 점 개수
  Timer? _timer;
  @override
  void initState() {
    super.initState();

    // 점이 추가되는 애니메이션 설정
    _timer = Timer.periodic(const Duration(milliseconds: 500), (Timer timer) {
      if (mounted) {
        // mounted 속성 확인
        setState(() {
          _dotCount = (_dotCount + 1) % 4;
          _loadingText = '포트폴리오 생성 중${'.' * _dotCount}';
        });
      }
    });

    // PortfolioProvider의 포트폴리오 생성 메서드 호출
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // SurveyProvider와 PortfolioProvider 가져오기
      final surveyProvider =
          Provider.of<SurveyProvider>(context, listen: false);
      final portfolioProvider =
          Provider.of<PortfolioProvider>(context, listen: false);

      // SurveyProvider 데이터 가져오기
      final surveyAnswers = surveyProvider.surveyAnswers; // 설문 응답 데이터
      final companyValuesRanks = surveyProvider.companyValuesRanks; // 기업 가치 순위
      final numberOfCompanies = surveyProvider.numberOfCompanies; // 투자할 회사 수
      final investmentAmount = surveyProvider.investmentAmount; // 투자 금액

      // 데이터를 JSON 형태로 인코딩
      final Map<String, dynamic> requestData = {
        'surveyAnswers': surveyAnswers, // 설문 응답 데이터
        'companyValuesRanks': companyValuesRanks, // 기업 가치 순위
        'numberOfCompanies': numberOfCompanies, // 투자할 회사 수
        'investmentAmount': investmentAmount, // 투자 금액
      };

      try {
        // SurveyProvider 데이터를 가져와서 PortfolioProvider에 전달
        final createdPortfolio = await portfolioProvider.createPortfolio(
          requestData: requestData,
        ); // 매핑된 데이터 그대로 전달

        // 포트폴리오 생성 성공 시 포트폴리오 페이지로 이동
        if (mounted) {
          _timer!.cancel(); // 타이머 취소
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  PortfolioDetailPage(portfolio: createdPortfolio),
            ),
          );
        }
      } catch (e) {
        if (mounted) {
          // 포트폴리오 생성 실패 시 표시할 텍스트 업데이트
          setState(() {
            _loadingText = '포트폴리오 생성 실패'; // 실패 메시지로 텍스트 변경
          });
        }
      }
    });
  }

  @override
  void dispose() {
    if (_timer != null && _timer!.isActive) {
      _timer!.cancel(); // 타이머가 활성화되어 있으면 취소
    }
    _timer = null; // 타이머 초기화
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              strokeWidth: 10.0,
              color: Colors.lightBlue[600],
            ),
            const SizedBox(height: 26),
            Text(
              _loadingText,
              style: const TextStyle(
                fontSize: 26,
                fontFamily: '.SF Pro Text',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
