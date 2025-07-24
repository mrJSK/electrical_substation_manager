import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../providers/organization_provider.dart';

part 'database_service.g.dart';

@riverpod
DatabaseService databaseService(DatabaseServiceRef ref) {
  final orgConfigMap = ref.watch(organizationConfigProvider);

  // Handle empty or loading state
  if (orgConfigMap.isEmpty) {
    throw Exception('Organization configuration not loaded');
  }

  // Safely extract database config from the map
  final databaseConfig = orgConfigMap['database'] as Map<String, dynamic>?;
  if (databaseConfig == null) {
    throw Exception('Database configuration not found');
  }

  final databaseType = databaseConfig['type'] as String? ?? 'firebase';
  final dbSettings = databaseConfig['config'] as Map<String, dynamic>? ?? {};

  // Use string-based switching instead of enum
  switch (databaseType.toLowerCase()) {
    case 'firebase':
      return FirebaseDatabaseService(dbSettings);
    case 'mysql':
      return MySQLDatabaseService(dbSettings);
    case 'postgresql':
      return PostgreSQLDatabaseService(dbSettings);
    case 'oracle':
      return OracleDatabaseService(dbSettings);
    case 'sqlite':
      return SQLiteDatabaseService(dbSettings);
    case 'mongodb':
      return MongoDBDatabaseService(dbSettings);
    default:
      throw Exception('Unsupported database type: $databaseType');
  }
}

// Pure dynamic database service interface
abstract class DatabaseService {
  // Core operations for substation management
  Future<List<Map<String, dynamic>>> getSubstations(String userId);
  Future<void> saveReading(Map<String, dynamic> reading);
  Future<List<Map<String, dynamic>>> getMaintenanceLogs(String substationId);

  // Dynamic operations - completely flexible
  Future<Map<String, dynamic>> executeQuery(String query,
      [Map<String, dynamic>? params]);
  Future<void> executeUpdate(String query, Map<String, dynamic> params);
  Future<List<Map<String, dynamic>>> getCustomData(
      String table, Map<String, dynamic> filters);
  Future<void> saveCustomData(String table, Map<String, dynamic> data);
  Future<void> deleteCustomData(String table, Map<String, dynamic> filters);

  // Schema-less operations for maximum flexibility
  Future<List<Map<String, dynamic>>> searchData(
      String collection, Map<String, dynamic> searchCriteria);
  Future<Map<String, dynamic>> getDataById(String collection, String id);
  Future<void> updateDataById(
      String collection, String id, Map<String, dynamic> updates);
}

// Firebase implementation - completely dynamic
class FirebaseDatabaseService implements DatabaseService {
  final Map<String, dynamic> config;

  FirebaseDatabaseService(this.config);

  @override
  Future<List<Map<String, dynamic>>> getSubstations(String userId) async {
    final collectionName =
        config['substationsCollection'] as String? ?? 'substations';
    final userFieldName = config['userField'] as String? ?? 'assignedUserId';

    // Your Firebase implementation using dynamic field names
    // Return List<Map<String, dynamic>> instead of typed objects
    return [];
  }

  @override
  Future<void> saveReading(Map<String, dynamic> reading) async {
    final collectionName =
        config['readingsCollection'] as String? ?? 'readings';
    // Save dynamic reading data to Firebase
  }

  @override
  Future<List<Map<String, dynamic>>> getMaintenanceLogs(
      String substationId) async {
    final collectionName =
        config['maintenanceCollection'] as String? ?? 'maintenance_logs';
    final substationField =
        config['substationField'] as String? ?? 'substationId';
    // Return dynamic maintenance logs
    return [];
  }

  @override
  Future<Map<String, dynamic>> executeQuery(String query,
      [Map<String, dynamic>? params]) async {
    // Firebase doesn't use SQL, so interpret query as collection/document path
    return {};
  }

  @override
  Future<void> executeUpdate(String query, Map<String, dynamic> params) async {
    // Handle dynamic updates for Firebase
  }

  @override
  Future<List<Map<String, dynamic>>> getCustomData(
      String table, Map<String, dynamic> filters) async {
    // Dynamic Firestore query building
    return [];
  }

