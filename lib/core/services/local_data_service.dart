import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';


abstract class LocalDataService {
  Future<void> init();
  Future<Database> get database;
  Future<void> close();
}

class LocalDataServiceImpl implements LocalDataService {
  static Database? _database;
  static const String _dbName = 'bridge_x.db';
  static const int _dbVersion = 1;

  @override
  Future<void> init() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, _dbName);

    _database = await openDatabase(
      path,
      version: _dbVersion,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  @override
  Future<Database> get database async {
    if (_database != null) return _database!;
    await init();
    return _database!;
  }

  @override
  Future<void> close() async => _database?.close();

  Future<void> _onCreate(Database db, int version) async {
    
    // Example:
    // await db.execute('''
    //   CREATE TABLE users (
    //     id TEXT PRIMARY KEY,
    //     name TEXT NOT NULL,
    //     email TEXT NOT NULL
    //   )
    // ''');
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    
  }
}
