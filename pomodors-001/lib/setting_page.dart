import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';

// 받을때는 statefulWidget이 받음
class SettingPage extends StatefulWidget {
  // onchange 라는 함수를 반드시 전달받겠다.
  const SettingPage({super.key, required this.onChange});
  // 밑의 state에게 전달하기위해 한번더 세팅
  final Function(String) onChange;

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
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
                  // 사용하려면 widget. 을 써줌
                  // 키보드로 입력받은 문자열을 value에 담아 전달해서 main한테 감
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