  @override
  Future<void> saveCustomData(String table, Map<String, dynamic> data) async {
    // Save any dynamic data structure
  }

  @override
  Future<void> deleteCustomData(
      String table, Map<String, dynamic> filters) async {
    // Delete based on dynamic filters
  }

  @override
  Future<List<Map<String, dynamic>>> searchData(
      String collection, Map<String, dynamic> searchCriteria) async {
    // Implement dynamic search across any fields
    return [];
  }

  @override
  Future<Map<String, dynamic>> getDataById(String collection, String id) async {
    // Get any document by ID
    return {};
  }

  @override
  Future<void> updateDataById(
      String collection, String id, Map<String, dynamic> updates) async {
    // Update any document with dynamic fields
  }
}

// MySQL implementation - completely dynamic
class MySQLDatabaseService implements DatabaseService {
  final Map<String, dynamic> config;

  MySQLDatabaseService(this.config);

  String get _host => config['host'] as String? ?? 'localhost';
  int get _port => config['port'] as int? ?? 3306;
  String get _database => config['database'] as String? ?? 'substations_db';
  String get _username => config['username'] as String? ?? '';
  String get _password => config['password'] as String? ?? '';

  @override
  Future<List<Map<String, dynamic>>> getSubstations(String userId) async {
    final tableName = config['substationsTable'] as String? ?? 'substations';
    final userField = config['userField'] as String? ?? 'assigned_user_id';

    // Build dynamic SQL query
    final query = 'SELECT * FROM $tableName WHERE $userField = ?';
    return await executeQuery(query, {'userId': userId}).then(
        (result) => List<Map<String, dynamic>>.from(result['data'] ?? []));
  }

  @override
  Future<void> saveReading(Map<String, dynamic> reading) async {
    final tableName = config['readingsTable'] as String? ?? 'readings';

    // Build dynamic INSERT query
    final fields = reading.keys.join(', ');
    final placeholders = reading.keys.map((_) => '?').join(', ');
    final query = 'INSERT INTO $tableName ($fields) VALUES ($placeholders)';

    await executeUpdate(query, reading);
  }

  @override
  Future<List<Map<String, dynamic>>> getMaintenanceLogs(
      String substationId) async {
    final tableName =
        config['maintenanceTable'] as String? ?? 'maintenance_logs';
    final substationField =
        config['substationField'] as String? ?? 'substation_id';

    final query = 'SELECT * FROM $tableName WHERE $substationField = ?';
    return await executeQuery(query, {'substationId': substationId}).then(
        (result) => List<Map<String, dynamic>>.from(result['data'] ?? []));
  }

  @override
  Future<Map<String, dynamic>> executeQuery(String query,
      [Map<String, dynamic>? params]) async {
    // Execute raw SQL query with parameters
    // Connect to MySQL using config values
    // Return results as Map
    return {'data': [], 'rowCount': 0};
  }

  @override
  Future<void> executeUpdate(String query, Map<String, dynamic> params) async {
    // Execute INSERT/UPDATE/DELETE queries
  }

  @override
  Future<List<Map<String, dynamic>>> getCustomData(
      String table, Map<String, dynamic> filters) async {
    // Build dynamic WHERE clause from filters
    final whereClause =
        filters.entries.map((e) => '${e.key} = ?').join(' AND ');
    final query = 'SELECT * FROM $table WHERE $whereClause';

    return await executeQuery(query, filters).then(
        (result) => List<Map<String, dynamic>>.from(result['data'] ?? []));
  }

  @override
  Future<void> saveCustomData(String table, Map<String, dynamic> data) async {
    final fields = data.keys.join(', ');
    final placeholders = data.keys.map((_) => '?').join(', ');
    final query = 'INSERT INTO $table ($fields) VALUES ($placeholders)';

    await executeUpdate(query, data);
  }

  @override
  Future<void> deleteCustomData(
      String table, Map<String, dynamic> filters) async {
    final whereClause =
        filters.entries.map((e) => '${e.key} = ?').join(' AND ');
    final query = 'DELETE FROM $table WHERE $whereClause';

    await executeUpdate(query, filters);
  }

