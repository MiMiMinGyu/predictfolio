import 'package:flutter/material.dart';
import 'package:predictfolio_app/widgets/custom_app_bar.dart';
import 'package:provider/provider.dart';
import 'package:predictfolio_app/providers/survey_provider.dart';
import 'dart:developer';
import 'survey_page5.dart'; // 다음 페이지 SurveyPage5로 연결

// SurveyPage4 위젯 정의
class SurveyPage4 extends StatefulWidget {
  const SurveyPage4({super.key}); // SurveyPage4에서는 데이터를 Provider로 관리

  @override
  _SurveyPage4State createState() => _SurveyPage4State(); // 상태 관리 클래스 생성
}

// SurveyPage4의 상태 클래스
class _SurveyPage4State extends State<SurveyPage4> {
  // 기업의 가치 목록과 순위 데이터를 저장할 리스트
  final List<Map<String, String>> _companyValues = [
    {
      'title': 'PER (주가수익비율)',
      'description': '주가를 주당순이익으로 나눈 값, 낮을수록 수익성이 높음을 의미.'
    },
    {
      'title': 'PBR (주가순자산비율)',
      'description': '주가를 주당순자산으로 나눈 값, 낮을수록 기업의 자산 대비 주가가 저평가되었음을 의미.'
    },
    {'title': 'ROE (자기자본이익률)', 'description': '자기자본 대비 순이익의 비율, 기업의 수익성을 의미.'},
    {
      'title': 'dividendYield (배당수익률)',
      'description': '주가 대비 배당금의 비율, 투자 수익성을 판단하는 데 사용.'
    },
    {
      'title': 'dividendPayout (배당성향)',
      'description': '순이익 중 배당금으로 지급되는 비율, 주주의 이익 환원 정도를 의미.'
    },
  ];

  Map<String, int> _companyValuesRanks = {}; // 순위 정보를 저장할 리스트

  @override
  void initState() {
    super.initState(); // 초기화
    _updateValueRanks(); // 초기 순위를 설정
  }

  @override
  Widget build(BuildContext context) {
    final surveyProvider =
        Provider.of<SurveyProvider>(context); // Provider에서 상태를 가져옴

    return Scaffold(
      backgroundColor: Colors.white, // 페이지 배경색을 흰색으로 설정
      appBar: const CustomAppBar(
        showBackButton: true, // 뒤로가기 버튼 표시
        showMenuButton: true, // 메뉴 버튼 표시
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: 16.0, vertical: 20.0), // 여백 설정
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // 왼쪽 정렬
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 20.0, top: 10.0), // 질문 문구의 여백 설정
              child: Text(
                '가치 있는 투자 요소를\n중요도 순으로 정렬하세요.',
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: ReorderableListView(
                proxyDecorator:
                    (Widget child, int index, Animation<double> animation) {
                  return Material(
                    color: Colors.transparent,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: child, // 드래그 중인 아이템 표시
                    ),
                  );
                },
                onReorder: (int oldIndex, int newIndex) {
                  setState(() {
                    if (newIndex > oldIndex) newIndex -= 1; // 새로운 위치 계산
                    final companyValue =
                        _companyValues.removeAt(oldIndex); // 기존 위치에서 제거
                    _companyValues.insert(newIndex, companyValue); // 새로운 위치에 삽입
                    _updateValueRanks(); // 순위 정보 업데이트
                  });
                },
                children: _companyValues.map((companyValue) {
                  return Container(
                    key: ValueKey(companyValue['title']), // 고유 키를 title로 설정
                    margin: const EdgeInsets.symmetric(vertical: 10.0),
                    padding: const EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(12.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          spreadRadius: 1,
                          blurRadius: 5,
                        ),
                      ],
                    ),
                    child: ListTile(
                      title: Text.rich(
                        TextSpan(
                          text:
                              companyValue['title']!.split(' (')[0], // 괄호 이전 부분
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                          children: [
                            TextSpan(
                              text:
                                  ' (${companyValue['title']!.split(' (')[1]}', // 괄호와 내용
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      subtitle: Text(
                        companyValue['description']!,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[700],
                        ),
                      ),
                      trailing: const Icon(Icons.drag_handle), // 드래그 아이콘
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Container(
        alignment: Alignment.bottomRight,
        margin: const EdgeInsets.only(right: 0.0),
        child: ElevatedButton(
          onPressed: () {
            // SurveyProvider에 정렬된 데이터를 저장하고 다음 페이지로 이동
            surveyProvider.setCompanyValuesRanks(_companyValuesRanks);

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const SurveyPage5(), // 다음 SurveyPage5로 이동
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            elevation: 5,
          ),
          child: const Text(
            '다음 페이지',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              fontFamily: '.SF Pro Text',
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }

  // 순위 정보를 업데이트하는 메서드
  void _updateValueRanks() {
    _companyValuesRanks = {
      for (var i = 0; i < _companyValues.length; i++)
        _companyValues[i]['title']!.split(' (')[0] == 'PER' ||
                _companyValues[i]['title']!.split(' (')[0] == 'PBR' ||
                _companyValues[i]['title']!.split(' (')[0] == 'ROE'
            ? _companyValues[i]['title']!.split(' (')[0].toLowerCase()
            : _companyValues[i]['title']!.split(' (')[0]: i + 1
    };
    log('Updated ranks: $_companyValuesRanks'); // 로그에 현재 순위 출력
  }
}
