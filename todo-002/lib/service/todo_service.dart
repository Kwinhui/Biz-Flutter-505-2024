// ignore_for_file: constant_identifier_names, unused_field
// 이름이 잘못됐더라도 경고x ctrl + .눌러서 2번째
import 'package:sqflite/sqflite.dart';

const TBL_TODO = "tbl_todolist";
const createTodoTable = """
  CREATE TABLE $TBL_TODO (
    id TEXT,
    sdate TEXT,
    stime TEXT,
    edate TEXT,
    etime TEXT,
    complete INTEGER


  )
""";

class TodoService {
  late Database _database;

  onCreateTable(db, version) async {
    return db.execute(createTodoTable);
  }

  onUpgradeTable(db, oldVersion, newVersion) async {
    final batch = db.batch();

    // 기존에 있는 테이블을 지우고 새로운 테이블 생성
    await batch.execute("DROP TABLE $TBL_TODO");
    await batch.execute(createTodoTable);
    // 지우기를 완료했으면 커밋
    await batch.commit();
  }
}
