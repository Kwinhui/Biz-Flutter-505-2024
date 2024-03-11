import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TodoHome(),
    );
  }
}

class TodoHome extends StatefulWidget {
  const TodoHome({
    super.key,
  });

  /// State<> class 를 생성하여 화면을 그리는 객체로 만들기
  @override
  State<TodoHome> createState() => _TodoHomeState();
}

/// State<> 화면에 변화되는 변수를 사용하거나, 여러가지 interrative 한
/// 화면을 구현하는 Widget class

class _TodoHomeState extends State<TodoHome> {
  /// TextField 에 ID(refs)를 부착하기 위한 state
  final todoInputController = TextEditingController();
  String todo = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("TODO List"),
      ),
      body: const Center(
        child: Text(
          '안녕하세요',
          style: TextStyle(fontSize: 30),
        ),
      ),
      // 화면을 그렸을때 만든모양대로 유지해줘
      bottomSheet: SafeArea(
        child: Padding(
          padding:
              // padding을 bottom에만 주겠다
              EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Container(
            // 디바이스 크기를 가득채워라
            width: double.infinity,
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: TextField(
                controller: todoInputController,
                onChanged: (value) {
                  // 키보드에 입력된 todo에 value값을 입력해라
                  setState(() => todo = value);
                },
                decoration: InputDecoration(
                    hintText: "할일을 입력하세요",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),

                    // 위젯간의 간격을 주기위해
                    // 앞쪽
                    prefix: const SizedBox(
                      width: 20,
                    ),
                    // 뒤쪽
                    suffixIcon: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () => {todoInputController.clear()},
                          icon: const Icon(Icons.clear),
                        ),
                        IconButton(
                          onPressed: () {
                            // 함수가 리턴하는 값은 const 에 담을수 없음
                            // SnackBar snackbar = SnackBar(
                            var snackbar = SnackBar(content: Text(todo));
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackbar);
                            todoInputController.clear();
                          },
                          icon: const Icon(Icons.send_outlined),
                        ),
                      ],
                    )),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
