// ignore_for_file: constant_identifier_names, unused_field, unused_local_variable
// 이름이 잘못됐더라도 경고x ctrl + .눌러서 2번째
import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:toto/model/todo.dart';

const TBL_TODO = "tbl_todolist";
const createTodoTable = """
  CREATE TABLE $TBL_TODO (
    id TEXT,
    sdate TEXT,
    stime TEXT,
    edate TEXT,
    etime TEXT,
    content TEXT,
    complete INTEGER


  )
""";

class TodoService {
  late Database _database;
  // Future<Database> get database() async {
  //   _database = await
  // }

  onCreateTable(db, version) async {
    return db.execute(createTodoTable);
  }

  // initData / openDatabase 가 실행될때
  // Version 번호를 비교하여 새로운 version 번호가 있으면
  // Table 의 구조를 변경한다.
  onUpgradeTable(db, oldVersion, newVersion) async {
    debugPrint("oldVersion : $oldVersion, newVersion $newVersion");
    // newVersion이 더 크면 테이블을 지우고 새로운 테이블 생성
    // if문을 안써주면 무조건 지우고 만들어버리기때문에
    if (newVersion > oldVersion) {
      final batch = db.batch();

      // 기존에 있는 테이블을 지우고 새로운 테이블 생성
      await batch.execute("DROP TABLE $TBL_TODO");
      await batch.execute(createTodoTable);
      // 지우기를 완료했으면 커밋
      await batch.commit();
    }
  }

  // Future<Database> return type
  Future<Database> initDatabase() async {
    // 스마트 기기의 DB 저장소의 위치를 가져오는 함수
    String dbPath = await getDatabasesPath();
    // 저장소에 todo.dbf 라는 이름으로 쓰겠다
    // 경로지정이 기기마다 다르지만 join이라는 함수를 사용하면 자동으로 변환해줌
    // join 폴더1/폴더2/폴더3/todo.dbf

    // 만약 폴더1/폴더2/폴더3/todo.dbf 라는 경로를 설정할때
    // 운영체제마다 dir seperator 문자가 다르다
    // 어떤 운영체제는 슬래시(/)를 사용하고 어떤 운영체제는 역슬래시(\)를 사용한다.
    // "폴더1" + "/" + "폴더2" + "/" + "폴더3"
    // "폴더1" + "\" + "폴더2" + "\" + "폴더3"
    //
    // 이때 path.join() 함수를 사용하여 폴더를 결합하면
    // 자동으로 운영체제에 맞는 구분자(dir seperator)를 만들어준다

    String dbFile = join(dbPath, "todo.dbf");

    // db파일의 경로를 오픈 "todo.dbf"
    // 테이블이 없으면 크리에이트
    // 업그레이드가 필요하면 업그레이드
    return await openDatabase(
      dbFile,
      onCreate: onCreateTable,
      onUpgrade: onUpgradeTable,
      version: 2,
    );
  }

  // get = db를 초기화후 리턴
  // DB를 사용할수 있도록 open 하고 연결정보가 담긴 _database 변수를 초기화 한다.
  // get method : _database와 연관되는 method
  // Flutter 에서 사용하는 다소 특이한 getter method
  // 이 함수는 () 없고, 함수 이름앞에 get 키워드가 있다.
  // 이 함수이름과 연관된 로컬변수 _함수 와 같은 형식의 변수가 있어야 한다.
  Future<Database> get database async {
    _database = await initDatabase();
    return _database;
  }

  insert(Todo todo) async {
    // 괄호가 없지만 함수처럼 작동
    final db = await database;
    debugPrint("INSERT TO : ${todo.toString()}");
    var result = await db.insert(
      // TBL_TODO 에 todo.toMap() 의 json 문자를 insert해라
      TBL_TODO,
      todo.toMap(),
    );
  }

  // Future 동적 데이터에 대한 약속
  // selectAll() 함수를 호출하면 반드시 list<Todo> 데이터 타입을 return 하겠다.
  Future<List<Todo>> selectAll() async {
    // 전체 데이터 가져오기
    final db = await database;

    // final todoList = await db.query((TBL_TODO));
    final List<Map<String, dynamic>> todoList = await db.query(TBL_TODO);

    //
    // 반복하고나서 List로 바꿔라
    final result = List.generate(
      // for-each랑 비슷함
      // todoList의 개수만큼 반목
      todoList.length,
      (index) => Todo.fromMap(todoList[index]),
    );
    return result;
  }
}
