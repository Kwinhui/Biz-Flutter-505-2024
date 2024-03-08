import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';

// 받을때는 statefulWidget이 받음
class SettingPage extends StatefulWidget {
  // onchange 라는 함수를 반드시 전달받겠다.
  // required this.onChange
  // main 으로부터 onChange 라는 props를 반드시 받도록 선언하기
  const SettingPage(
      {super.key, required this.onChange, required this.workTimer});

  // 밑의 state에게 전달하기위해 한번더 세팅
  // State 에서 onChange 를 사용할수 있도록 선언하기
  // onChange 라는 props 는 함수이다(Functuin).
  // 또한 문자열형 매개변수를 통하여 값을 전달할 수 있다.
  // onChange 함수를 사용하는 곳에서 문자열을 전달하면
  // 그 문자열이 main 으로 전달된다.
  final Function(String) onChange;
  final int workTimer;
  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  // id를 붙이기 위한 도구(controller)
  final workTimeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // 설정탭에 들어가면 현재 설정된 값을 보여줌
    workTimeController.text = widget.workTimer.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SettingsList(
        sections: [
          SettingsSection(
            title: const Text("타이머설정"),
            tiles: [
              SettingsTile(
                leading: const Icon(Icons.timer_outlined),
                title: TextField(
                  /// TextField 에 id(ref) 부착하기
                  controller: workTimeController,
                  // 사용하려면 widget. 을 써줌
                  // 키보드로 입력받은 문자열을 value에 담아 전달해서 main한테 감
                  /// StateFul 에서 선언한 props 를 사용할때는
                  /// widget.Props 형태로 사용한다.
                  /// StateFul 에서 선언한 onChange 함수를
                  /// widget.onChange() 라는 형식으로 사용한다.
                  /// 만약 이 함수에 전달할 값이 필요 없다면
                  /// onChange : widget.onChange 형식으로 사용하면 된다.
                  /// 하지만 현재 widget.onChange 함수는 문자열형 매개변수를
                  /// 필요로 하도록 선언되어 있다 : final Function(String) onChange

                  /// 필요한 값을 전달하기 위하여 함수 선언형으로 event 핸들러를
                  /// 사용한다.
                  onChanged: (value) => widget.onChange(value),
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    // 값을 입력하면 main에서 받아서
                    labelText: "일할시간",
                    contentPadding: EdgeInsets.all(0),
                    hintText: "타이머 작동시간을 입력하세요",
                    hintStyle: TextStyle(color: Colors.blue),
                  ),
                ),
              ),
              SettingsTile(
                leading: const Icon(Icons.timer_outlined),
                title: const TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "휴식시간",
                  ),
                ),
              ),
              SettingsTile(
                leading: const Icon(Icons.timer_outlined),
                title: const TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "반복횟수",
                  ),
                ),
              ),
              SettingsTile.switchTile(
                initialValue: true,
                onToggle: (value) => {},
                title: const Text("알람"),
              )
            ],
          ),
        ],
      ),
    );
  }
}
