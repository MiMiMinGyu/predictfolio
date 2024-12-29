import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  // 변경되지 않는 위젯 생성
  // AppBar의 타이틀, 뒤로가기 버튼 및 메뉴 버튼 표시 여부를 조정할 수 있는 매개변수 정의
  final String title; // AppBar에 표시할 제목 텍스트
  final bool showBackButton; // 뒤로가기 버튼 표시 여부를 결정하는 플래그
  final bool showMenuButton; // 메뉴 버튼 표시 여부를 결정하는 플래그

  // 생성자: AppBar를 초기화하면서 필요한 속성을 설정
  const CustomAppBar({
    super.key, // 'key'를 super parameter로 변경 (간결)
    this.title = '', // 기본값을 빈 문자열로 설정하여 제목이 없도록 초기화
    this.showBackButton = true, // 기본적으로 뒤로가기 버튼을 표시
    this.showMenuButton = true, // 기본적으로 메뉴 버튼을 표시
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,

      title: Text(
        title, // title 매개변수에서 전달받은 텍스트를 사용
        style: const TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontFamily: '.SF Pro Text', // ios 스타일 폰트
        ),
      ),

      leading: showBackButton // showBackButton이 true일 경우에만 뒤로가기 버튼을 표시
          ? IconButton(
              icon: const Text('<', style: TextStyle(fontSize: 24)),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          : null, // showBackButton이 false이면 leading은 null이 되어 아무 것도 표시하지 않음

      actions: showMenuButton // showMenuButton이 true일 경우에만 메뉴 버튼을 표시
          ? [
              IconButton(
                icon: const Icon(Icons.menu, color: Colors.black),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('메뉴 버튼이 눌렸습니다!')),
                  );
                },
              ),
            ]
          : null, // showMenuButton이 false이면 actions은 null이 되어 메뉴 버튼이 표시되지 않음
    );
  }

  // preferredSize: AppBar의 크기를 정의, PreferredSizeWidget 인터페이스를 구현하기 위해 필요한 속성
  @override
  Size get preferredSize => const Size.fromHeight(
      kToolbarHeight); // AppBar의 높이를 기본 높이인 kToolbarHeight로 설정
}
