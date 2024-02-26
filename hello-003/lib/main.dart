import 'package:flutter/material.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    // 전체적인 어플의 테마
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      debugShowMaterialGrid: false,
      // 오류가 나면 const 지워버려
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  /// State<> 클래스에 선언된 변수 중 final, const 가 부착되지 않으면
  /// 이 변수는 자동으로 state 변수가 된다.
  /// setState() 라는 함수를 통하여 값을 변경하고,
  /// 변경된 변수는 필요한 곳에서 변화되어 표시된다.
  int _nums = 0;
  void clickHandler() {
    setState(() => _nums++);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "안녕하세요",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          // MainAxisAlignment 라는 시스템함수에 center라는 변수
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            Text(
              // state 변수 _nums
              "$_nums",
              style: const TextStyle(fontSize: 30),
            ),
            const Text("대한민국"),
            const Text("우리나라"),
            const Text("Republic of Korea"),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: clickHandler,
        child: const Icon(Icons.add),
      ),
    );
  }
}
