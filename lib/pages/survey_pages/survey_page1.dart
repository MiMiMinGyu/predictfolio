import 'package:flutter/material.dart';
import 'package:predictfolio_app/widgets/custom_app_bar.dart';
import 'package:predictfolio_app/widgets/custom_dialog.dart'; // CustomDialog import
import 'package:provider/provider.dart';
import 'package:predictfolio_app/providers/survey_provider.dart';
import 'survey_page2.dart';

// 첫 번째 설문 페이지 위젯 정의
class SurveyPage1 extends StatefulWidget {
  const SurveyPage1({super.key});

  @override
  _SurveyPage1State createState() => _SurveyPage1State();
}

// SurveyPage1의 상태 클래스
class _SurveyPage1State extends State<SurveyPage1> {
  // 각 질문에 대한 응답을 저장하는 Map
  final Map<int, bool> answers = {};

  @override
  Widget build(BuildContext context) {
    // SurveyProvider를 통해 상태 관리
    final surveyProvider = Provider.of<SurveyProvider>(context);

    // 질문 리스트 정의
    const questions = [
      '손실이 예상되더라도 수익이 높은 투자를 선호한다',
      '주식시장이 떨어지면 오히려 좋은 기회라고 생각해서 주식을 더 매수한다',
      '간접투자보다 직접적인 주식을 선호한다',
      '장기적인 수익을 위해 단기적 손실을 감수하겠다',
      '나는 고수익 투자를 선호한다',
      '원금보존보다는 손실이 예상되더라도 수익이 중요하다',
      '주식이 떨어지면 주식투자를 새롭게 시작하겠다'
    ];

    return Scaffold(
      backgroundColor: Colors.white, // 페이지 배경색을 흰색으로 설정
      appBar: const CustomAppBar(
        showBackButton: true, // 뒤로가기 버튼 표시
        showMenuButton: true, // 메뉴 버튼 표시
      ),
      body: Padding(
        padding:
            const EdgeInsets.fromLTRB(16, 15, 16, 0), // 전체 여백 추가 (상단에서 20픽셀)
        child: ListView.builder(
          itemCount: questions.length, // 질문의 개수
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 10), // 질문 간 간격
              child: ListTile(
                title: Text(
                  questions[index], // 각 질문 텍스트
                  style: const TextStyle(
                    fontFamily: '.SF Pro Text', // iOS 스타일 폰트
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextButton(
                      onPressed: () {
                        // '예' 버튼 선택 처리
                        setState(() {
                          answers[index] = true; // 응답 저장
                        });
                        surveyProvider.saveAnswer(
                            index, true); // SurveyProvider에 저장
                      },
                      child: Text(
                        '예',
                        style: TextStyle(
                          fontFamily: '.SF Pro Text', // iOS 스타일 폰트
                          fontWeight: FontWeight.bold,
                          color: answers[index] == true
                              ? Colors.blue // 선택 시 파란색
                              : Colors.grey, // 선택 안 했을 시 회색
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        // '아니오' 버튼 선택 처리
                        setState(() {
                          answers[index] = false; // 응답 저장
                        });
                        surveyProvider.saveAnswer(
                            index, false); // SurveyProvider에 저장
                      },
                      child: Text(
                        '아니오',
                        style: TextStyle(
                          fontFamily: '.SF Pro Text', // iOS 스타일 폰트
                          fontWeight: FontWeight.bold,
                          color: answers[index] == false
                              ? Colors.blue // 선택 시 파란색
                              : Colors.grey, // 선택 안 했을 시 회색
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
        margin: const EdgeInsets.only(right: 0.0),
        child: ElevatedButton(
          onPressed: () {
            // 모든 질문에 답변이 있는지 확인
            if (answers.length == questions.length) {
              // 모든 질문에 응답이 있으면 다음 페이지로 이동
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SurveyPage2()),
              );
            } else {
              // CustomDialog를 사용하여 경고 다이얼로그 표시
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
              borderRadius: BorderRadius.circular(25), // 모서리를 둥글게 설정
            ),
            elevation: 5, // 버튼 그림자 효과 추가
          ),
          child: const Text(
            '다음 페이지',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              fontFamily: '.SF Pro Text', // iOS 스타일 폰트
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
