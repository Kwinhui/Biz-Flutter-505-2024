import 'package:flutter/material.dart';

void main() {
  runApp(const Todo());
}

class Todo extends StatelessWidget {
  const Todo({super.key});
  // super.key - App class의 생성자
  // statelessWidget을 상속을 받았기때문에 super.key를 사용

  // build는 StatelessWidget 에 들어있는 함수
  // 재정의해서 사용
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "Todo List",
      debugShowCheckedModeBanner: false,
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "TODO List",
        ),
        backgroundColor: Colors.deepPurple[200],
      ),
      body: const Center(
        child: Text(
          "안녕하세요",
          style: TextStyle(fontSize: 40),
        ),
      ),
    );
  }
}
