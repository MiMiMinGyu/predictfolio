import 'package:flutter/material.dart'; // Material package import
import 'package:predictfolio_app/main.dart'; // MainPage를 불러오기 위해 import

// 스플래시 화면 위젯 (잠시 로고만 보여주고 사라짐)
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // 단 한 번 호출되는 메서드
    super.initState();
    _navigateToMain(); // initState에서 메인 페이지로 이동하는 함수 호출
  }

  // 3초 후 메인 페이지로 이동
  void _navigateToMain() async {
    await Future.delayed(const Duration(
        seconds: 3)); // 3초 동안 스플래시 화면을 보여주고 MainPage로 이동 (await으로 기다림)
    if (mounted) {
      // 현재 위젯이 트리에 있는지 확인하여 Navigator 호출
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MainPage()), // 메인 페이지로 이동
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity, // 전체 화면 너비로 확장
        decoration: BoxDecoration(
          gradient: LinearGradient(
            // 그라데이션 블루 색상 배경
            begin: Alignment.center, // 그라데이션 시작 위치를 화면 중앙으로 설정
            end: Alignment.bottomCenter, // 그라데이션 끝 위치는 하단
            colors: [
              Colors.white, // 상단 흰색
              Colors.lightBlue.shade100, // 하단에 가까워질수록 light blue 색상
            ],
          ),
        ),
        child: Center(
          // Center를 사용하여 이미지가 화면 중앙에 배치되도록 설정
          child: Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).size.height *
                    0.18), // 화면 중앙보다 약간 상단에 로고 배치
            child: OverflowBox(
              maxWidth:
                  MediaQuery.of(context).size.width * 1.0, // 화면 너비의 100% 크기로 설정
              maxHeight:
                  MediaQuery.of(context).size.width * 1.0, // 화면 너비의 100% 크기로 설정
              child: Image.asset(
                'assets/Predictfolio_logo_title.png', // 사용자 정의 로고 이미지
                width: MediaQuery.of(context).size.width *
                    0.6, // 화면 너비의 60% 크기로 이미지 설정
                height: MediaQuery.of(context).size.width *
                    0.6, // 화면 너비의 60% 크기로 이미지 설정
                fit: BoxFit.contain, // 이미지 비율을 유지하며 부모 크기에 맞춤
              ),
            ),
          ),
        ),
      ),
    );
  }
}
