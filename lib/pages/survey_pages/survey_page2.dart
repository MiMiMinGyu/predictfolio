import 'package:flutter/material.dart'; // Flutter의 UI 요소를 사용하기 위한 패키지
import 'package:predictfolio_app/widgets/custom_app_bar.dart'; // 커스텀 AppBar 위젯 import
import 'package:predictfolio_app/widgets/custom_dialog.dart'; // CustomDialog import
import 'package:provider/provider.dart'; // 상태 관리를 위한 Provider 패키지 import
import 'package:predictfolio_app/providers/survey_provider.dart'; // SurveyProvider 클래스 import
import 'survey_page3.dart'; // SurveyPage3 클래스 import

// SurveyPage2 위젯 정의 (두 번째 설문 페이지)
class SurveyPage2 extends StatefulWidget {
  const SurveyPage2({super.key}); // 기본 생성자

  @override
  _SurveyPage2State createState() => _SurveyPage2State(); // 상태 관리 객체 생성
}

// SurveyPage2의 상태 클래스 정의
class _SurveyPage2State extends State<SurveyPage2> {
  final Map<int, bool> answers = {}; // 각 질문에 대한 응답 상태를 저장하는 Map

  @override
  Widget build(BuildContext context) {
    // SurveyProvider를 사용하여 상태 관리 (Provider 패턴)
    final surveyProvider = Provider.of<SurveyProvider>(context);

    // 설문 질문 리스트
    const questions = [
      '투자정보 내용을 꼼꼼하게 확인하는 편이다',
      '정보를 최대한 수집하여 투자결정을 한다',
      '금리변동이나 환율 등 추가변동에 민감하다',
      '보유한 주식종목에 대해 자세히 알고 있다',
      '종목 선정시 기업정보 및 차트분석을 신중히 선택한다',
      '원금손실을 최소화하는 방향으로 투자한다',
      '나는 손실위험을 최소화하고 안전한 투자를 선호한다'
    ];

    return Scaffold(
      backgroundColor: Colors.white, // 배경색을 흰색으로 설정
      appBar: const CustomAppBar(
        showBackButton: true, // 뒤로가기 버튼 표시 여부
        showMenuButton: true, // 메뉴 버튼 표시 여부
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 15, 16, 0), // 페이지 여백 설정
        child: ListView.builder(
          itemCount: questions.length, // 질문 개수만큼 반복 생성
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 10), // 질문 간의 여백
              child: ListTile(
                title: Text(
                  questions[index], // 각 질문 텍스트 표시
                  style: const TextStyle(
                    fontFamily: '.SF Pro Text', // iOS 스타일 폰트 적용
                    fontSize: 18, // 글자 크기
                    fontWeight: FontWeight.w600, // 글자 두께 설정
                  ),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min, // 최소 크기만 차지하도록 설정
                  children: [
                    // '예' 버튼
                    TextButton(
                      onPressed: () {
                        setState(() {
                          answers[index] = true; // '예'를 선택하면 true로 저장
                        });
                        surveyProvider.saveAnswer(index + 7,
                            true); // SurveyProvider에 저장 (index + 7로 오프셋 적용)
                      },
                      child: Text(
                        '예', // 버튼 텍스트
                        style: TextStyle(
                          fontFamily: '.SF Pro Text', // iOS 스타일 폰트 적용
                          fontWeight: FontWeight.bold, // 글자를 굵게 설정
                          color: answers[index] == true
                              ? Colors.blue // 선택된 경우 파란색
                              : Colors.grey, // 선택되지 않은 경우 회색
                        ),
                      ),
                    ),
                    // '아니오' 버튼
                    TextButton(
                      onPressed: () {
                        setState(() {
                          answers[index] = false; // '아니오'를 선택하면 false로 저장
                        });
                        surveyProvider.saveAnswer(index + 7,
                            false); // SurveyProvider에 저장 (index + 7로 오프셋 적용)
                      },
                      child: Text(
                        '아니오', // 버튼 텍스트
                        style: TextStyle(
                          fontFamily: '.SF Pro Text', // iOS 스타일 폰트 적용
                          fontWeight: FontWeight.bold, // 글자를 굵게 설정
                          color: answers[index] == false
                              ? Colors.blue // 선택된 경우 파란색
                              : Colors.grey, // 선택되지 않은 경우 회색
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: Container(
        alignment: Alignment.bottomRight, // 오른쪽 하단에 버튼 정렬
        margin: const EdgeInsets.only(right: 0.0), // 오른쪽 여백 설정
        child: ElevatedButton(
          onPressed: () {
            // 모든 질문에 응답했는지 확인
            if (answers.length == questions.length) {
              // 모든 질문에 응답한 경우 다음 페이지로 이동
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        const SurveyPage3()), // SurveyPage3로 이동
              );
            } else {
              // 응답하지 않은 질문이 있는 경우 CustomDialog를 사용하여 경고 다이얼로그 표시
              CustomDialog.show(
                context,
                title: '경고', // 다이얼로그 제목
                message: '답변하지 않은 질문이 있습니다!', // 다이얼로그 메시지
              );
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white, // 버튼 배경색 설정
            padding: const EdgeInsets.symmetric(
                horizontal: 25, vertical: 15), // 버튼 크기 설정
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25), // 버튼 모서리를 둥글게 설정
            ),
            elevation: 5, // 버튼 그림자 효과 추가
          ),
          child: const Text(
            '다음 페이지', // 버튼 텍스트
            style: TextStyle(
              fontSize: 16, // 글자 크기
              fontWeight: FontWeight.w500, // 글자 두께
              fontFamily: '.SF Pro Text', // iOS 스타일 폰트 적용
              color: Colors.black, // 글자 색상
            ),
          ),
        ),
      ),
    );
  }
}
