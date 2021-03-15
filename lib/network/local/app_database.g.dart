// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String name;

  final List<Migration> _migrations = [];

  Callback _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String> listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  MediaDao _mediaDaoInstance;

  Future<sqflite.Database> open(String path, List<Migration> migrations,
      [Callback callback]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Media` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `title` TEXT, `playbackUrl` TEXT)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  MediaDao get mediaDao {
    return _mediaDaoInstance ??= _$MediaDao(database, changeListener);
  }
}

class _$MediaDao extends MediaDao {
  _$MediaDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database, changeListener),
        _mediaInsertionAdapter = InsertionAdapter(
            database,
            'Media',
            (Media item) => <String, dynamic>{
                  'id': item.id,
                  'title': item.title,
                  'playbackUrl': item.playbackUrl
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Media> _mediaInsertionAdapter;

  @override
  Future<List<Media>> findAll() async {
    return _queryAdapter.queryList('select * from Media',
        mapper: (Map<String, dynamic> row) => Media(row['id'] as int,
            row['title'] as String, row['playbackUrl'] as String));
  }

  @override
  Stream<Media> findMediaById(int id) {
    return _queryAdapter.queryStream('SELECT * FROM Media WHERE id = ?',
        arguments: <dynamic>[id],
        queryableName: 'Media',
        isView: false,
        mapper: (Map<String, dynamic> row) => Media(row['id'] as int,
            row['title'] as String, row['playbackUrl'] as String));
  }

  @override
  Future<Media> findLastMedia() async {
    return _queryAdapter.query('Select * from Media order by id desc limit 1',
        mapper: (Map<String, dynamic> row) => Media(row['id'] as int,
            row['title'] as String, row['playbackUrl'] as String));
  }

  @override
  Future<void> insertMedia(Media media) async {
    await _mediaInsertionAdapter.insert(media, OnConflictStrategy.abort);
  }
}