  @override
  Future<List<Map<String, dynamic>>> searchData(
      String collection, Map<String, dynamic> searchCriteria) async {
    // Implement full-text search or LIKE queries
    return [];
  }

  @override
  Future<Map<String, dynamic>> getDataById(String collection, String id) async {
    final idField = config['idField'] as String? ?? 'id';
    final query = 'SELECT * FROM $collection WHERE $idField = ?';

    final result = await executeQuery(query, {'id': id});
    final data = List<Map<String, dynamic>>.from(result['data'] ?? []);
    return data.isNotEmpty ? data.first : {};
  }

  @override
  Future<void> updateDataById(
      String collection, String id, Map<String, dynamic> updates) async {
    final idField = config['idField'] as String? ?? 'id';
    final setClause = updates.entries.map((e) => '${e.key} = ?').join(', ');
    final query = 'UPDATE $collection SET $setClause WHERE $idField = ?';

    final params = {...updates, 'id': id};
    await executeUpdate(query, params);
  }
}

// PostgreSQL implementation - completely dynamic
class PostgreSQLDatabaseService implements DatabaseService {
  final Map<String, dynamic> config;

  PostgreSQLDatabaseService(this.config);

  String get _host => config['host'] as String? ?? 'localhost';
  int get _port => config['port'] as int? ?? 5432;
  String get _database => config['database'] as String? ?? 'substations_db';
  String get _username => config['username'] as String? ?? '';
  String get _password => config['password'] as String? ?? '';

  @override
  Future<List<Map<String, dynamic>>> getSubstations(String userId) async {
    final tableName = config['substationsTable'] as String? ?? 'substations';
    final userField = config['userField'] as String? ?? 'assigned_user_id';

    final query = 'SELECT * FROM $tableName WHERE $userField = \$1';
    return await executeQuery(query, {'userId': userId}).then(
        (result) => List<Map<String, dynamic>>.from(result['data'] ?? []));
  }

  @override
  Future<void> saveReading(Map<String, dynamic> reading) async {
    final tableName = config['readingsTable'] as String? ?? 'readings';

    final fields = reading.keys.join(', ');
    final placeholders = reading.keys
        .map((key) => '\$${reading.keys.toList().indexOf(key) + 1}')
        .join(', ');
    final query = 'INSERT INTO $tableName ($fields) VALUES ($placeholders)';

    await executeUpdate(query, reading);
  }

  @override
  Future<List<Map<String, dynamic>>> getMaintenanceLogs(
      String substationId) async {
    final tableName =
        config['maintenanceTable'] as String? ?? 'maintenance_logs';
    final substationField =
        config['substationField'] as String? ?? 'substation_id';

    final query = 'SELECT * FROM $tableName WHERE $substationField = \$1';
    return await executeQuery(query, {'substationId': substationId}).then(
        (result) => List<Map<String, dynamic>>.from(result['data'] ?? []));
  }

  // Implement all other methods similar to MySQL but with PostgreSQL syntax...

  @override
  Future<Map<String, dynamic>> executeQuery(String query,
      [Map<String, dynamic>? params]) async {
    // PostgreSQL implementation
    return {'data': [], 'rowCount': 0};
  }

  @override
  Future<void> executeUpdate(String query, Map<String, dynamic> params) async {
    // PostgreSQL implementation
  }

  @override
  Future<List<Map<String, dynamic>>> getCustomData(
      String table, Map<String, dynamic> filters) async {
    return [];
  }

  @override
  Future<void> saveCustomData(String table, Map<String, dynamic> data) async {}

  @override
  Future<void> deleteCustomData(
      String table, Map<String, dynamic> filters) async {}

  @override
  Future<List<Map<String, dynamic>>> searchData(
          String collection, Map<String, dynamic> searchCriteria) async =>
      [];

  @override
  Future<Map<String, dynamic>> getDataById(
          String collection, String id) async =>
      {};

  @override
  Future<void> updateDataById(
      String collection, String id, Map<String, dynamic> updates) async {}
}

