// Data class
// Java 의 DTO(VO) 클래스와 비슷한 역할을 수행하는 클래스
//

class TodoDto {
  // 데이터 클래스에 선언된 변수들
  // 속성, 필드, 멤버 변수
  String id;
  String sdate;
  String edate;
  String content;

  // 클래스를 객체로 생성할때 complete 변수값은
  // 필수로 할당하지 않겠다.
  // 생성자에서 이 필드 변수는 required 키워드를 제거하고 타입에 ? 를 붙인다
  bool? complete;

  // Todo 클래스를 사용하여 객체(인스턴스)를 만들때
  // 모든 필드변수의 값을 필수로 지정해야한다.
  TodoDto({
    // 기본적으로 값을 받겠다
    required this.id,
    required this.sdate,
    required this.edate,
    required this.content,
    this.complete,
  });
  // 변수에 들어있는 값을 json으로 바꿔줌
  /// Todo 객체의 각 필드에 저장된 값을 모두 모아서
  /// Map type 의 변수로 변환하는 함수
  /// Object : 모든 type 의 변수
  /// 필드에 저장된 값을 Map 으로 변환하여 return 하는데,
  /// 필드의 데이터 타입이 String, boolean 등이 섞여있기 때문에
  /// Object type 으로 변환한다.
  Map<String, Object?> toMap() {
    // complete 의 type이 String 이였다면
    // Map<String, String?> toMap() { 으로 적어도 됨

    return {
      "id": id,
      "sdate": sdate,
      "edate": edate,
      "content": content,
      "complete": complete,
    };
  }
}
