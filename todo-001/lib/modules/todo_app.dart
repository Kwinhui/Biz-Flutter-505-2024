import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo/models/todo.dart';

class TodoApp extends StatefulWidget {
  const TodoApp({super.key});

  @override
  State<TodoApp> createState() => _TodoAppState();
}

class _TodoAppState extends State<TodoApp> {
  Todo getTodo(String content) {
    return Todo(
      sdate: DateFormat("yyyy-MM-dd").format(DateTime.now()),
      stime: DateFormat("HH:mm:ss").format(DateTime.now()),
      content: content,
      complete: false,
    );
  }

  List<Todo> todoList = [];

  @override
  void initState() {
    super.initState();
    // todoList.add(getTodo("Start"));
    // todoList.add(getTodo("Second"));
    // todoList.add(getTodo("Third"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.blue,
          leading: Image.asset(
            "assets/user2.png",
            fit: BoxFit.fill,
          ),
          title: const Text("TODO"),
          actions: [
            IconButton(
              onPressed: _showTodoInputDialog,
              icon: const Icon(Icons.add_alarm),
            ),
            IconButton(
              onPressed: () => {_showTodoInputDialog()},
              icon: const Icon(Icons.add_alarm),
            ),
            IconButton(
              onPressed: () => {_showTodoInputDialog()},
              icon: const Icon(Icons.add_alarm),
            ),
          ]),

      /// 리스트뷰를 화면에 보여주기위해 bulider가 만들어줌
      body: ListView.builder(
        /// TodoList가 변화가 되는지 확인
        itemCount: todoList.length,
        itemBuilder: (context, index) {
          /// Dismissible == swipe
          /// 요소를 왼쪽, 오른쪽으로 드래그했을때 화면에서 사라짐
          /// 요소가 삭제되는건 아니고 가리는것
          return Dismissible(
              key: UniqueKey(),
              background: Container(
                margin: const EdgeInsets.all(8),
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                color: Colors.green,
                alignment: Alignment.centerLeft,
                child: const Icon(
                  Icons.save_alt_sharp,
                  size: 36,
                  color: Colors.white,
                ),
              ),
              secondaryBackground: Container(
                margin: const EdgeInsets.all(8),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                color: Colors.red,
                alignment: Alignment.centerRight,
                child: const Icon(
                  Icons.delete_outline,
                  size: 36,
                  color: Colors.white,
                ),
              ),
              child: Material(
                child: InkWell(
                  onTap: () => {},
                  // 길게 클릭했을때
                  highlightColor: Colors.red.withOpacity(0.3),
                  // 살짝 클릭했을때
                  splashColor: Colors.blueAccent.withOpacity(0.3),
                  child: ListTile(
                    /// 한개씩의 리스트를 보여줌
                    title: Row(
                      children: [
                        Column(
                          children: [
                            Text(
                              todoList[index].sdate,
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                            Text(
                              todoList[index].stime,
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15.0),
                            child: Text(todoList[index].content,
                                style: const TextStyle(
                                  fontSize: 20,
                                  color: Colors.blue,
                                )),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),

              /// 사라지기 전에 실행할 Event
              confirmDismiss: (direction) {
                if (direction == DismissDirection.endToStart) {
                  return showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text("삭제할까요?"),
                        actions: [
                          ElevatedButton(
                              onPressed: () => Navigator.of(context).pop(true),
                              child: const Text("예")),
                          ElevatedButton(
                              onPressed: () => Navigator.of(context).pop(false),
                              child: const Text("취소"))
                        ],
                      );
                    },
                  );
                } else {
                  return Future.value(false);
                }
              },

              /// 사라진 후에 실행할 Event
              onDismissed: (direction) => {
                    if (direction == DismissDirection.endToStart)
                      {
                        setState(() {
                          todoList.removeAt(index);
                        })
                      }
                  });
        },
      ),
    );
  }

  Future<void> _showTodoInputDialog() {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("할일 등록"),
          actions: [
            _todoInputBox(context),
          ],
        );
      },
    );
  }

  /// Expanded Widget
  /// Column, Row 등으로 Widget 을 감싸면, content 가 없는 경우
  /// Widget 이 화면에서 사라져버리는 경우가 있다.
  /// 이때는 그 Widget 을 Expanded Widget 으로 감싸주면 해결된다.
  Widget _todoInputBox(BuildContext context) {
    return Padding(
      // 패딩을 주는 박스 테두리를 8.0만큼 들여쓰기해라
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  textInputAction: TextInputAction.go,
                  decoration: const InputDecoration(hintText: "할일을 입력해 주세요"),
                  onSubmitted: (value) {
                    setState(() {
                      /// onsubmitted이 실행되면 value 값이 담겨있고
                      /// getTodo를 이용해 todoList에 value 값 추가
                      todoList.add(getTodo(value));
                    });

                    // SnackBar 를 띄우기위해 snackBar 객체(변수)선언
                    // 서브밋이 발생됐을때
                    SnackBar snackBar = const SnackBar(
                      content: Text("할일이 등록됨"),
                    );
                    // ScaffoldMessenger 에게 sncakBar 를 표시해줘 라고 요청
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    // Alert Dialog 를 닫아라
                    Navigator.of(context).pop();
                  },
                ),
              ),
              IconButton(
                  onPressed: () => {},
                  icon: const Icon(
                    Icons.send_outlined,
                  ))
            ],
          ),
        ],
      ),
    );
  }
} // todo state end

