import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:predictfolio_app/providers/portfolio_provider.dart';
import 'package:predictfolio_app/models/portfolio.dart';
import 'package:predictfolio_app/main.dart'; // 메인 페이지 경로
import 'portfolio_detail_page.dart';

class PortfolioPage extends StatelessWidget {
  const PortfolioPage({super.key});

  @override
  Widget build(BuildContext context) {
    // PortfolioProvider에서 포트폴리오 목록을 가져옴
    final portfolioProvider = Provider.of<PortfolioProvider>(context);
    final List<Portfolio> portfolios = portfolioProvider.portfolios;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Text('<', style: TextStyle(fontSize: 24)),
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const MainPage()),
              (route) => false,
            );
          },
        ),
        title: const Text(
          '나의 포트폴리오',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: '.SF Pro Text', // iOS 스타일 폰트
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.menu, color: Colors.black),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('메뉴 버튼이 눌렸습니다!')),
              );
            },
          ),
        ],
      ),
      body: portfolios.isEmpty
          ? const Center(
              child: Text(
                '생성된 포트폴리오가 없습니다.', // 포트폴리오가 없을 때 표시될 메시지
                style: TextStyle(
                  fontFamily: '.SF Pro Text', // iOS 스타일 폰트
                  fontSize: 18,
                ),
              ),
            )
          : Padding(
              padding: const EdgeInsets.only(top: 16.0), // 앱바와의 상단 여백
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                itemCount: portfolios.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PortfolioDetailPage(
                            portfolio: portfolios[index],
                          ),
                        ),
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 16.0),
                      padding: const EdgeInsets.all(20.0),
                      decoration: BoxDecoration(
                        color: Colors.white, // 포트폴리오 카드 배경색
                        borderRadius: BorderRadius.circular(12.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2), // 음영 색상
                            spreadRadius: 2, // 음영 확산 범위
                            blurRadius: 6, // 흐림 정도
                            offset: const Offset(0, 3), // 음영 위치
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            portfolios[index].title, // 포트폴리오 제목 표시
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              fontFamily: '.SF Pro Text', // iOS 스타일 폰트
                            ),
                          ),
                          const SizedBox(height: 10), // 제목과 설명 간 간격
                          Text(
                            portfolios[index].description, // 포트폴리오 설명 표시
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black54,
                              fontFamily: '.SF Pro Text', // iOS 스타일 폰트
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }
}
