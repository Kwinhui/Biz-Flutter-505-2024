class Todo {
  // 변수선언부
  String sdate;
  String stime;
  String content;
  bool complete;
//생성자
  /// Todo 클래스를 사용하여 데이터 객체를 만들때
  /// 반드시 4가지 변수값을 설정하라
  Todo(
      {required this.sdate,
      required this.stime,
      required this.content,
      required this.complete});
}
