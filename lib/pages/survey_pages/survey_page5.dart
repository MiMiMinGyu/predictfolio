import 'package:flutter/material.dart';
import 'package:predictfolio_app/widgets/custom_app_bar.dart'; // 커스텀 AppBar 위젯 import
import 'package:predictfolio_app/widgets/custom_dialog.dart'; // 커스텀 다이얼로그 import
import 'package:provider/provider.dart'; // Provider 패키지 import
import 'package:predictfolio_app/providers/survey_provider.dart'; // SurveyProvider import
import 'survey_page6.dart'; // 다음 페이지 SurveyPage6로 연결

// SurveyPage5 위젯 정의
class SurveyPage5 extends StatefulWidget {
  const SurveyPage5({super.key}); // 매개변수가 필요하지 않은 생성자

  @override
  _SurveyPage5State createState() => _SurveyPage5State(); // 상태 관리 클래스 생성
}

class _SurveyPage5State extends State<SurveyPage5> {
  // 기업 수를 입력받기 위한 TextEditingController
  final TextEditingController _companiesController = TextEditingController();

  @override
  void dispose() {
    _companiesController.dispose(); // 페이지가 종료되면 TextEditingController 자원을 해제
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // SurveyProvider를 통해 상태 관리
    final surveyProvider = Provider.of<SurveyProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white, // 페이지 배경색을 흰색으로 설정
      appBar: const CustomAppBar(
        showBackButton: true, // 뒤로가기 버튼 표시
        showMenuButton: true, // 메뉴 버튼 표시
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: 24.0, vertical: 50.0), // 상하좌우 여백 설정
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // 중앙 정렬
            crossAxisAlignment: CrossAxisAlignment.center, // 텍스트 및 입력란 가운데 정렬
            mainAxisSize: MainAxisSize.min, // Column의 높이를 최소 크기로 설정
            children: [
              const Spacer(flex: 1), // 상단 공간을 확보
              const Padding(
                padding: EdgeInsets.only(bottom: 16.0), // 질문 문구 아래 여백 설정
                child: Text(
                  '투자하고 싶은 \n기업의 수를 입력하세요!',
                  textAlign: TextAlign.center, // 텍스트 가운데 정렬
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    fontFamily: '.SF Pro Text', // iOS 스타일 폰트
                  ),
                ),
              ),
              SizedBox(
                width: 150, // 텍스트 필드 너비
                child: TextField(
                  controller: _companiesController, // 사용자가 입력한 데이터를 제어
                  keyboardType: TextInputType.number, // 숫자 입력 전용 키보드
                  textAlign: TextAlign.center, // 텍스트 가운데 정렬
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(), // 외곽선 스타일 설정
                    hintText: '기업 수 (개)', // 힌트 텍스트
                    hintStyle: TextStyle(
                      fontFamily: '.SF Pro Text', // iOS 스타일 폰트
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              const Spacer(flex: 3), // 하단 공간을 확보
              const SizedBox(height: 50), // 추가 여백
            ],
          ),
        ),
      ),
      floatingActionButton: Container(
        alignment: Alignment.bottomRight, // 오른쪽 하단에 버튼 정렬
        margin: const EdgeInsets.only(right: 0.0), // 오른쪽 여백 설정
        child: ElevatedButton(
          onPressed: () {
            // 사용자가 입력한 기업 수를 가져옴
            final inputText =
                _companiesController.text.trim(); // trim은 공백 제거 기능
            if (inputText.isEmpty) {
              // 입력값이 없을 경우 CustomDialog 호출
              CustomDialog.show(
                context,
                title: '경고', // 다이얼로그 제목
                message: '투자할 기업 수를 입력하세요!', // 다이얼로그 메시지
              );
              return; // 입력값이 없으면 함수 종료
            }

            // 입력값을 정수로 변환
            int numberOfCompanies = int.parse(inputText);

            // SurveyProvider에 기업 수를 저장
            surveyProvider.setNumberOfCompanies(numberOfCompanies);

            // 다음 페이지(SurveyPage6)로 이동
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const SurveyPage6(),
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
            '다음 페이지', // 버튼 텍스트
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
