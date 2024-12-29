import 'package:flutter/material.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MainAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white, // 앱바 배경색 흰색 설정
      elevation: 0, // 그림자 제거
      leading: Padding(
        padding: const EdgeInsets.all(8.0), // 앱바 왼쪽 여백 8.0으로 설정
        child: Stack(
          clipBehavior: Clip.none, // Stack 밖으로 나가는 요소 허용
          children: [
            Image.asset(
              'assets/Predictfolio_logo.png', // 아이콘 대신 사용할 로고 이미지
              width: 30, // 이미지 너비 설정
              height: 30, // 이미지 높이 설정
              fit: BoxFit.contain, // 이미지가 잘 맞도록 설정
            ),
            const Positioned(
              left: 33, // Predictfolio 텍스트를 이미지 오른쪽에 배치
              top: 0.0, // 텍스트의 수직 위치 설정
              child: Stack(
                clipBehavior: Clip.none, // Predictfolio 텍스트가 바깥으로 나가도 허용
                children: [
                  Text(
                    'Predictfolio', // Predictfolio 텍스트
                    style: TextStyle(
                      fontSize: 18, // 글자 크기 18
                      fontWeight: FontWeight.w700, // 굵기 설정 (굵게)
                      fontFamily: '.SF Pro Text', // iOS 스타일 폰트 설정
                      color: Colors.black, // 텍스트 색상은 검정색
                    ),
                  ),
                  Positioned(
                    bottom: -5, // Myongji.Univ 텍스트 위치 설정 (Predictfolio 아래에 배치)
                    right: 0, // Predictfolio의 오른쪽에 위치
                    child: Text(
                      'Myongji.Univ', // 학교 이름 텍스트
                      style: TextStyle(
                        fontSize: 10, // 글자 크기 10
                        fontWeight: FontWeight.w300, // 굵기 설정 (얇게)
                        fontFamily: '.SF Pro Text', // iOS 스타일 폰트 설정
                        color: Colors.black54, // 텍스트 색상은 회색
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('메뉴 버튼이 눌렸습니다!')), // 메뉴 버튼 눌렸을 때 메시지
            );
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56.0); // AppBar의 기본 높이 설정
}
