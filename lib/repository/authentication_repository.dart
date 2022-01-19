import 'package:covid19/model/model_export.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class UserRepository {

  final String userTable = "userTable";
  final String id = "id";
  final String name = "name";
  final String email = "email";
  final String password = "password";

  Future<Database> initializeDB() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, "users.db");

    return openDatabase(path, version: 1,
        onCreate: (Database database, int newerVersion) async {
          await database.execute(
              "CREATE TABLE $userTable($id INTEGER PRIMARY KEY, $name TEXT, $email TEXT, $password TEXT)"
          );
        });
  }

  Future<int> save(User user) async {
    final Database database = await initializeDB();
    return await database.insert(userTable, user.toMap());
  }

  Future<List<User>> fetchAll() async {
    final Database database = await initializeDB();
    final List<Map<String, Object?>> query = await database.query(
        userTable,
        columns: [id, name, email, password]);
    List<User> users = query.map((element) => User.fromMap(element)).toList();
    return users;
  }

  Future<User?> findById(int userId) async {
    final Database database = await initializeDB();
    List<Map> maps = await database.query(
        userTable,
        columns: [id, name, email, password],
        where: "$id = ?",
        whereArgs: [userId]
    );

    if(maps.isNotEmpty) {
      return User.fromMap(maps.first);
    } else {
      return null;
    }
  }

  Future<int> delete(int userId) async {
    final Database database = await initializeDB();
    int x = await database.delete(
        userTable,
        where: "$id = ?",
        whereArgs: [userId]
    );
    return x;
  }

  Future<int> update(User user) async {
    final Database database = await initializeDB();
    return await database.update(
        userTable,
        user.toMap(),
        where: "$id = ?",
        whereArgs: [user.id]
    );
  }

  Future<int?> getSize() async {
    final Database database = await initializeDB();
    return Sqflite.firstIntValue(await database.rawQuery("select count(*) from $userTable"));
  }

}