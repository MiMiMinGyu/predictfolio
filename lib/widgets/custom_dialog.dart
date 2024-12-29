import 'package:flutter/material.dart';

class CustomDialog {
  static void show(
    BuildContext context, {
    required String title, // 다이얼로그 제목
    required String message, // 다이얼로그 메시지
    String buttonText = '확인', // 버튼 텍스트, 기본값: "확인"
  }) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true, // 다이얼로그 바깥 클릭 시 닫힘
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: Colors.black54, // 배경색을 어둡게 설정
      transitionDuration: const Duration(milliseconds: 200), // 애니메이션 시간
      pageBuilder: (BuildContext buildContext, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return Align(
          alignment: const Alignment(0, -0.3), // 다이얼로그 위치 조정
          child: Container(
            padding: const EdgeInsets.all(20), // 다이얼로그 내부 여백
            margin: const EdgeInsets.symmetric(horizontal: 20), // 다이얼로그 외부 여백
            decoration: BoxDecoration(
              color: Colors.white, // 다이얼로그 배경색
              borderRadius: BorderRadius.circular(15), // 모서리 둥글게
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min, // 다이얼로그 크기 최소화
              crossAxisAlignment: CrossAxisAlignment.start, // 왼쪽 정렬
              children: [
                Text(
                  title, // 다이얼로그 제목
                  style: const TextStyle(
                    fontFamily: '.SF Pro Text', // iOS 스타일 폰트
                    fontSize: 20, // 글자 크기
                    fontWeight: FontWeight.bold, // 글자 두께
                    color: Colors.black, // 글자 색상
                    decoration: TextDecoration.none, // 밑줄 제거
                  ),
                ),
                const SizedBox(height: 18), // 제목과 메시지 간격
                Text(
                  message, // 다이얼로그 메시지
                  style: const TextStyle(
                    fontFamily: '.SF Pro Text', // iOS 스타일 폰트
                    fontSize: 18, // 글자 크기
                    fontWeight: FontWeight.normal, // 글자 두께
                    color: Colors.black, // 글자 색상
                    decoration: TextDecoration.none, // 밑줄 제거
                  ),
                ),
                const SizedBox(height: 20), // 메시지와 버튼 간격
                Align(
                  alignment: Alignment.centerRight, // 버튼 오른쪽 정렬
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // 다이얼로그 닫기
                    },
                    child: Text(
                      buttonText, // 버튼 텍스트
                      style: const TextStyle(
                        fontFamily: '.SF Pro Text', // iOS 스타일 폰트
                        fontSize: 16, // 글자 크기
                        color: Colors.blue, // 버튼 색상
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
