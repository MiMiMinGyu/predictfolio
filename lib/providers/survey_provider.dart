// import 'dart:ffi';

import 'package:flutter/foundation.dart';

class SurveyProvider with ChangeNotifier {
  // 초기 값들
  Map<String, int> _companyValuesRanks = {}; // 기업 가치 순위 리스트
  int _numberOfCompanies = 1; // 투자 기업 수
  int _investmentAmount = 0; // 투자 금액

  // 새로운 질문 응답 저장을 위한 변수
  final Map<String, bool> _surveyAnswers = {}; // "question1": "True" 형태로 저장

  /// 새로운 응답을 저장하는 메서드
  /// "question1", "question2" 형식의 키로 저장하며 응답을 "True"/"False"로 변환
  void saveAnswer(int questionIndex, bool answer) {
    // questionIndex를 "question<ID>" 형식으로 변환
    final questionKey = "question${questionIndex + 1}";

    // 응답을 "True" 또는 "False"로 저장
    _surveyAnswers[questionKey] = answer;

    notifyListeners(); // 상태 변경 알림
  }

  /// 설문 응답 Getter: 외부에서 응답 데이터를 읽기 위한 메서드
  Map<String, bool> get surveyAnswers => _surveyAnswers;

  // Getter 메서드들
  Map<String, int> get companyValuesRanks => _companyValuesRanks;
  int get numberOfCompanies => _numberOfCompanies;
  int get investmentAmount => _investmentAmount;

  // Setter 메서드들

  /// 기업 가치 순위 리스트를 설정하는 메서드
  /// 리스트 항목에서 괄호와 그 안의 내용을 제거한 후 저장
  void setCompanyValuesRanks(Map<String, int> ranks) {
    _companyValuesRanks = ranks; // 전달받은 Map을 그대로 저장
    notifyListeners(); // 상태 변경 알림
  }

  /// 투자 기업 수를 설정하는 메서드
  void setNumberOfCompanies(int value) {
    _numberOfCompanies = value; // 투자 회사 수 설정
    notifyListeners(); // 상태 변경 알림
  }

  /// 투자 금액을 설정하는 메서드
  void setInvestmentAmount(int amount) {
    _investmentAmount = amount; // 투자 금액 설정
    notifyListeners(); // 상태 변경 알림
  }
}
