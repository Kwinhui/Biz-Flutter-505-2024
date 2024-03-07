import 'package:flutter/material.dart';
import 'package:timer/dash_page.dart';
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
  int wantTimer = 20;

  void onChangeSetting(String value) {
    if (value.length > 3) {
      // 3글자가 넘어가면 setting에서 받은걸 snackbar 표시
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(value)));
    }
  }

  /// flutter(dart) 에서 변수를 선언할 때 final, const 키워드가 있으면
  /// 변수의 type 을 명시하지 않아도 된다
  /// 단, 이때 반드시 값이 초기화 되어야 한다.
  ///
  /// 자료형이 PageController tpye의 변수 선언
  /// HTML tag 에 id 를 적용하는 것처럼 flutter 에서 화면에 표시되는
  /// component 에 id 를 부착하기 위해 선언하는 변수
  final _pageController = PageController(initialPage: 0);
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
          controller: _pageController,
          scrollDirection: Axis.horizontal,
          onPageChanged: (value) => setState(() => _pageIndex = value),
          children: [
            const HomePage(),
            const DashPage(),
            SettingPage(
              // settingpage에 onChangeSetting을 onChange 라는 이름으로 보내줌
              onChange: onChangeSetting,
            ),
          ],
        ),

        bottomNavigationBar: BottomNavigationBar(
          // 현재 페이지가 어디인지 하단 아이콘에 알려줌
          currentIndex: _pageIndex,
          // icon에 따라 value 값이 정해지고 _pageIndex에 저장이됨
          onTap: (value) {
            _pageIndex = value;
            _pageController.animateToPage(
              value,
              duration: const Duration(milliseconds: 500),
              curve: Curves.ease,
            );
            setState(() => {});
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.dashboard_sharp),
              label: "DashBoard",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: "setting",
            )
          ],
        ),
      ),
    );
  }
}
