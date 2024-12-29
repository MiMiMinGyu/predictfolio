import 'package:flutter/material.dart';
import 'package:predictfolio_app/widgets/custom_app_bar.dart';
import 'package:predictfolio_app/widgets/custom_dialog.dart'; // CustomDialog import
import 'package:provider/provider.dart';
import 'package:predictfolio_app/providers/survey_provider.dart';
import 'survey_page4.dart'; // 다음 페이지 SurveyPage4로 연결

// 세 번째 설문 페이지 위젯 정의
class SurveyPage3 extends StatefulWidget {
  const SurveyPage3({super.key}); // const 키워드로 불변 위젯 정의

  @override
  _SurveyPage3State createState() => _SurveyPage3State(); // 상태 관리 클래스 생성
}

// SurveyPage3의 상태 클래스
class _SurveyPage3State extends State<SurveyPage3> {
  final Map<int, bool> answers = {}; // 각 질문에 대한 응답을 저장하는 Map

  @override
  Widget build(BuildContext context) {
    // SurveyProvider를 통해 상태 관리
    final surveyProvider = Provider.of<SurveyProvider>(context);

    // 질문 텍스트 리스트
    const questions = [
      '이익이 높더라도 투자의 위험이 크다면 선택하지 않는다',
      '투자할 수 있는 돈의 여유가 있을 때만 투자 계획을 세운다',
      '주식투자 시 가급적 종목을 분산 투자한다',
      '종목이 정해지면 미수를 내서라도 매수하는 편이다',
      '하루라도 주식 시세를 보지 않으면 다른 일을 할 수가 없다',
      '보유 주식의 손절매를 잘하는 편이다',
      '다른 투자수단(부동산, 예금, 적금)보다 주식투자를 더 선호한다'
    ];

    return Scaffold(
      backgroundColor: Colors.white, // 페이지 배경색을 흰색으로 설정
      appBar: const CustomAppBar(
        showBackButton: true, // 뒤로가기 버튼 표시
        showMenuButton: true, // 메뉴 버튼 표시
      ),

      // 설문 질문 목록을 보여주는 ListView
      body: Padding(
        padding:
            const EdgeInsets.fromLTRB(16, 15, 16, 0), // 전체 여백 추가 (상단에서 15픽셀)
        child: ListView.builder(
          itemCount: questions.length, // 질문 개수
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 10), // 질문들 간 간격
              child: ListTile(
                title: Text(
                  questions[index], // 질문 텍스트
                  style: const TextStyle(
                    fontFamily: '.SF Pro Text', // iOS 스타일 폰트
                    fontSize: 16, // 폰트 크기
                    fontWeight: FontWeight.w600, // 굵은 폰트
                  ),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min, // 최소 공간만 차지하도록 설정
                  children: [
                    TextButton(
                      onPressed: () {
                        setState(() {
                          answers[index] = true; // '예' 선택 시 true 저장
                        });
                        surveyProvider.saveAnswer(
                            index + 14, true); // SurveyProvider에 응답 저장
                      },
                      child: Text(
                        '예', // '예' 버튼 텍스트
                        style: TextStyle(
                          fontFamily: '.SF Pro Text',
                          fontWeight: FontWeight.bold, // 굵은 텍스트
                          color: answers[index] == true
                              ? Colors.blue
                              : Colors.grey, // 선택 상태에 따라 색상 변경
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          answers[index] = false; // '아니오' 선택 시 false 저장
                        });
                        surveyProvider.saveAnswer(
                            index + 14, false); // SurveyProvider에 응답 저장
                      },
                      child: Text(
                        '아니오', // '아니오' 버튼 텍스트
                        style: TextStyle(
                          fontFamily: '.SF Pro Text',
                          fontWeight: FontWeight.bold, // 굵은 텍스트
                          color: answers[index] == false
                              ? Colors.blue
                              : Colors.grey, // 선택 상태에 따라 색상 변경
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

      // 다음 페이지로 이동 버튼
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
                MaterialPageRoute(builder: (context) => const SurveyPage4()),
              );
            } else {
              // 답변이 없는 질문이 있을 때 CustomDialog를 사용하여 경고 메시지 표시
              CustomDialog.show(
                context,
                title: '경고', // 경고 메시지 제목
                message: '답변하지 않은 질문이 있습니다!', // 경고 메시지 내용
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
            elevation: 5, // 그림자 효과 추가
          ),
          child: const Text(
            '다음 페이지', // 버튼 텍스트
            style: TextStyle(
              fontSize: 16, // 텍스트 크기
              fontWeight: FontWeight.w500, // 굵기
              fontFamily: '.SF Pro Text', // 폰트 스타일
              color: Colors.black, // 텍스트 색상
            ),
          ),
        ),
      ),
    );
  }
}
