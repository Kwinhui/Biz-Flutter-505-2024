import 'package:flutter/material.dart';
import 'package:timer/home_page.dart';
import 'package:timer/setting_page.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});
  // super.key - App class의 생성자
  // statelessWidget을 상속을 받았기때문에 super.key를 사용

  // build는 StatelessWidget 에 들어있는 함수
  // 재정의해서 사용
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: const MainPage(),
    );
  }
}

// 시작하는 페이지
class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _pageIndex = 1;
  @override
  Widget build(BuildContext context) {
    // 화면 전체의 layout을 고정해주는 Scaffold
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("images/tomato.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        // PageView 여러개의 페이지를 볼수있음
        // 거기에 HomePage()를 import
        body: PageView(
          scrollDirection: Axis.horizontal,
          onPageChanged: (value) => setState(() => _pageIndex = value),
          children: const [
            HomePage(),
            SettingPage(),
          ],
        ),
      ),
    );
  }
}
