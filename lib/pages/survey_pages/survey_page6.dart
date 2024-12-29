import 'package:flutter/material.dart';
import 'package:predictfolio_app/widgets/custom_app_bar.dart'; // 커스텀 AppBar 위젯 import
import 'package:predictfolio_app/widgets/custom_dialog.dart'; // CustomDialog import
import 'package:provider/provider.dart'; // Provider 패키지 import
import 'package:predictfolio_app/providers/survey_provider.dart'; // SurveyProvider import
import 'package:predictfolio_app/pages/portfolio_loading_page.dart'; // PortfolioLoadingPage import

// SurveyPage6 위젯 정의
class SurveyPage6 extends StatefulWidget {
  const SurveyPage6({super.key}); // 매개변수를 더 이상 받지 않음

  @override
  _SurveyPage6State createState() => _SurveyPage6State(); // 상태 관리 클래스 생성
}

class _SurveyPage6State extends State<SurveyPage6> {
  final TextEditingController _investmentController =
      TextEditingController(); // 투자 금액 입력 컨트롤러

  @override
  void initState() {
    super.initState();
    _investmentController.text = ''; // 초기값으로 빈 문자열 설정
  }

  @override
  void dispose() {
    _investmentController.dispose(); // 컨트롤러 자원 해제
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final surveyProvider =
        Provider.of<SurveyProvider>(context); // SurveyProvider를 통해 상태 관리

    return Scaffold(
      backgroundColor: Colors.white, // 페이지 배경색을 흰색으로 설정
      appBar: const CustomAppBar(
        showBackButton: true, // 뒤로가기 버튼 표시
        showMenuButton: true, // 메뉴 버튼 표시
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: 24.0, vertical: 50.0), // 상하좌우 여백 설정
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start, // 위에서 아래로 정렬
          crossAxisAlignment: CrossAxisAlignment.center, // 텍스트를 중앙 정렬
          children: [
            const SizedBox(height: 160), // 상단 여백
            const Padding(
              padding: EdgeInsets.only(bottom: 16.0),
              child: Text(
                '얼마를 투자하고 싶으신가요?', // 질문 문구
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  fontFamily: '.SF Pro Text', // iOS 스타일 폰트
                ),
              ),
            ),
            // 투자 금액 입력 필드
            Row(
              mainAxisAlignment: MainAxisAlignment.center, // 입력 필드 중앙 정렬
              children: [
                SizedBox(
                  width: 200, // 입력 필드 너비 설정
                  child: TextField(
                    controller: _investmentController, // 입력 데이터를 제어하는 컨트롤러
                    keyboardType: TextInputType.number, // 숫자 입력 키보드
                    textAlign: TextAlign.center, // 텍스트 가운데 정렬
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(), // 외곽선 스타일
                      hintText: '금액 (원)', // 힌트 텍스트
                      hintStyle: TextStyle(
                        fontFamily: '.SF Pro Text', // iOS 스타일 폰트
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const Spacer(flex: 2), // 화면 공간을 균형 있게 분배하기 위한 Spacer
          ],
        ),
      ),

      floatingActionButton: Container(
        alignment: Alignment.bottomRight, // 오른쪽 하단 정렬
        margin: const EdgeInsets.only(right: 0.0),
        child: ElevatedButton(
          onPressed: () {
            final inputText = _investmentController.text.trim(); // 입력값에서 공백 제거
            if (inputText.isEmpty) {
              // 입력값이 없을 경우 CustomDialog를 사용해 경고 표시
              CustomDialog.show(
                context,
                title: '경고', // 다이얼로그 제목
                message: '투자 금액을 입력하세요!', // 경고 메시지
              );
              return; // 입력값이 없으면 함수 종료
            }

            // 입력값을 정수로 변환
            int investmentAmount = int.parse(inputText);

            // SurveyProvider에 투자 금액 저장
            surveyProvider.setInvestmentAmount(investmentAmount);

            // PortfolioLoadingPage로 이동
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    const PortfolioLoadingPage(), // 포트폴리오 로딩 페이지로 이동
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white, // 버튼 배경색
            padding: const EdgeInsets.symmetric(
                horizontal: 25, vertical: 15), // 버튼 내부 여백
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25), // 버튼 모서리를 둥글게 설정
            ),
            elevation: 5, // 그림자 효과
          ),
          child: const Text(
            '포트폴리오 생성', // 버튼 텍스트
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              fontFamily: '.SF Pro Text', // iOS 스타일 폰트
              color: Colors.black, // 텍스트 색상
            ),
          ),
        ),
      ),
    );
  }
}
