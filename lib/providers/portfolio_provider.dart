import 'package:flutter/material.dart';
import '../models/portfolio.dart'; // 포트폴리오 모델 import
import 'dart:developer'; // 디버깅용 log 함수 import
import 'package:http/http.dart' as http; // HTTP 요청 패키지 import
import 'dart:convert'; // JSON 인코딩 및 디코딩 패키지 import

class PortfolioProvider with ChangeNotifier {
  final List<Portfolio> _portfolios = []; // 생성된 포트폴리오 리스트

  // Getter: 포트폴리오 리스트 반환
  List<Portfolio> get portfolios => _portfolios;

  /// 설문 데이터를 기반으로 포트폴리오 생성 요청
  Future<Portfolio> createPortfolio({
    required Map<String, dynamic> requestData, // JSON 데이터 전체를 전달받음
  }) async {
    const String baseUrl = 'http://10.0.2.2:3000'; // 로컬 API URL
    // 'https://port-0-nodejs-code-m3n1flsr1f4f9ad0.sel4.cloudtype.app'; // 서버 API URL
    final url = Uri.parse('$baseUrl/api/create-portfolio'); // 포트폴리오 생성 API URL
    final headers = {"Content-Type": "application/json"}; // 요청 헤더

    try {
      log('POST 요청 데이터: $requestData', name: 'PortfolioProvider');
      final String jsonBody = jsonEncode(requestData);
      final investmentAmount = requestData['investmentAmount'];
      final numberOfCompanies = requestData['numberOfCompanies'];

      final response = await http
          .post(url, headers: headers, body: jsonBody)
          .timeout(const Duration(seconds: 15)); // 타임아웃 설정

      if (response.statusCode == 200) {
        log('POST 성공: ${response.body}', name: 'PortfolioProvider');
        final responseData = jsonDecode(response.body);
        final traitsData = responseData['traits'];
        final traits = Traits(
          profit: traitsData['profit'] as double,
          analysis: traitsData['analysis'] as double,
          safety: traitsData['safety'] as double,
          obsession: traitsData['obsession'] as double,
        );
        final dominantTrait = getDominantTrait(traits);
        log('dominantTrait: $dominantTrait');
        final stockPurchaseDetails = responseData['stockPurchaseDetails'] ?? [];

        // 포트폴리오 객체 생성 및 저장
        final portfolio = Portfolio(
          title: '새 포트폴리오',
          description:
              '$dominantTrait 성향 - $investmentAmount 만큼 $numberOfCompanies개 기업에 투자',
          stockPurchaseDetails: (stockPurchaseDetails as List<dynamic>)
              .map((item) => StockPurchaseDetail(
                    stock: item['stock'],
                    price: item['price'],
                    shares: item['shares'],
                    totalCost: item['totalCost'],
                  ))
              .toList(),
          traits: traits,
        );

        _portfolios.add(portfolio); // 포트폴리오 리스트에 추가
        notifyListeners(); // 상태 변경 알림
        log('포트폴리오 생성 성공: $portfolio');

        return portfolio;
      } else {
        // 실패 응답 처리
        log('POST 요청 실패: 상태 코드: ${response.statusCode}',
            name: 'PortfolioProvider');
        throw Exception('포트폴리오 생성 실패. 상태 코드: ${response.statusCode}');
      }
    } catch (e) {
      // 오류 처리
      log('Error creating portfolio: $e', level: 1);
      throw Exception('포트폴리오 생성 중 오류가 발생했습니다.');
    }
  }
}

String getDominantTrait(Traits traits) {
  final Map<String, dynamic> traitValues = {
    'profit': traits.profit,
    'analysis': traits.analysis,
    'safety': traits.safety,
    'obsession': traits.obsession,
  };

  // 가장 높은 값을 가진 특성을 찾음
  final dominantTrait = traitValues.entries.reduce(
    (a, b) => a.value > b.value ? a : b,
  );

  return dominantTrait.key; // 가장 높은 값의 키 반환
}