// Oracle and SQLite implementations following the same pattern...
class OracleDatabaseService implements DatabaseService {
  final Map<String, dynamic> config;
  OracleDatabaseService(this.config);

  // Implement all methods with Oracle-specific syntax
  @override
  Future<List<Map<String, dynamic>>> getSubstations(String userId) async => [];
  @override
  Future<void> saveReading(Map<String, dynamic> reading) async {}
  @override
  Future<List<Map<String, dynamic>>> getMaintenanceLogs(
          String substationId) async =>
      [];
  @override
  Future<Map<String, dynamic>> executeQuery(String query,
          [Map<String, dynamic>? params]) async =>
      {};
  @override
  Future<void> executeUpdate(String query, Map<String, dynamic> params) async {}
  @override
  Future<List<Map<String, dynamic>>> getCustomData(
          String table, Map<String, dynamic> filters) async =>
      [];
  @override
  Future<void> saveCustomData(String table, Map<String, dynamic> data) async {}
  @override
  Future<void> deleteCustomData(
      String table, Map<String, dynamic> filters) async {}
  @override
  Future<List<Map<String, dynamic>>> searchData(
          String collection, Map<String, dynamic> searchCriteria) async =>
      [];
  @override
  Future<Map<String, dynamic>> getDataById(
          String collection, String id) async =>
      {};
  @override
  Future<void> updateDataById(
      String collection, String id, Map<String, dynamic> updates) async {}
}

class SQLiteDatabaseService implements DatabaseService {
  final Map<String, dynamic> config;
  SQLiteDatabaseService(this.config);

  // SQLite implementations...
  @override
  Future<List<Map<String, dynamic>>> getSubstations(String userId) async => [];
  @override
  Future<void> saveReading(Map<String, dynamic> reading) async {}
  @override
  Future<List<Map<String, dynamic>>> getMaintenanceLogs(
          String substationId) async =>
      [];
  @override
  Future<Map<String, dynamic>> executeQuery(String query,
          [Map<String, dynamic>? params]) async =>
      {};
  @override
  Future<void> executeUpdate(String query, Map<String, dynamic> params) async {}
  @override
  Future<List<Map<String, dynamic>>> getCustomData(
          String table, Map<String, dynamic> filters) async =>
      [];
  @override
  Future<void> saveCustomData(String table, Map<String, dynamic> data) async {}
  @override
  Future<void> deleteCustomData(
      String table, Map<String, dynamic> filters) async {}
  @override
  Future<List<Map<String, dynamic>>> searchData(
          String collection, Map<String, dynamic> searchCriteria) async =>
      [];
  @override
  Future<Map<String, dynamic>> getDataById(
          String collection, String id) async =>
      {};
  @override
  Future<void> updateDataById(
      String collection, String id, Map<String, dynamic> updates) async {}
}

class MongoDBDatabaseService implements DatabaseService {
  final Map<String, dynamic> config;
  MongoDBDatabaseService(this.config);

  // MongoDB implementations...
  @override
  Future<List<Map<String, dynamic>>> getSubstations(String userId) async => [];
  @override
  Future<void> saveReading(Map<String, dynamic> reading) async {}
  @override
  Future<List<Map<String, dynamic>>> getMaintenanceLogs(
          String substationId) async =>
      [];
  @override
  Future<Map<String, dynamic>> executeQuery(String query,
          [Map<String, dynamic>? params]) async =>
      {};
  @override
  Future<void> executeUpdate(String query, Map<String, dynamic> params) async {}
  @override
  Future<List<Map<String, dynamic>>> getCustomData(
          String table, Map<String, dynamic> filters) async =>
      [];
  @override
  Future<void> saveCustomData(String table, Map<String, dynamic> data) async {}
  @override
  Future<void> deleteCustomData(
      String table, Map<String, dynamic> filters) async {}
  @override
  Future<List<Map<String, dynamic>>> searchData(
          String collection, Map<String, dynamic> searchCriteria) async =>
      [];
  @override
  Future<Map<String, dynamic>> getDataById(
          String collection, String id) async =>
      {};
  @override
  Future<void> updateDataById(
      String collection, String id, Map<String, dynamic> updates) async {}
}
