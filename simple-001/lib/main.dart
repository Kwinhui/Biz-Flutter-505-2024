import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

// statelesswidget 클래스
class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      // materialapp과 homepage 연결함
      home: HomePage(),
    );
  }
}

// body 작성하는 부분은 보통 statefulwidget 에서 함
// statefulwidget 클래스
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

// statefulwidget 에서는 state가 항상 따라다님
class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Simple",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.blue,
        ),
        // scaffold 는 body부분에서 다른 app과 연결한다
        body: const AppBody(),
        floatingActionButton: actionButton(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat);
  }

  /// context : 현재 보고있는 화면(App)
  /// 기본 Widget 이 아닌 Alert 등을 띄울때는 어떤 context 를 대상으로
  /// 실행할 것인지를 명시해 주어야 한다.
  /// flutter 에서는 context 라는 대상이 많이 나온다.
  Future<void> _showDialog() async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          // title 필수 나머진 선택
          title: const Text("안녕"),
          content: const Text("반갑습니다"),
          actions: [
            // 함수에는 const 가 못붙음
            TextButton(
                // 현재 alert popup 창 닫기
                onPressed: () => Navigator.pop(context, "취소"),
                child: const Text("취소")),

            TextButton(
                onPressed: () => Navigator.pop(context, "확인"),
                child: const Text("확인")),
          ],
        );
      },
    );
  }

  // Extract Method : 별도의 함수로
  FloatingActionButton actionButton() {
    return FloatingActionButton.extended(
      onPressed: () => {_showDialog()},
      label: const Text("click"),
      isExtended: true,
      icon: const Icon(
        Icons.add,
        size: 30,
      ),
      foregroundColor: Colors.white,
      backgroundColor: Colors.red,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 30,
    );
  }
}

// Extract Widget : 별도의 클래스로
class AppBody extends StatelessWidget {
  const AppBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "대한민국",
            style: TextStyle(fontSize: 30, color: Colors.blue),
          ),
          Text("우리나라만세"),
          Text("Republic of Korea"),
        ],
      ),
    );
  }
}
