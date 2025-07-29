// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'enhanced_isar_service.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetCacheItemCollection on Isar {
  IsarCollection<CacheItem> get cacheItems => this.collection();
}

const CacheItemSchema = CollectionSchema(
  name: r'CacheItem',
  id: 3846788493497230968,
  properties: {
    r'category': PropertySchema(
      id: 0,
      name: r'category',
      type: IsarType.string,
    ),
    r'createdAt': PropertySchema(
      id: 1,
      name: r'createdAt',
      type: IsarType.dateTime,
    ),
    r'dataJson': PropertySchema(
      id: 2,
      name: r'dataJson',
      type: IsarType.string,
    ),
    r'expiresAt': PropertySchema(
      id: 3,
      name: r'expiresAt',
      type: IsarType.dateTime,
    ),
    r'isExpired': PropertySchema(
      id: 4,
      name: r'isExpired',
      type: IsarType.bool,
    ),
    r'isNearExpiration': PropertySchema(
      id: 5,
      name: r'isNearExpiration',
      type: IsarType.bool,
    ),
    r'key': PropertySchema(
      id: 6,
      name: r'key',
      type: IsarType.string,
    ),
    r'metadata': PropertySchema(
      id: 7,
      name: r'metadata',
      type: IsarType.string,
    )
  },
  estimateSize: _cacheItemEstimateSize,
  serialize: _cacheItemSerialize,
  deserialize: _cacheItemDeserialize,
  deserializeProp: _cacheItemDeserializeProp,
  idName: r'id',
  indexes: {
    r'key': IndexSchema(
      id: -4906094122524121629,
      name: r'key',
      unique: true,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'key',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
    r'createdAt': IndexSchema(
      id: -3433535483987302584,
      name: r'createdAt',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'createdAt',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    ),
    r'category': IndexSchema(
      id: -7560358558326323820,
      name: r'category',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'category',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _cacheItemGetId,
  getLinks: _cacheItemGetLinks,
  attach: _cacheItemAttach,
  version: '3.1.0+1',
);

int _cacheItemEstimateSize(
  CacheItem object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.category.length * 3;
  bytesCount += 3 + object.dataJson.length * 3;
  bytesCount += 3 + object.key.length * 3;
  {
    final value = object.metadata;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _cacheItemSerialize(
  CacheItem object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.category);
  writer.writeDateTime(offsets[1], object.createdAt);
  writer.writeString(offsets[2], object.dataJson);
  writer.writeDateTime(offsets[3], object.expiresAt);
  writer.writeBool(offsets[4], object.isExpired);
  writer.writeBool(offsets[5], object.isNearExpiration);
  writer.writeString(offsets[6], object.key);
  writer.writeString(offsets[7], object.metadata);
}

CacheItem _cacheItemDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = CacheItem();
  object.category = reader.readString(offsets[0]);
  object.createdAt = reader.readDateTime(offsets[1]);
  object.dataJson = reader.readString(offsets[2]);
  object.expiresAt = reader.readDateTimeOrNull(offsets[3]);
  object.id = id;
  object.key = reader.readString(offsets[6]);
  object.metadata = reader.readStringOrNull(offsets[7]);
  return object;
}

P _cacheItemDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readDateTime(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 4:
      return (reader.readBool(offset)) as P;
    case 5:
      return (reader.readBool(offset)) as P;
    case 6:
      return (reader.readString(offset)) as P;
    case 7:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _cacheItemGetId(CacheItem object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _cacheItemGetLinks(CacheItem object) {
  return [];
}

void _cacheItemAttach(IsarCollection<dynamic> col, Id id, CacheItem object) {
  object.id = id;
}

extension CacheItemByIndex on IsarCollection<CacheItem> {
  Future<CacheItem?> getByKey(String key) {
    return getByIndex(r'key', [key]);
  }

  CacheItem? getByKeySync(String key) {
    return getByIndexSync(r'key', [key]);
  }

  Future<bool> deleteByKey(String key) {
    return deleteByIndex(r'key', [key]);
  }

  bool deleteByKeySync(String key) {
    return deleteByIndexSync(r'key', [key]);
  }

  Future<List<CacheItem?>> getAllByKey(List<String> keyValues) {
    final values = keyValues.map((e) => [e]).toList();
    return getAllByIndex(r'key', values);
  }

  List<CacheItem?> getAllByKeySync(List<String> keyValues) {
    final values = keyValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'key', values);
  }

  Future<int> deleteAllByKey(List<String> keyValues) {
    final values = keyValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'key', values);
  }

  int deleteAllByKeySync(List<String> keyValues) {
    final values = keyValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'key', values);
  }

  Future<Id> putByKey(CacheItem object) {
    return putByIndex(r'key', object);
  }

  Id putByKeySync(CacheItem object, {bool saveLinks = true}) {
    return putByIndexSync(r'key', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByKey(List<CacheItem> objects) {
    return putAllByIndex(r'key', objects);
  }

  List<Id> putAllByKeySync(List<CacheItem> objects, {bool saveLinks = true}) {
    return putAllByIndexSync(r'key', objects, saveLinks: saveLinks);
  }
}

extension CacheItemQueryWhereSort
    on QueryBuilder<CacheItem, CacheItem, QWhere> {
  QueryBuilder<CacheItem, CacheItem, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<CacheItem, CacheItem, QAfterWhere> anyCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'createdAt'),
      );
    });
  }
}

extension CacheItemQueryWhere
    on QueryBuilder<CacheItem, CacheItem, QWhereClause> {
  QueryBuilder<CacheItem, CacheItem, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<CacheItem, CacheItem, QAfterWhereClause> idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<CacheItem, CacheItem, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<CacheItem, CacheItem, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<CacheItem, CacheItem, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CacheItem, CacheItem, QAfterWhereClause> keyEqualTo(String key) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'key',
        value: [key],
      ));
    });
  }

  QueryBuilder<CacheItem, CacheItem, QAfterWhereClause> keyNotEqualTo(
      String key) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'key',
              lower: [],
              upper: [key],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'key',
              lower: [key],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'key',
              lower: [key],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'key',
              lower: [],
              upper: [key],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<CacheItem, CacheItem, QAfterWhereClause> createdAtEqualTo(
      DateTime createdAt) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'createdAt',
        value: [createdAt],
      ));
    });
  }

  QueryBuilder<CacheItem, CacheItem, QAfterWhereClause> createdAtNotEqualTo(
      DateTime createdAt) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'createdAt',
              lower: [],
              upper: [createdAt],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'createdAt',
              lower: [createdAt],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'createdAt',
              lower: [createdAt],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'createdAt',
              lower: [],
              upper: [createdAt],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<CacheItem, CacheItem, QAfterWhereClause> createdAtGreaterThan(
    DateTime createdAt, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'createdAt',
        lower: [createdAt],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<CacheItem, CacheItem, QAfterWhereClause> createdAtLessThan(
    DateTime createdAt, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'createdAt',
        lower: [],
        upper: [createdAt],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<CacheItem, CacheItem, QAfterWhereClause> createdAtBetween(
    DateTime lowerCreatedAt,
    DateTime upperCreatedAt, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'createdAt',
        lower: [lowerCreatedAt],
        includeLower: includeLower,
        upper: [upperCreatedAt],
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CacheItem, CacheItem, QAfterWhereClause> categoryEqualTo(
      String category) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'category',
        value: [category],
      ));
    });
  }

  QueryBuilder<CacheItem, CacheItem, QAfterWhereClause> categoryNotEqualTo(
      String category) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'category',
              lower: [],
              upper: [category],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'category',
              lower: [category],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'category',
              lower: [category],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'category',
              lower: [],
              upper: [category],
              includeUpper: false,
            ));
      }
    });
  }
}

extension CacheItemQueryFilter
    on QueryBuilder<CacheItem, CacheItem, QFilterCondition> {
  QueryBuilder<CacheItem, CacheItem, QAfterFilterCondition> categoryEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'category',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CacheItem, CacheItem, QAfterFilterCondition> categoryGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'category',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CacheItem, CacheItem, QAfterFilterCondition> categoryLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'category',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CacheItem, CacheItem, QAfterFilterCondition> categoryBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'category',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CacheItem, CacheItem, QAfterFilterCondition> categoryStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'category',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CacheItem, CacheItem, QAfterFilterCondition> categoryEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'category',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CacheItem, CacheItem, QAfterFilterCondition> categoryContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'category',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CacheItem, CacheItem, QAfterFilterCondition> categoryMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'category',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CacheItem, CacheItem, QAfterFilterCondition> categoryIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'category',
        value: '',
      ));
    });
  }

  QueryBuilder<CacheItem, CacheItem, QAfterFilterCondition>
      categoryIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'category',
        value: '',
      ));
    });
  }

  QueryBuilder<CacheItem, CacheItem, QAfterFilterCondition> createdAtEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<CacheItem, CacheItem, QAfterFilterCondition>
      createdAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<CacheItem, CacheItem, QAfterFilterCondition> createdAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<CacheItem, CacheItem, QAfterFilterCondition> createdAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'createdAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CacheItem, CacheItem, QAfterFilterCondition> dataJsonEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dataJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CacheItem, CacheItem, QAfterFilterCondition> dataJsonGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'dataJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CacheItem, CacheItem, QAfterFilterCondition> dataJsonLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'dataJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CacheItem, CacheItem, QAfterFilterCondition> dataJsonBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'dataJson',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CacheItem, CacheItem, QAfterFilterCondition> dataJsonStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'dataJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CacheItem, CacheItem, QAfterFilterCondition> dataJsonEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'dataJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CacheItem, CacheItem, QAfterFilterCondition> dataJsonContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'dataJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CacheItem, CacheItem, QAfterFilterCondition> dataJsonMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'dataJson',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CacheItem, CacheItem, QAfterFilterCondition> dataJsonIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dataJson',
        value: '',
      ));
    });
  }

  QueryBuilder<CacheItem, CacheItem, QAfterFilterCondition>
      dataJsonIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'dataJson',
        value: '',
      ));
    });
  }

  QueryBuilder<CacheItem, CacheItem, QAfterFilterCondition> expiresAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'expiresAt',
      ));
    });
  }

  QueryBuilder<CacheItem, CacheItem, QAfterFilterCondition>
      expiresAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'expiresAt',
      ));
    });
  }

  QueryBuilder<CacheItem, CacheItem, QAfterFilterCondition> expiresAtEqualTo(
      DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'expiresAt',
        value: value,
      ));
    });
  }

  QueryBuilder<CacheItem, CacheItem, QAfterFilterCondition>
      expiresAtGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'expiresAt',
        value: value,
      ));
    });
  }

  QueryBuilder<CacheItem, CacheItem, QAfterFilterCondition> expiresAtLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'expiresAt',
        value: value,
      ));
    });
  }

  QueryBuilder<CacheItem, CacheItem, QAfterFilterCondition> expiresAtBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'expiresAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CacheItem, CacheItem, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<CacheItem, CacheItem, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<CacheItem, CacheItem, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<CacheItem, CacheItem, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CacheItem, CacheItem, QAfterFilterCondition> isExpiredEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isExpired',
        value: value,
      ));
    });
  }

  QueryBuilder<CacheItem, CacheItem, QAfterFilterCondition>
      isNearExpirationEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isNearExpiration',
        value: value,
      ));
    });
  }

  QueryBuilder<CacheItem, CacheItem, QAfterFilterCondition> keyEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'key',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CacheItem, CacheItem, QAfterFilterCondition> keyGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'key',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CacheItem, CacheItem, QAfterFilterCondition> keyLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'key',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CacheItem, CacheItem, QAfterFilterCondition> keyBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'key',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CacheItem, CacheItem, QAfterFilterCondition> keyStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'key',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CacheItem, CacheItem, QAfterFilterCondition> keyEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'key',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CacheItem, CacheItem, QAfterFilterCondition> keyContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'key',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CacheItem, CacheItem, QAfterFilterCondition> keyMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'key',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CacheItem, CacheItem, QAfterFilterCondition> keyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'key',
        value: '',
      ));
    });
  }

  QueryBuilder<CacheItem, CacheItem, QAfterFilterCondition> keyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'key',
        value: '',
      ));
    });
  }

  QueryBuilder<CacheItem, CacheItem, QAfterFilterCondition> metadataIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'metadata',
      ));
    });
  }

  QueryBuilder<CacheItem, CacheItem, QAfterFilterCondition>
      metadataIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'metadata',
      ));
    });
  }

  QueryBuilder<CacheItem, CacheItem, QAfterFilterCondition> metadataEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'metadata',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CacheItem, CacheItem, QAfterFilterCondition> metadataGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'metadata',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CacheItem, CacheItem, QAfterFilterCondition> metadataLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'metadata',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CacheItem, CacheItem, QAfterFilterCondition> metadataBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'metadata',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CacheItem, CacheItem, QAfterFilterCondition> metadataStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'metadata',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CacheItem, CacheItem, QAfterFilterCondition> metadataEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'metadata',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CacheItem, CacheItem, QAfterFilterCondition> metadataContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'metadata',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CacheItem, CacheItem, QAfterFilterCondition> metadataMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'metadata',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CacheItem, CacheItem, QAfterFilterCondition> metadataIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'metadata',
        value: '',
      ));
    });
  }

  QueryBuilder<CacheItem, CacheItem, QAfterFilterCondition>
      metadataIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'metadata',
        value: '',
      ));
    });
  }
}

extension CacheItemQueryObject
    on QueryBuilder<CacheItem, CacheItem, QFilterCondition> {}

extension CacheItemQueryLinks
    on QueryBuilder<CacheItem, CacheItem, QFilterCondition> {}

extension CacheItemQuerySortBy on QueryBuilder<CacheItem, CacheItem, QSortBy> {
  QueryBuilder<CacheItem, CacheItem, QAfterSortBy> sortByCategory() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'category', Sort.asc);
    });
  }

  QueryBuilder<CacheItem, CacheItem, QAfterSortBy> sortByCategoryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'category', Sort.desc);
    });
  }

  QueryBuilder<CacheItem, CacheItem, QAfterSortBy> sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<CacheItem, CacheItem, QAfterSortBy> sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<CacheItem, CacheItem, QAfterSortBy> sortByDataJson() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dataJson', Sort.asc);
    });
  }

  QueryBuilder<CacheItem, CacheItem, QAfterSortBy> sortByDataJsonDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dataJson', Sort.desc);
    });
  }

  QueryBuilder<CacheItem, CacheItem, QAfterSortBy> sortByExpiresAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'expiresAt', Sort.asc);
    });
  }

  QueryBuilder<CacheItem, CacheItem, QAfterSortBy> sortByExpiresAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'expiresAt', Sort.desc);
    });
  }

  QueryBuilder<CacheItem, CacheItem, QAfterSortBy> sortByIsExpired() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isExpired', Sort.asc);
    });
  }

  QueryBuilder<CacheItem, CacheItem, QAfterSortBy> sortByIsExpiredDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isExpired', Sort.desc);
    });
  }

  QueryBuilder<CacheItem, CacheItem, QAfterSortBy> sortByIsNearExpiration() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isNearExpiration', Sort.asc);
    });
  }

  QueryBuilder<CacheItem, CacheItem, QAfterSortBy>
      sortByIsNearExpirationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isNearExpiration', Sort.desc);
    });
  }

  QueryBuilder<CacheItem, CacheItem, QAfterSortBy> sortByKey() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'key', Sort.asc);
    });
  }

  QueryBuilder<CacheItem, CacheItem, QAfterSortBy> sortByKeyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'key', Sort.desc);
    });
  }

  QueryBuilder<CacheItem, CacheItem, QAfterSortBy> sortByMetadata() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'metadata', Sort.asc);
    });
  }

  QueryBuilder<CacheItem, CacheItem, QAfterSortBy> sortByMetadataDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'metadata', Sort.desc);
    });
  }
}

extension CacheItemQuerySortThenBy
    on QueryBuilder<CacheItem, CacheItem, QSortThenBy> {
  QueryBuilder<CacheItem, CacheItem, QAfterSortBy> thenByCategory() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'category', Sort.asc);
    });
  }

  QueryBuilder<CacheItem, CacheItem, QAfterSortBy> thenByCategoryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'category', Sort.desc);
    });
  }

  QueryBuilder<CacheItem, CacheItem, QAfterSortBy> thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<CacheItem, CacheItem, QAfterSortBy> thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<CacheItem, CacheItem, QAfterSortBy> thenByDataJson() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dataJson', Sort.asc);
    });
  }

  QueryBuilder<CacheItem, CacheItem, QAfterSortBy> thenByDataJsonDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dataJson', Sort.desc);
    });
  }

  QueryBuilder<CacheItem, CacheItem, QAfterSortBy> thenByExpiresAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'expiresAt', Sort.asc);
    });
  }

  QueryBuilder<CacheItem, CacheItem, QAfterSortBy> thenByExpiresAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'expiresAt', Sort.desc);
    });
  }

  QueryBuilder<CacheItem, CacheItem, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<CacheItem, CacheItem, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<CacheItem, CacheItem, QAfterSortBy> thenByIsExpired() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isExpired', Sort.asc);
    });
  }

  QueryBuilder<CacheItem, CacheItem, QAfterSortBy> thenByIsExpiredDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isExpired', Sort.desc);
    });
  }

  QueryBuilder<CacheItem, CacheItem, QAfterSortBy> thenByIsNearExpiration() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isNearExpiration', Sort.asc);
    });
  }

  QueryBuilder<CacheItem, CacheItem, QAfterSortBy>
      thenByIsNearExpirationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isNearExpiration', Sort.desc);
    });
  }

  QueryBuilder<CacheItem, CacheItem, QAfterSortBy> thenByKey() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'key', Sort.asc);
    });
  }

  QueryBuilder<CacheItem, CacheItem, QAfterSortBy> thenByKeyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'key', Sort.desc);
    });
  }

  QueryBuilder<CacheItem, CacheItem, QAfterSortBy> thenByMetadata() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'metadata', Sort.asc);
    });
  }

  QueryBuilder<CacheItem, CacheItem, QAfterSortBy> thenByMetadataDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'metadata', Sort.desc);
    });
  }
}

extension CacheItemQueryWhereDistinct
    on QueryBuilder<CacheItem, CacheItem, QDistinct> {
  QueryBuilder<CacheItem, CacheItem, QDistinct> distinctByCategory(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'category', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CacheItem, CacheItem, QDistinct> distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt');
    });
  }

  QueryBuilder<CacheItem, CacheItem, QDistinct> distinctByDataJson(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dataJson', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CacheItem, CacheItem, QDistinct> distinctByExpiresAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'expiresAt');
    });
  }

  QueryBuilder<CacheItem, CacheItem, QDistinct> distinctByIsExpired() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isExpired');
    });
  }

  QueryBuilder<CacheItem, CacheItem, QDistinct> distinctByIsNearExpiration() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isNearExpiration');
    });
  }

  QueryBuilder<CacheItem, CacheItem, QDistinct> distinctByKey(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'key', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CacheItem, CacheItem, QDistinct> distinctByMetadata(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'metadata', caseSensitive: caseSensitive);
    });
  }
}

extension CacheItemQueryProperty
    on QueryBuilder<CacheItem, CacheItem, QQueryProperty> {
  QueryBuilder<CacheItem, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<CacheItem, String, QQueryOperations> categoryProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'category');
    });
  }

  QueryBuilder<CacheItem, DateTime, QQueryOperations> createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<CacheItem, String, QQueryOperations> dataJsonProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dataJson');
    });
  }

  QueryBuilder<CacheItem, DateTime?, QQueryOperations> expiresAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'expiresAt');
    });
  }

  QueryBuilder<CacheItem, bool, QQueryOperations> isExpiredProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isExpired');
    });
  }

  QueryBuilder<CacheItem, bool, QQueryOperations> isNearExpirationProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isNearExpiration');
    });
  }

  QueryBuilder<CacheItem, String, QQueryOperations> keyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'key');
    });
  }

  QueryBuilder<CacheItem, String?, QQueryOperations> metadataProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'metadata');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetCachedUserPermissionsCollection on Isar {
  IsarCollection<CachedUserPermissions> get cachedUserPermissions =>
      this.collection();
}

const CachedUserPermissionsSchema = CollectionSchema(
  name: r'CachedUserPermissions',
  id: -3785977340712897026,
  properties: {
    r'createdAt': PropertySchema(
      id: 0,
      name: r'createdAt',
      type: IsarType.dateTime,
    ),
    r'expiresAt': PropertySchema(
      id: 1,
      name: r'expiresAt',
      type: IsarType.dateTime,
    ),
    r'isExpired': PropertySchema(
      id: 2,
      name: r'isExpired',
      type: IsarType.bool,
    ),
    r'organizationId': PropertySchema(
      id: 3,
      name: r'organizationId',
      type: IsarType.string,
    ),
    r'permissions': PropertySchema(
      id: 4,
      name: r'permissions',
      type: IsarType.stringList,
    ),
    r'roleLevel': PropertySchema(
      id: 5,
      name: r'roleLevel',
      type: IsarType.string,
    ),
    r'userId': PropertySchema(
      id: 6,
      name: r'userId',
      type: IsarType.string,
    )
  },
  estimateSize: _cachedUserPermissionsEstimateSize,
  serialize: _cachedUserPermissionsSerialize,
  deserialize: _cachedUserPermissionsDeserialize,
  deserializeProp: _cachedUserPermissionsDeserializeProp,
  idName: r'id',
  indexes: {
    r'userId': IndexSchema(
      id: -2005826577402374815,
      name: r'userId',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'userId',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
    r'createdAt': IndexSchema(
      id: -3433535483987302584,
      name: r'createdAt',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'createdAt',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _cachedUserPermissionsGetId,
  getLinks: _cachedUserPermissionsGetLinks,
  attach: _cachedUserPermissionsAttach,
  version: '3.1.0+1',
);

int _cachedUserPermissionsEstimateSize(
  CachedUserPermissions object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.organizationId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.permissions.length * 3;
  {
    for (var i = 0; i < object.permissions.length; i++) {
      final value = object.permissions[i];
      bytesCount += value.length * 3;
    }
  }
  {
    final value = object.roleLevel;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.userId.length * 3;
  return bytesCount;
}

void _cachedUserPermissionsSerialize(
  CachedUserPermissions object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDateTime(offsets[0], object.createdAt);
  writer.writeDateTime(offsets[1], object.expiresAt);
  writer.writeBool(offsets[2], object.isExpired);
  writer.writeString(offsets[3], object.organizationId);
  writer.writeStringList(offsets[4], object.permissions);
  writer.writeString(offsets[5], object.roleLevel);
  writer.writeString(offsets[6], object.userId);
}

CachedUserPermissions _cachedUserPermissionsDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = CachedUserPermissions();
  object.createdAt = reader.readDateTime(offsets[0]);
  object.expiresAt = reader.readDateTime(offsets[1]);
  object.id = id;
  object.organizationId = reader.readStringOrNull(offsets[3]);
  object.permissions = reader.readStringList(offsets[4]) ?? [];
  object.roleLevel = reader.readStringOrNull(offsets[5]);
  object.userId = reader.readString(offsets[6]);
  return object;
}

P _cachedUserPermissionsDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDateTime(offset)) as P;
    case 1:
      return (reader.readDateTime(offset)) as P;
    case 2:
      return (reader.readBool(offset)) as P;
    case 3:
      return (reader.readStringOrNull(offset)) as P;
    case 4:
      return (reader.readStringList(offset) ?? []) as P;
    case 5:
      return (reader.readStringOrNull(offset)) as P;
    case 6:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _cachedUserPermissionsGetId(CachedUserPermissions object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _cachedUserPermissionsGetLinks(
    CachedUserPermissions object) {
  return [];
}

void _cachedUserPermissionsAttach(
    IsarCollection<dynamic> col, Id id, CachedUserPermissions object) {
  object.id = id;
}

extension CachedUserPermissionsQueryWhereSort
    on QueryBuilder<CachedUserPermissions, CachedUserPermissions, QWhere> {
  QueryBuilder<CachedUserPermissions, CachedUserPermissions, QAfterWhere>
      anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<CachedUserPermissions, CachedUserPermissions, QAfterWhere>
      anyCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'createdAt'),
      );
    });
  }
}

extension CachedUserPermissionsQueryWhere on QueryBuilder<CachedUserPermissions,
    CachedUserPermissions, QWhereClause> {
  QueryBuilder<CachedUserPermissions, CachedUserPermissions, QAfterWhereClause>
      idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<CachedUserPermissions, CachedUserPermissions, QAfterWhereClause>
      idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<CachedUserPermissions, CachedUserPermissions, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<CachedUserPermissions, CachedUserPermissions, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<CachedUserPermissions, CachedUserPermissions, QAfterWhereClause>
      idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CachedUserPermissions, CachedUserPermissions, QAfterWhereClause>
      userIdEqualTo(String userId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'userId',
        value: [userId],
      ));
    });
  }

  QueryBuilder<CachedUserPermissions, CachedUserPermissions, QAfterWhereClause>
      userIdNotEqualTo(String userId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'userId',
              lower: [],
              upper: [userId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'userId',
              lower: [userId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'userId',
              lower: [userId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'userId',
              lower: [],
              upper: [userId],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<CachedUserPermissions, CachedUserPermissions, QAfterWhereClause>
      createdAtEqualTo(DateTime createdAt) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'createdAt',
        value: [createdAt],
      ));
    });
  }

  QueryBuilder<CachedUserPermissions, CachedUserPermissions, QAfterWhereClause>
      createdAtNotEqualTo(DateTime createdAt) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'createdAt',
              lower: [],
              upper: [createdAt],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'createdAt',
              lower: [createdAt],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'createdAt',
              lower: [createdAt],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'createdAt',
              lower: [],
              upper: [createdAt],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<CachedUserPermissions, CachedUserPermissions, QAfterWhereClause>
      createdAtGreaterThan(
    DateTime createdAt, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'createdAt',
        lower: [createdAt],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<CachedUserPermissions, CachedUserPermissions, QAfterWhereClause>
      createdAtLessThan(
    DateTime createdAt, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'createdAt',
        lower: [],
        upper: [createdAt],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<CachedUserPermissions, CachedUserPermissions, QAfterWhereClause>
      createdAtBetween(
    DateTime lowerCreatedAt,
    DateTime upperCreatedAt, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'createdAt',
        lower: [lowerCreatedAt],
        includeLower: includeLower,
        upper: [upperCreatedAt],
        includeUpper: includeUpper,
      ));
    });
  }
}

extension CachedUserPermissionsQueryFilter on QueryBuilder<
    CachedUserPermissions, CachedUserPermissions, QFilterCondition> {
  QueryBuilder<CachedUserPermissions, CachedUserPermissions,
      QAfterFilterCondition> createdAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<CachedUserPermissions, CachedUserPermissions,
      QAfterFilterCondition> createdAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<CachedUserPermissions, CachedUserPermissions,
      QAfterFilterCondition> createdAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<CachedUserPermissions, CachedUserPermissions,
      QAfterFilterCondition> createdAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'createdAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CachedUserPermissions, CachedUserPermissions,
      QAfterFilterCondition> expiresAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'expiresAt',
        value: value,
      ));
    });
  }

  QueryBuilder<CachedUserPermissions, CachedUserPermissions,
      QAfterFilterCondition> expiresAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'expiresAt',
        value: value,
      ));
    });
  }

  QueryBuilder<CachedUserPermissions, CachedUserPermissions,
      QAfterFilterCondition> expiresAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'expiresAt',
        value: value,
      ));
    });
  }

  QueryBuilder<CachedUserPermissions, CachedUserPermissions,
      QAfterFilterCondition> expiresAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'expiresAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CachedUserPermissions, CachedUserPermissions,
      QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<CachedUserPermissions, CachedUserPermissions,
      QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<CachedUserPermissions, CachedUserPermissions,
      QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<CachedUserPermissions, CachedUserPermissions,
      QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CachedUserPermissions, CachedUserPermissions,
      QAfterFilterCondition> isExpiredEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isExpired',
        value: value,
      ));
    });
  }

  QueryBuilder<CachedUserPermissions, CachedUserPermissions,
      QAfterFilterCondition> organizationIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'organizationId',
      ));
    });
  }

  QueryBuilder<CachedUserPermissions, CachedUserPermissions,
      QAfterFilterCondition> organizationIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'organizationId',
      ));
    });
  }

  QueryBuilder<CachedUserPermissions, CachedUserPermissions,
      QAfterFilterCondition> organizationIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'organizationId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedUserPermissions, CachedUserPermissions,
      QAfterFilterCondition> organizationIdGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'organizationId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedUserPermissions, CachedUserPermissions,
      QAfterFilterCondition> organizationIdLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'organizationId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedUserPermissions, CachedUserPermissions,
      QAfterFilterCondition> organizationIdBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'organizationId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedUserPermissions, CachedUserPermissions,
      QAfterFilterCondition> organizationIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'organizationId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedUserPermissions, CachedUserPermissions,
      QAfterFilterCondition> organizationIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'organizationId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedUserPermissions, CachedUserPermissions,
          QAfterFilterCondition>
      organizationIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'organizationId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedUserPermissions, CachedUserPermissions,
          QAfterFilterCondition>
      organizationIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'organizationId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedUserPermissions, CachedUserPermissions,
      QAfterFilterCondition> organizationIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'organizationId',
        value: '',
      ));
    });
  }

  QueryBuilder<CachedUserPermissions, CachedUserPermissions,
      QAfterFilterCondition> organizationIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'organizationId',
        value: '',
      ));
    });
  }

  QueryBuilder<CachedUserPermissions, CachedUserPermissions,
      QAfterFilterCondition> permissionsElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'permissions',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedUserPermissions, CachedUserPermissions,
      QAfterFilterCondition> permissionsElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'permissions',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedUserPermissions, CachedUserPermissions,
      QAfterFilterCondition> permissionsElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'permissions',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedUserPermissions, CachedUserPermissions,
      QAfterFilterCondition> permissionsElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'permissions',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedUserPermissions, CachedUserPermissions,
      QAfterFilterCondition> permissionsElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'permissions',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedUserPermissions, CachedUserPermissions,
      QAfterFilterCondition> permissionsElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'permissions',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedUserPermissions, CachedUserPermissions,
          QAfterFilterCondition>
      permissionsElementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'permissions',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedUserPermissions, CachedUserPermissions,
          QAfterFilterCondition>
      permissionsElementMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'permissions',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedUserPermissions, CachedUserPermissions,
      QAfterFilterCondition> permissionsElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'permissions',
        value: '',
      ));
    });
  }

  QueryBuilder<CachedUserPermissions, CachedUserPermissions,
      QAfterFilterCondition> permissionsElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'permissions',
        value: '',
      ));
    });
  }

  QueryBuilder<CachedUserPermissions, CachedUserPermissions,
      QAfterFilterCondition> permissionsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'permissions',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<CachedUserPermissions, CachedUserPermissions,
      QAfterFilterCondition> permissionsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'permissions',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<CachedUserPermissions, CachedUserPermissions,
      QAfterFilterCondition> permissionsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'permissions',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<CachedUserPermissions, CachedUserPermissions,
      QAfterFilterCondition> permissionsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'permissions',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<CachedUserPermissions, CachedUserPermissions,
      QAfterFilterCondition> permissionsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'permissions',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<CachedUserPermissions, CachedUserPermissions,
      QAfterFilterCondition> permissionsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'permissions',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<CachedUserPermissions, CachedUserPermissions,
      QAfterFilterCondition> roleLevelIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'roleLevel',
      ));
    });
  }

  QueryBuilder<CachedUserPermissions, CachedUserPermissions,
      QAfterFilterCondition> roleLevelIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'roleLevel',
      ));
    });
  }

  QueryBuilder<CachedUserPermissions, CachedUserPermissions,
      QAfterFilterCondition> roleLevelEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'roleLevel',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedUserPermissions, CachedUserPermissions,
      QAfterFilterCondition> roleLevelGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'roleLevel',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedUserPermissions, CachedUserPermissions,
      QAfterFilterCondition> roleLevelLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'roleLevel',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedUserPermissions, CachedUserPermissions,
      QAfterFilterCondition> roleLevelBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'roleLevel',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedUserPermissions, CachedUserPermissions,
      QAfterFilterCondition> roleLevelStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'roleLevel',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedUserPermissions, CachedUserPermissions,
      QAfterFilterCondition> roleLevelEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'roleLevel',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedUserPermissions, CachedUserPermissions,
          QAfterFilterCondition>
      roleLevelContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'roleLevel',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedUserPermissions, CachedUserPermissions,
          QAfterFilterCondition>
      roleLevelMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'roleLevel',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedUserPermissions, CachedUserPermissions,
      QAfterFilterCondition> roleLevelIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'roleLevel',
        value: '',
      ));
    });
  }

  QueryBuilder<CachedUserPermissions, CachedUserPermissions,
      QAfterFilterCondition> roleLevelIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'roleLevel',
        value: '',
      ));
    });
  }

  QueryBuilder<CachedUserPermissions, CachedUserPermissions,
      QAfterFilterCondition> userIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'userId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedUserPermissions, CachedUserPermissions,
      QAfterFilterCondition> userIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'userId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedUserPermissions, CachedUserPermissions,
      QAfterFilterCondition> userIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'userId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedUserPermissions, CachedUserPermissions,
      QAfterFilterCondition> userIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'userId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedUserPermissions, CachedUserPermissions,
      QAfterFilterCondition> userIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'userId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedUserPermissions, CachedUserPermissions,
      QAfterFilterCondition> userIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'userId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedUserPermissions, CachedUserPermissions,
          QAfterFilterCondition>
      userIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'userId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedUserPermissions, CachedUserPermissions,
          QAfterFilterCondition>
      userIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'userId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedUserPermissions, CachedUserPermissions,
      QAfterFilterCondition> userIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'userId',
        value: '',
      ));
    });
  }

  QueryBuilder<CachedUserPermissions, CachedUserPermissions,
      QAfterFilterCondition> userIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'userId',
        value: '',
      ));
    });
  }
}

extension CachedUserPermissionsQueryObject on QueryBuilder<
    CachedUserPermissions, CachedUserPermissions, QFilterCondition> {}

extension CachedUserPermissionsQueryLinks on QueryBuilder<CachedUserPermissions,
    CachedUserPermissions, QFilterCondition> {}

extension CachedUserPermissionsQuerySortBy
    on QueryBuilder<CachedUserPermissions, CachedUserPermissions, QSortBy> {
  QueryBuilder<CachedUserPermissions, CachedUserPermissions, QAfterSortBy>
      sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<CachedUserPermissions, CachedUserPermissions, QAfterSortBy>
      sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<CachedUserPermissions, CachedUserPermissions, QAfterSortBy>
      sortByExpiresAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'expiresAt', Sort.asc);
    });
  }

  QueryBuilder<CachedUserPermissions, CachedUserPermissions, QAfterSortBy>
      sortByExpiresAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'expiresAt', Sort.desc);
    });
  }

  QueryBuilder<CachedUserPermissions, CachedUserPermissions, QAfterSortBy>
      sortByIsExpired() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isExpired', Sort.asc);
    });
  }

  QueryBuilder<CachedUserPermissions, CachedUserPermissions, QAfterSortBy>
      sortByIsExpiredDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isExpired', Sort.desc);
    });
  }

  QueryBuilder<CachedUserPermissions, CachedUserPermissions, QAfterSortBy>
      sortByOrganizationId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'organizationId', Sort.asc);
    });
  }

  QueryBuilder<CachedUserPermissions, CachedUserPermissions, QAfterSortBy>
      sortByOrganizationIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'organizationId', Sort.desc);
    });
  }

  QueryBuilder<CachedUserPermissions, CachedUserPermissions, QAfterSortBy>
      sortByRoleLevel() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'roleLevel', Sort.asc);
    });
  }

  QueryBuilder<CachedUserPermissions, CachedUserPermissions, QAfterSortBy>
      sortByRoleLevelDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'roleLevel', Sort.desc);
    });
  }

  QueryBuilder<CachedUserPermissions, CachedUserPermissions, QAfterSortBy>
      sortByUserId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.asc);
    });
  }

  QueryBuilder<CachedUserPermissions, CachedUserPermissions, QAfterSortBy>
      sortByUserIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.desc);
    });
  }
}

extension CachedUserPermissionsQuerySortThenBy
    on QueryBuilder<CachedUserPermissions, CachedUserPermissions, QSortThenBy> {
  QueryBuilder<CachedUserPermissions, CachedUserPermissions, QAfterSortBy>
      thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<CachedUserPermissions, CachedUserPermissions, QAfterSortBy>
      thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<CachedUserPermissions, CachedUserPermissions, QAfterSortBy>
      thenByExpiresAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'expiresAt', Sort.asc);
    });
  }

  QueryBuilder<CachedUserPermissions, CachedUserPermissions, QAfterSortBy>
      thenByExpiresAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'expiresAt', Sort.desc);
    });
  }

  QueryBuilder<CachedUserPermissions, CachedUserPermissions, QAfterSortBy>
      thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<CachedUserPermissions, CachedUserPermissions, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<CachedUserPermissions, CachedUserPermissions, QAfterSortBy>
      thenByIsExpired() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isExpired', Sort.asc);
    });
  }

  QueryBuilder<CachedUserPermissions, CachedUserPermissions, QAfterSortBy>
      thenByIsExpiredDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isExpired', Sort.desc);
    });
  }

  QueryBuilder<CachedUserPermissions, CachedUserPermissions, QAfterSortBy>
      thenByOrganizationId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'organizationId', Sort.asc);
    });
  }

  QueryBuilder<CachedUserPermissions, CachedUserPermissions, QAfterSortBy>
      thenByOrganizationIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'organizationId', Sort.desc);
    });
  }

  QueryBuilder<CachedUserPermissions, CachedUserPermissions, QAfterSortBy>
      thenByRoleLevel() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'roleLevel', Sort.asc);
    });
  }

  QueryBuilder<CachedUserPermissions, CachedUserPermissions, QAfterSortBy>
      thenByRoleLevelDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'roleLevel', Sort.desc);
    });
  }

  QueryBuilder<CachedUserPermissions, CachedUserPermissions, QAfterSortBy>
      thenByUserId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.asc);
    });
  }

  QueryBuilder<CachedUserPermissions, CachedUserPermissions, QAfterSortBy>
      thenByUserIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.desc);
    });
  }
}

extension CachedUserPermissionsQueryWhereDistinct
    on QueryBuilder<CachedUserPermissions, CachedUserPermissions, QDistinct> {
  QueryBuilder<CachedUserPermissions, CachedUserPermissions, QDistinct>
      distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt');
    });
  }

  QueryBuilder<CachedUserPermissions, CachedUserPermissions, QDistinct>
      distinctByExpiresAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'expiresAt');
    });
  }

  QueryBuilder<CachedUserPermissions, CachedUserPermissions, QDistinct>
      distinctByIsExpired() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isExpired');
    });
  }

  QueryBuilder<CachedUserPermissions, CachedUserPermissions, QDistinct>
      distinctByOrganizationId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'organizationId',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CachedUserPermissions, CachedUserPermissions, QDistinct>
      distinctByPermissions() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'permissions');
    });
  }

  QueryBuilder<CachedUserPermissions, CachedUserPermissions, QDistinct>
      distinctByRoleLevel({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'roleLevel', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CachedUserPermissions, CachedUserPermissions, QDistinct>
      distinctByUserId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'userId', caseSensitive: caseSensitive);
    });
  }
}

extension CachedUserPermissionsQueryProperty on QueryBuilder<
    CachedUserPermissions, CachedUserPermissions, QQueryProperty> {
  QueryBuilder<CachedUserPermissions, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<CachedUserPermissions, DateTime, QQueryOperations>
      createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<CachedUserPermissions, DateTime, QQueryOperations>
      expiresAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'expiresAt');
    });
  }

  QueryBuilder<CachedUserPermissions, bool, QQueryOperations>
      isExpiredProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isExpired');
    });
  }

  QueryBuilder<CachedUserPermissions, String?, QQueryOperations>
      organizationIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'organizationId');
    });
  }

  QueryBuilder<CachedUserPermissions, List<String>, QQueryOperations>
      permissionsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'permissions');
    });
  }

  QueryBuilder<CachedUserPermissions, String?, QQueryOperations>
      roleLevelProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'roleLevel');
    });
  }

  QueryBuilder<CachedUserPermissions, String, QQueryOperations>
      userIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'userId');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetCachedDashboardCollection on Isar {
  IsarCollection<CachedDashboard> get cachedDashboards => this.collection();
}

const CachedDashboardSchema = CollectionSchema(
  name: r'CachedDashboard',
  id: -5136382384826887534,
  properties: {
    r'createdAt': PropertySchema(
      id: 0,
      name: r'createdAt',
      type: IsarType.dateTime,
    ),
    r'dashboardJson': PropertySchema(
      id: 1,
      name: r'dashboardJson',
      type: IsarType.string,
    ),
    r'dashboardVersion': PropertySchema(
      id: 2,
      name: r'dashboardVersion',
      type: IsarType.string,
    ),
    r'expiresAt': PropertySchema(
      id: 3,
      name: r'expiresAt',
      type: IsarType.dateTime,
    ),
    r'isCustomized': PropertySchema(
      id: 4,
      name: r'isCustomized',
      type: IsarType.bool,
    ),
    r'isExpired': PropertySchema(
      id: 5,
      name: r'isExpired',
      type: IsarType.bool,
    ),
    r'organizationId': PropertySchema(
      id: 6,
      name: r'organizationId',
      type: IsarType.string,
    ),
    r'userId': PropertySchema(
      id: 7,
      name: r'userId',
      type: IsarType.string,
    )
  },
  estimateSize: _cachedDashboardEstimateSize,
  serialize: _cachedDashboardSerialize,
  deserialize: _cachedDashboardDeserialize,
  deserializeProp: _cachedDashboardDeserializeProp,
  idName: r'id',
  indexes: {
    r'userId': IndexSchema(
      id: -2005826577402374815,
      name: r'userId',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'userId',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
    r'createdAt': IndexSchema(
      id: -3433535483987302584,
      name: r'createdAt',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'createdAt',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _cachedDashboardGetId,
  getLinks: _cachedDashboardGetLinks,
  attach: _cachedDashboardAttach,
  version: '3.1.0+1',
);

int _cachedDashboardEstimateSize(
  CachedDashboard object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.dashboardJson.length * 3;
  {
    final value = object.dashboardVersion;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.organizationId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.userId.length * 3;
  return bytesCount;
}

void _cachedDashboardSerialize(
  CachedDashboard object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDateTime(offsets[0], object.createdAt);
  writer.writeString(offsets[1], object.dashboardJson);
  writer.writeString(offsets[2], object.dashboardVersion);
  writer.writeDateTime(offsets[3], object.expiresAt);
  writer.writeBool(offsets[4], object.isCustomized);
  writer.writeBool(offsets[5], object.isExpired);
  writer.writeString(offsets[6], object.organizationId);
  writer.writeString(offsets[7], object.userId);
}

CachedDashboard _cachedDashboardDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = CachedDashboard();
  object.createdAt = reader.readDateTime(offsets[0]);
  object.dashboardJson = reader.readString(offsets[1]);
  object.dashboardVersion = reader.readStringOrNull(offsets[2]);
  object.expiresAt = reader.readDateTime(offsets[3]);
  object.id = id;
  object.isCustomized = reader.readBool(offsets[4]);
  object.organizationId = reader.readStringOrNull(offsets[6]);
  object.userId = reader.readString(offsets[7]);
  return object;
}

P _cachedDashboardDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDateTime(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    case 3:
      return (reader.readDateTime(offset)) as P;
    case 4:
      return (reader.readBool(offset)) as P;
    case 5:
      return (reader.readBool(offset)) as P;
    case 6:
      return (reader.readStringOrNull(offset)) as P;
    case 7:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _cachedDashboardGetId(CachedDashboard object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _cachedDashboardGetLinks(CachedDashboard object) {
  return [];
}

void _cachedDashboardAttach(
    IsarCollection<dynamic> col, Id id, CachedDashboard object) {
  object.id = id;
}

extension CachedDashboardQueryWhereSort
    on QueryBuilder<CachedDashboard, CachedDashboard, QWhere> {
  QueryBuilder<CachedDashboard, CachedDashboard, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<CachedDashboard, CachedDashboard, QAfterWhere> anyCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'createdAt'),
      );
    });
  }
}

extension CachedDashboardQueryWhere
    on QueryBuilder<CachedDashboard, CachedDashboard, QWhereClause> {
  QueryBuilder<CachedDashboard, CachedDashboard, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<CachedDashboard, CachedDashboard, QAfterWhereClause>
      idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<CachedDashboard, CachedDashboard, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<CachedDashboard, CachedDashboard, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<CachedDashboard, CachedDashboard, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CachedDashboard, CachedDashboard, QAfterWhereClause>
      userIdEqualTo(String userId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'userId',
        value: [userId],
      ));
    });
  }

  QueryBuilder<CachedDashboard, CachedDashboard, QAfterWhereClause>
      userIdNotEqualTo(String userId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'userId',
              lower: [],
              upper: [userId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'userId',
              lower: [userId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'userId',
              lower: [userId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'userId',
              lower: [],
              upper: [userId],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<CachedDashboard, CachedDashboard, QAfterWhereClause>
      createdAtEqualTo(DateTime createdAt) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'createdAt',
        value: [createdAt],
      ));
    });
  }

  QueryBuilder<CachedDashboard, CachedDashboard, QAfterWhereClause>
      createdAtNotEqualTo(DateTime createdAt) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'createdAt',
              lower: [],
              upper: [createdAt],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'createdAt',
              lower: [createdAt],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'createdAt',
              lower: [createdAt],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'createdAt',
              lower: [],
              upper: [createdAt],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<CachedDashboard, CachedDashboard, QAfterWhereClause>
      createdAtGreaterThan(
    DateTime createdAt, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'createdAt',
        lower: [createdAt],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<CachedDashboard, CachedDashboard, QAfterWhereClause>
      createdAtLessThan(
    DateTime createdAt, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'createdAt',
        lower: [],
        upper: [createdAt],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<CachedDashboard, CachedDashboard, QAfterWhereClause>
      createdAtBetween(
    DateTime lowerCreatedAt,
    DateTime upperCreatedAt, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'createdAt',
        lower: [lowerCreatedAt],
        includeLower: includeLower,
        upper: [upperCreatedAt],
        includeUpper: includeUpper,
      ));
    });
  }
}

extension CachedDashboardQueryFilter
    on QueryBuilder<CachedDashboard, CachedDashboard, QFilterCondition> {
  QueryBuilder<CachedDashboard, CachedDashboard, QAfterFilterCondition>
      createdAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<CachedDashboard, CachedDashboard, QAfterFilterCondition>
      createdAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<CachedDashboard, CachedDashboard, QAfterFilterCondition>
      createdAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<CachedDashboard, CachedDashboard, QAfterFilterCondition>
      createdAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'createdAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CachedDashboard, CachedDashboard, QAfterFilterCondition>
      dashboardJsonEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dashboardJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedDashboard, CachedDashboard, QAfterFilterCondition>
      dashboardJsonGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'dashboardJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedDashboard, CachedDashboard, QAfterFilterCondition>
      dashboardJsonLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'dashboardJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedDashboard, CachedDashboard, QAfterFilterCondition>
      dashboardJsonBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'dashboardJson',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedDashboard, CachedDashboard, QAfterFilterCondition>
      dashboardJsonStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'dashboardJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedDashboard, CachedDashboard, QAfterFilterCondition>
      dashboardJsonEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'dashboardJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedDashboard, CachedDashboard, QAfterFilterCondition>
      dashboardJsonContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'dashboardJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedDashboard, CachedDashboard, QAfterFilterCondition>
      dashboardJsonMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'dashboardJson',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedDashboard, CachedDashboard, QAfterFilterCondition>
      dashboardJsonIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dashboardJson',
        value: '',
      ));
    });
  }

  QueryBuilder<CachedDashboard, CachedDashboard, QAfterFilterCondition>
      dashboardJsonIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'dashboardJson',
        value: '',
      ));
    });
  }

  QueryBuilder<CachedDashboard, CachedDashboard, QAfterFilterCondition>
      dashboardVersionIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'dashboardVersion',
      ));
    });
  }

  QueryBuilder<CachedDashboard, CachedDashboard, QAfterFilterCondition>
      dashboardVersionIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'dashboardVersion',
      ));
    });
  }

  QueryBuilder<CachedDashboard, CachedDashboard, QAfterFilterCondition>
      dashboardVersionEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dashboardVersion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedDashboard, CachedDashboard, QAfterFilterCondition>
      dashboardVersionGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'dashboardVersion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedDashboard, CachedDashboard, QAfterFilterCondition>
      dashboardVersionLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'dashboardVersion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedDashboard, CachedDashboard, QAfterFilterCondition>
      dashboardVersionBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'dashboardVersion',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedDashboard, CachedDashboard, QAfterFilterCondition>
      dashboardVersionStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'dashboardVersion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedDashboard, CachedDashboard, QAfterFilterCondition>
      dashboardVersionEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'dashboardVersion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedDashboard, CachedDashboard, QAfterFilterCondition>
      dashboardVersionContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'dashboardVersion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedDashboard, CachedDashboard, QAfterFilterCondition>
      dashboardVersionMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'dashboardVersion',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedDashboard, CachedDashboard, QAfterFilterCondition>
      dashboardVersionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dashboardVersion',
        value: '',
      ));
    });
  }

  QueryBuilder<CachedDashboard, CachedDashboard, QAfterFilterCondition>
      dashboardVersionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'dashboardVersion',
        value: '',
      ));
    });
  }

  QueryBuilder<CachedDashboard, CachedDashboard, QAfterFilterCondition>
      expiresAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'expiresAt',
        value: value,
      ));
    });
  }

  QueryBuilder<CachedDashboard, CachedDashboard, QAfterFilterCondition>
      expiresAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'expiresAt',
        value: value,
      ));
    });
  }

  QueryBuilder<CachedDashboard, CachedDashboard, QAfterFilterCondition>
      expiresAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'expiresAt',
        value: value,
      ));
    });
  }

  QueryBuilder<CachedDashboard, CachedDashboard, QAfterFilterCondition>
      expiresAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'expiresAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CachedDashboard, CachedDashboard, QAfterFilterCondition>
      idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<CachedDashboard, CachedDashboard, QAfterFilterCondition>
      idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<CachedDashboard, CachedDashboard, QAfterFilterCondition>
      idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<CachedDashboard, CachedDashboard, QAfterFilterCondition>
      idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CachedDashboard, CachedDashboard, QAfterFilterCondition>
      isCustomizedEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isCustomized',
        value: value,
      ));
    });
  }

  QueryBuilder<CachedDashboard, CachedDashboard, QAfterFilterCondition>
      isExpiredEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isExpired',
        value: value,
      ));
    });
  }

  QueryBuilder<CachedDashboard, CachedDashboard, QAfterFilterCondition>
      organizationIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'organizationId',
      ));
    });
  }

  QueryBuilder<CachedDashboard, CachedDashboard, QAfterFilterCondition>
      organizationIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'organizationId',
      ));
    });
  }

  QueryBuilder<CachedDashboard, CachedDashboard, QAfterFilterCondition>
      organizationIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'organizationId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedDashboard, CachedDashboard, QAfterFilterCondition>
      organizationIdGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'organizationId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedDashboard, CachedDashboard, QAfterFilterCondition>
      organizationIdLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'organizationId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedDashboard, CachedDashboard, QAfterFilterCondition>
      organizationIdBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'organizationId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedDashboard, CachedDashboard, QAfterFilterCondition>
      organizationIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'organizationId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedDashboard, CachedDashboard, QAfterFilterCondition>
      organizationIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'organizationId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedDashboard, CachedDashboard, QAfterFilterCondition>
      organizationIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'organizationId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedDashboard, CachedDashboard, QAfterFilterCondition>
      organizationIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'organizationId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedDashboard, CachedDashboard, QAfterFilterCondition>
      organizationIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'organizationId',
        value: '',
      ));
    });
  }

  QueryBuilder<CachedDashboard, CachedDashboard, QAfterFilterCondition>
      organizationIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'organizationId',
        value: '',
      ));
    });
  }

  QueryBuilder<CachedDashboard, CachedDashboard, QAfterFilterCondition>
      userIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'userId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedDashboard, CachedDashboard, QAfterFilterCondition>
      userIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'userId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedDashboard, CachedDashboard, QAfterFilterCondition>
      userIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'userId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedDashboard, CachedDashboard, QAfterFilterCondition>
      userIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'userId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedDashboard, CachedDashboard, QAfterFilterCondition>
      userIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'userId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedDashboard, CachedDashboard, QAfterFilterCondition>
      userIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'userId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedDashboard, CachedDashboard, QAfterFilterCondition>
      userIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'userId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedDashboard, CachedDashboard, QAfterFilterCondition>
      userIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'userId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedDashboard, CachedDashboard, QAfterFilterCondition>
      userIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'userId',
        value: '',
      ));
    });
  }

  QueryBuilder<CachedDashboard, CachedDashboard, QAfterFilterCondition>
      userIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'userId',
        value: '',
      ));
    });
  }
}

extension CachedDashboardQueryObject
    on QueryBuilder<CachedDashboard, CachedDashboard, QFilterCondition> {}

extension CachedDashboardQueryLinks
    on QueryBuilder<CachedDashboard, CachedDashboard, QFilterCondition> {}

extension CachedDashboardQuerySortBy
    on QueryBuilder<CachedDashboard, CachedDashboard, QSortBy> {
  QueryBuilder<CachedDashboard, CachedDashboard, QAfterSortBy>
      sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<CachedDashboard, CachedDashboard, QAfterSortBy>
      sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<CachedDashboard, CachedDashboard, QAfterSortBy>
      sortByDashboardJson() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dashboardJson', Sort.asc);
    });
  }

  QueryBuilder<CachedDashboard, CachedDashboard, QAfterSortBy>
      sortByDashboardJsonDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dashboardJson', Sort.desc);
    });
  }

  QueryBuilder<CachedDashboard, CachedDashboard, QAfterSortBy>
      sortByDashboardVersion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dashboardVersion', Sort.asc);
    });
  }

  QueryBuilder<CachedDashboard, CachedDashboard, QAfterSortBy>
      sortByDashboardVersionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dashboardVersion', Sort.desc);
    });
  }

  QueryBuilder<CachedDashboard, CachedDashboard, QAfterSortBy>
      sortByExpiresAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'expiresAt', Sort.asc);
    });
  }

  QueryBuilder<CachedDashboard, CachedDashboard, QAfterSortBy>
      sortByExpiresAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'expiresAt', Sort.desc);
    });
  }

  QueryBuilder<CachedDashboard, CachedDashboard, QAfterSortBy>
      sortByIsCustomized() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCustomized', Sort.asc);
    });
  }

  QueryBuilder<CachedDashboard, CachedDashboard, QAfterSortBy>
      sortByIsCustomizedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCustomized', Sort.desc);
    });
  }

  QueryBuilder<CachedDashboard, CachedDashboard, QAfterSortBy>
      sortByIsExpired() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isExpired', Sort.asc);
    });
  }

  QueryBuilder<CachedDashboard, CachedDashboard, QAfterSortBy>
      sortByIsExpiredDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isExpired', Sort.desc);
    });
  }

  QueryBuilder<CachedDashboard, CachedDashboard, QAfterSortBy>
      sortByOrganizationId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'organizationId', Sort.asc);
    });
  }

  QueryBuilder<CachedDashboard, CachedDashboard, QAfterSortBy>
      sortByOrganizationIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'organizationId', Sort.desc);
    });
  }

  QueryBuilder<CachedDashboard, CachedDashboard, QAfterSortBy> sortByUserId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.asc);
    });
  }

  QueryBuilder<CachedDashboard, CachedDashboard, QAfterSortBy>
      sortByUserIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.desc);
    });
  }
}

extension CachedDashboardQuerySortThenBy
    on QueryBuilder<CachedDashboard, CachedDashboard, QSortThenBy> {
  QueryBuilder<CachedDashboard, CachedDashboard, QAfterSortBy>
      thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<CachedDashboard, CachedDashboard, QAfterSortBy>
      thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<CachedDashboard, CachedDashboard, QAfterSortBy>
      thenByDashboardJson() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dashboardJson', Sort.asc);
    });
  }

  QueryBuilder<CachedDashboard, CachedDashboard, QAfterSortBy>
      thenByDashboardJsonDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dashboardJson', Sort.desc);
    });
  }

  QueryBuilder<CachedDashboard, CachedDashboard, QAfterSortBy>
      thenByDashboardVersion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dashboardVersion', Sort.asc);
    });
  }

  QueryBuilder<CachedDashboard, CachedDashboard, QAfterSortBy>
      thenByDashboardVersionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dashboardVersion', Sort.desc);
    });
  }

  QueryBuilder<CachedDashboard, CachedDashboard, QAfterSortBy>
      thenByExpiresAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'expiresAt', Sort.asc);
    });
  }

  QueryBuilder<CachedDashboard, CachedDashboard, QAfterSortBy>
      thenByExpiresAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'expiresAt', Sort.desc);
    });
  }

  QueryBuilder<CachedDashboard, CachedDashboard, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<CachedDashboard, CachedDashboard, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<CachedDashboard, CachedDashboard, QAfterSortBy>
      thenByIsCustomized() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCustomized', Sort.asc);
    });
  }

  QueryBuilder<CachedDashboard, CachedDashboard, QAfterSortBy>
      thenByIsCustomizedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCustomized', Sort.desc);
    });
  }

  QueryBuilder<CachedDashboard, CachedDashboard, QAfterSortBy>
      thenByIsExpired() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isExpired', Sort.asc);
    });
  }

  QueryBuilder<CachedDashboard, CachedDashboard, QAfterSortBy>
      thenByIsExpiredDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isExpired', Sort.desc);
    });
  }

  QueryBuilder<CachedDashboard, CachedDashboard, QAfterSortBy>
      thenByOrganizationId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'organizationId', Sort.asc);
    });
  }

  QueryBuilder<CachedDashboard, CachedDashboard, QAfterSortBy>
      thenByOrganizationIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'organizationId', Sort.desc);
    });
  }

  QueryBuilder<CachedDashboard, CachedDashboard, QAfterSortBy> thenByUserId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.asc);
    });
  }

  QueryBuilder<CachedDashboard, CachedDashboard, QAfterSortBy>
      thenByUserIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.desc);
    });
  }
}

extension CachedDashboardQueryWhereDistinct
    on QueryBuilder<CachedDashboard, CachedDashboard, QDistinct> {
  QueryBuilder<CachedDashboard, CachedDashboard, QDistinct>
      distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt');
    });
  }

  QueryBuilder<CachedDashboard, CachedDashboard, QDistinct>
      distinctByDashboardJson({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dashboardJson',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CachedDashboard, CachedDashboard, QDistinct>
      distinctByDashboardVersion({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dashboardVersion',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CachedDashboard, CachedDashboard, QDistinct>
      distinctByExpiresAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'expiresAt');
    });
  }

  QueryBuilder<CachedDashboard, CachedDashboard, QDistinct>
      distinctByIsCustomized() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isCustomized');
    });
  }

  QueryBuilder<CachedDashboard, CachedDashboard, QDistinct>
      distinctByIsExpired() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isExpired');
    });
  }

  QueryBuilder<CachedDashboard, CachedDashboard, QDistinct>
      distinctByOrganizationId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'organizationId',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CachedDashboard, CachedDashboard, QDistinct> distinctByUserId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'userId', caseSensitive: caseSensitive);
    });
  }
}

extension CachedDashboardQueryProperty
    on QueryBuilder<CachedDashboard, CachedDashboard, QQueryProperty> {
  QueryBuilder<CachedDashboard, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<CachedDashboard, DateTime, QQueryOperations>
      createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<CachedDashboard, String, QQueryOperations>
      dashboardJsonProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dashboardJson');
    });
  }

  QueryBuilder<CachedDashboard, String?, QQueryOperations>
      dashboardVersionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dashboardVersion');
    });
  }

  QueryBuilder<CachedDashboard, DateTime, QQueryOperations>
      expiresAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'expiresAt');
    });
  }

  QueryBuilder<CachedDashboard, bool, QQueryOperations> isCustomizedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isCustomized');
    });
  }

  QueryBuilder<CachedDashboard, bool, QQueryOperations> isExpiredProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isExpired');
    });
  }

  QueryBuilder<CachedDashboard, String?, QQueryOperations>
      organizationIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'organizationId');
    });
  }

  QueryBuilder<CachedDashboard, String, QQueryOperations> userIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'userId');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetCachedWidgetDataCollection on Isar {
  IsarCollection<CachedWidgetData> get cachedWidgetDatas => this.collection();
}

const CachedWidgetDataSchema = CollectionSchema(
  name: r'CachedWidgetData',
  id: 5768761887873958614,
  properties: {
    r'createdAt': PropertySchema(
      id: 0,
      name: r'createdAt',
      type: IsarType.dateTime,
    ),
    r'dataJson': PropertySchema(
      id: 1,
      name: r'dataJson',
      type: IsarType.string,
    ),
    r'equipmentId': PropertySchema(
      id: 2,
      name: r'equipmentId',
      type: IsarType.string,
    ),
    r'expiresAt': PropertySchema(
      id: 3,
      name: r'expiresAt',
      type: IsarType.dateTime,
    ),
    r'isExpired': PropertySchema(
      id: 4,
      name: r'isExpired',
      type: IsarType.bool,
    ),
    r'isRealTime': PropertySchema(
      id: 5,
      name: r'isRealTime',
      type: IsarType.bool,
    ),
    r'userId': PropertySchema(
      id: 6,
      name: r'userId',
      type: IsarType.string,
    ),
    r'widgetId': PropertySchema(
      id: 7,
      name: r'widgetId',
      type: IsarType.string,
    ),
    r'widgetType': PropertySchema(
      id: 8,
      name: r'widgetType',
      type: IsarType.string,
    )
  },
  estimateSize: _cachedWidgetDataEstimateSize,
  serialize: _cachedWidgetDataSerialize,
  deserialize: _cachedWidgetDataDeserialize,
  deserializeProp: _cachedWidgetDataDeserializeProp,
  idName: r'id',
  indexes: {
    r'widgetId': IndexSchema(
      id: 6892687480849298006,
      name: r'widgetId',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'widgetId',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
    r'userId': IndexSchema(
      id: -2005826577402374815,
      name: r'userId',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'userId',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
    r'createdAt': IndexSchema(
      id: -3433535483987302584,
      name: r'createdAt',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'createdAt',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _cachedWidgetDataGetId,
  getLinks: _cachedWidgetDataGetLinks,
  attach: _cachedWidgetDataAttach,
  version: '3.1.0+1',
);

int _cachedWidgetDataEstimateSize(
  CachedWidgetData object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.dataJson.length * 3;
  {
    final value = object.equipmentId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.userId.length * 3;
  bytesCount += 3 + object.widgetId.length * 3;
  bytesCount += 3 + object.widgetType.length * 3;
  return bytesCount;
}

void _cachedWidgetDataSerialize(
  CachedWidgetData object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDateTime(offsets[0], object.createdAt);
  writer.writeString(offsets[1], object.dataJson);
  writer.writeString(offsets[2], object.equipmentId);
  writer.writeDateTime(offsets[3], object.expiresAt);
  writer.writeBool(offsets[4], object.isExpired);
  writer.writeBool(offsets[5], object.isRealTime);
  writer.writeString(offsets[6], object.userId);
  writer.writeString(offsets[7], object.widgetId);
  writer.writeString(offsets[8], object.widgetType);
}

CachedWidgetData _cachedWidgetDataDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = CachedWidgetData();
  object.createdAt = reader.readDateTime(offsets[0]);
  object.dataJson = reader.readString(offsets[1]);
  object.equipmentId = reader.readStringOrNull(offsets[2]);
  object.expiresAt = reader.readDateTime(offsets[3]);
  object.id = id;
  object.isRealTime = reader.readBool(offsets[5]);
  object.userId = reader.readString(offsets[6]);
  object.widgetId = reader.readString(offsets[7]);
  object.widgetType = reader.readString(offsets[8]);
  return object;
}

P _cachedWidgetDataDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDateTime(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    case 3:
      return (reader.readDateTime(offset)) as P;
    case 4:
      return (reader.readBool(offset)) as P;
    case 5:
      return (reader.readBool(offset)) as P;
    case 6:
      return (reader.readString(offset)) as P;
    case 7:
      return (reader.readString(offset)) as P;
    case 8:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _cachedWidgetDataGetId(CachedWidgetData object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _cachedWidgetDataGetLinks(CachedWidgetData object) {
  return [];
}

void _cachedWidgetDataAttach(
    IsarCollection<dynamic> col, Id id, CachedWidgetData object) {
  object.id = id;
}

extension CachedWidgetDataQueryWhereSort
    on QueryBuilder<CachedWidgetData, CachedWidgetData, QWhere> {
  QueryBuilder<CachedWidgetData, CachedWidgetData, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<CachedWidgetData, CachedWidgetData, QAfterWhere> anyCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'createdAt'),
      );
    });
  }
}

extension CachedWidgetDataQueryWhere
    on QueryBuilder<CachedWidgetData, CachedWidgetData, QWhereClause> {
  QueryBuilder<CachedWidgetData, CachedWidgetData, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<CachedWidgetData, CachedWidgetData, QAfterWhereClause>
      idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<CachedWidgetData, CachedWidgetData, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<CachedWidgetData, CachedWidgetData, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<CachedWidgetData, CachedWidgetData, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CachedWidgetData, CachedWidgetData, QAfterWhereClause>
      widgetIdEqualTo(String widgetId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'widgetId',
        value: [widgetId],
      ));
    });
  }

  QueryBuilder<CachedWidgetData, CachedWidgetData, QAfterWhereClause>
      widgetIdNotEqualTo(String widgetId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'widgetId',
              lower: [],
              upper: [widgetId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'widgetId',
              lower: [widgetId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'widgetId',
              lower: [widgetId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'widgetId',
              lower: [],
              upper: [widgetId],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<CachedWidgetData, CachedWidgetData, QAfterWhereClause>
      userIdEqualTo(String userId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'userId',
        value: [userId],
      ));
    });
  }

  QueryBuilder<CachedWidgetData, CachedWidgetData, QAfterWhereClause>
      userIdNotEqualTo(String userId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'userId',
              lower: [],
              upper: [userId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'userId',
              lower: [userId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'userId',
              lower: [userId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'userId',
              lower: [],
              upper: [userId],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<CachedWidgetData, CachedWidgetData, QAfterWhereClause>
      createdAtEqualTo(DateTime createdAt) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'createdAt',
        value: [createdAt],
      ));
    });
  }

  QueryBuilder<CachedWidgetData, CachedWidgetData, QAfterWhereClause>
      createdAtNotEqualTo(DateTime createdAt) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'createdAt',
              lower: [],
              upper: [createdAt],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'createdAt',
              lower: [createdAt],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'createdAt',
              lower: [createdAt],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'createdAt',
              lower: [],
              upper: [createdAt],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<CachedWidgetData, CachedWidgetData, QAfterWhereClause>
      createdAtGreaterThan(
    DateTime createdAt, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'createdAt',
        lower: [createdAt],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<CachedWidgetData, CachedWidgetData, QAfterWhereClause>
      createdAtLessThan(
    DateTime createdAt, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'createdAt',
        lower: [],
        upper: [createdAt],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<CachedWidgetData, CachedWidgetData, QAfterWhereClause>
      createdAtBetween(
    DateTime lowerCreatedAt,
    DateTime upperCreatedAt, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'createdAt',
        lower: [lowerCreatedAt],
        includeLower: includeLower,
        upper: [upperCreatedAt],
        includeUpper: includeUpper,
      ));
    });
  }
}

extension CachedWidgetDataQueryFilter
    on QueryBuilder<CachedWidgetData, CachedWidgetData, QFilterCondition> {
  QueryBuilder<CachedWidgetData, CachedWidgetData, QAfterFilterCondition>
      createdAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<CachedWidgetData, CachedWidgetData, QAfterFilterCondition>
      createdAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<CachedWidgetData, CachedWidgetData, QAfterFilterCondition>
      createdAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<CachedWidgetData, CachedWidgetData, QAfterFilterCondition>
      createdAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'createdAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CachedWidgetData, CachedWidgetData, QAfterFilterCondition>
      dataJsonEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dataJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedWidgetData, CachedWidgetData, QAfterFilterCondition>
      dataJsonGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'dataJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedWidgetData, CachedWidgetData, QAfterFilterCondition>
      dataJsonLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'dataJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedWidgetData, CachedWidgetData, QAfterFilterCondition>
      dataJsonBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'dataJson',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedWidgetData, CachedWidgetData, QAfterFilterCondition>
      dataJsonStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'dataJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedWidgetData, CachedWidgetData, QAfterFilterCondition>
      dataJsonEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'dataJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedWidgetData, CachedWidgetData, QAfterFilterCondition>
      dataJsonContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'dataJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedWidgetData, CachedWidgetData, QAfterFilterCondition>
      dataJsonMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'dataJson',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedWidgetData, CachedWidgetData, QAfterFilterCondition>
      dataJsonIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dataJson',
        value: '',
      ));
    });
  }

  QueryBuilder<CachedWidgetData, CachedWidgetData, QAfterFilterCondition>
      dataJsonIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'dataJson',
        value: '',
      ));
    });
  }

  QueryBuilder<CachedWidgetData, CachedWidgetData, QAfterFilterCondition>
      equipmentIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'equipmentId',
      ));
    });
  }

  QueryBuilder<CachedWidgetData, CachedWidgetData, QAfterFilterCondition>
      equipmentIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'equipmentId',
      ));
    });
  }

  QueryBuilder<CachedWidgetData, CachedWidgetData, QAfterFilterCondition>
      equipmentIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'equipmentId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedWidgetData, CachedWidgetData, QAfterFilterCondition>
      equipmentIdGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'equipmentId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedWidgetData, CachedWidgetData, QAfterFilterCondition>
      equipmentIdLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'equipmentId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedWidgetData, CachedWidgetData, QAfterFilterCondition>
      equipmentIdBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'equipmentId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedWidgetData, CachedWidgetData, QAfterFilterCondition>
      equipmentIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'equipmentId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedWidgetData, CachedWidgetData, QAfterFilterCondition>
      equipmentIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'equipmentId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedWidgetData, CachedWidgetData, QAfterFilterCondition>
      equipmentIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'equipmentId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedWidgetData, CachedWidgetData, QAfterFilterCondition>
      equipmentIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'equipmentId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedWidgetData, CachedWidgetData, QAfterFilterCondition>
      equipmentIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'equipmentId',
        value: '',
      ));
    });
  }

  QueryBuilder<CachedWidgetData, CachedWidgetData, QAfterFilterCondition>
      equipmentIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'equipmentId',
        value: '',
      ));
    });
  }

  QueryBuilder<CachedWidgetData, CachedWidgetData, QAfterFilterCondition>
      expiresAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'expiresAt',
        value: value,
      ));
    });
  }

  QueryBuilder<CachedWidgetData, CachedWidgetData, QAfterFilterCondition>
      expiresAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'expiresAt',
        value: value,
      ));
    });
  }

  QueryBuilder<CachedWidgetData, CachedWidgetData, QAfterFilterCondition>
      expiresAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'expiresAt',
        value: value,
      ));
    });
  }

  QueryBuilder<CachedWidgetData, CachedWidgetData, QAfterFilterCondition>
      expiresAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'expiresAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CachedWidgetData, CachedWidgetData, QAfterFilterCondition>
      idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<CachedWidgetData, CachedWidgetData, QAfterFilterCondition>
      idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<CachedWidgetData, CachedWidgetData, QAfterFilterCondition>
      idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<CachedWidgetData, CachedWidgetData, QAfterFilterCondition>
      idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CachedWidgetData, CachedWidgetData, QAfterFilterCondition>
      isExpiredEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isExpired',
        value: value,
      ));
    });
  }

  QueryBuilder<CachedWidgetData, CachedWidgetData, QAfterFilterCondition>
      isRealTimeEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isRealTime',
        value: value,
      ));
    });
  }

  QueryBuilder<CachedWidgetData, CachedWidgetData, QAfterFilterCondition>
      userIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'userId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedWidgetData, CachedWidgetData, QAfterFilterCondition>
      userIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'userId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedWidgetData, CachedWidgetData, QAfterFilterCondition>
      userIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'userId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedWidgetData, CachedWidgetData, QAfterFilterCondition>
      userIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'userId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedWidgetData, CachedWidgetData, QAfterFilterCondition>
      userIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'userId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedWidgetData, CachedWidgetData, QAfterFilterCondition>
      userIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'userId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedWidgetData, CachedWidgetData, QAfterFilterCondition>
      userIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'userId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedWidgetData, CachedWidgetData, QAfterFilterCondition>
      userIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'userId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedWidgetData, CachedWidgetData, QAfterFilterCondition>
      userIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'userId',
        value: '',
      ));
    });
  }

  QueryBuilder<CachedWidgetData, CachedWidgetData, QAfterFilterCondition>
      userIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'userId',
        value: '',
      ));
    });
  }

  QueryBuilder<CachedWidgetData, CachedWidgetData, QAfterFilterCondition>
      widgetIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'widgetId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedWidgetData, CachedWidgetData, QAfterFilterCondition>
      widgetIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'widgetId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedWidgetData, CachedWidgetData, QAfterFilterCondition>
      widgetIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'widgetId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedWidgetData, CachedWidgetData, QAfterFilterCondition>
      widgetIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'widgetId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedWidgetData, CachedWidgetData, QAfterFilterCondition>
      widgetIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'widgetId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedWidgetData, CachedWidgetData, QAfterFilterCondition>
      widgetIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'widgetId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedWidgetData, CachedWidgetData, QAfterFilterCondition>
      widgetIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'widgetId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedWidgetData, CachedWidgetData, QAfterFilterCondition>
      widgetIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'widgetId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedWidgetData, CachedWidgetData, QAfterFilterCondition>
      widgetIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'widgetId',
        value: '',
      ));
    });
  }

  QueryBuilder<CachedWidgetData, CachedWidgetData, QAfterFilterCondition>
      widgetIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'widgetId',
        value: '',
      ));
    });
  }

  QueryBuilder<CachedWidgetData, CachedWidgetData, QAfterFilterCondition>
      widgetTypeEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'widgetType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedWidgetData, CachedWidgetData, QAfterFilterCondition>
      widgetTypeGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'widgetType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedWidgetData, CachedWidgetData, QAfterFilterCondition>
      widgetTypeLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'widgetType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedWidgetData, CachedWidgetData, QAfterFilterCondition>
      widgetTypeBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'widgetType',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedWidgetData, CachedWidgetData, QAfterFilterCondition>
      widgetTypeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'widgetType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedWidgetData, CachedWidgetData, QAfterFilterCondition>
      widgetTypeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'widgetType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedWidgetData, CachedWidgetData, QAfterFilterCondition>
      widgetTypeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'widgetType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedWidgetData, CachedWidgetData, QAfterFilterCondition>
      widgetTypeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'widgetType',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedWidgetData, CachedWidgetData, QAfterFilterCondition>
      widgetTypeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'widgetType',
        value: '',
      ));
    });
  }

  QueryBuilder<CachedWidgetData, CachedWidgetData, QAfterFilterCondition>
      widgetTypeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'widgetType',
        value: '',
      ));
    });
  }
}

extension CachedWidgetDataQueryObject
    on QueryBuilder<CachedWidgetData, CachedWidgetData, QFilterCondition> {}

extension CachedWidgetDataQueryLinks
    on QueryBuilder<CachedWidgetData, CachedWidgetData, QFilterCondition> {}

extension CachedWidgetDataQuerySortBy
    on QueryBuilder<CachedWidgetData, CachedWidgetData, QSortBy> {
  QueryBuilder<CachedWidgetData, CachedWidgetData, QAfterSortBy>
      sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<CachedWidgetData, CachedWidgetData, QAfterSortBy>
      sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<CachedWidgetData, CachedWidgetData, QAfterSortBy>
      sortByDataJson() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dataJson', Sort.asc);
    });
  }

  QueryBuilder<CachedWidgetData, CachedWidgetData, QAfterSortBy>
      sortByDataJsonDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dataJson', Sort.desc);
    });
  }

  QueryBuilder<CachedWidgetData, CachedWidgetData, QAfterSortBy>
      sortByEquipmentId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'equipmentId', Sort.asc);
    });
  }

  QueryBuilder<CachedWidgetData, CachedWidgetData, QAfterSortBy>
      sortByEquipmentIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'equipmentId', Sort.desc);
    });
  }

  QueryBuilder<CachedWidgetData, CachedWidgetData, QAfterSortBy>
      sortByExpiresAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'expiresAt', Sort.asc);
    });
  }

  QueryBuilder<CachedWidgetData, CachedWidgetData, QAfterSortBy>
      sortByExpiresAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'expiresAt', Sort.desc);
    });
  }

  QueryBuilder<CachedWidgetData, CachedWidgetData, QAfterSortBy>
      sortByIsExpired() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isExpired', Sort.asc);
    });
  }

  QueryBuilder<CachedWidgetData, CachedWidgetData, QAfterSortBy>
      sortByIsExpiredDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isExpired', Sort.desc);
    });
  }

  QueryBuilder<CachedWidgetData, CachedWidgetData, QAfterSortBy>
      sortByIsRealTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isRealTime', Sort.asc);
    });
  }

  QueryBuilder<CachedWidgetData, CachedWidgetData, QAfterSortBy>
      sortByIsRealTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isRealTime', Sort.desc);
    });
  }

  QueryBuilder<CachedWidgetData, CachedWidgetData, QAfterSortBy>
      sortByUserId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.asc);
    });
  }

  QueryBuilder<CachedWidgetData, CachedWidgetData, QAfterSortBy>
      sortByUserIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.desc);
    });
  }

  QueryBuilder<CachedWidgetData, CachedWidgetData, QAfterSortBy>
      sortByWidgetId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'widgetId', Sort.asc);
    });
  }

  QueryBuilder<CachedWidgetData, CachedWidgetData, QAfterSortBy>
      sortByWidgetIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'widgetId', Sort.desc);
    });
  }

  QueryBuilder<CachedWidgetData, CachedWidgetData, QAfterSortBy>
      sortByWidgetType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'widgetType', Sort.asc);
    });
  }

  QueryBuilder<CachedWidgetData, CachedWidgetData, QAfterSortBy>
      sortByWidgetTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'widgetType', Sort.desc);
    });
  }
}

extension CachedWidgetDataQuerySortThenBy
    on QueryBuilder<CachedWidgetData, CachedWidgetData, QSortThenBy> {
  QueryBuilder<CachedWidgetData, CachedWidgetData, QAfterSortBy>
      thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<CachedWidgetData, CachedWidgetData, QAfterSortBy>
      thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<CachedWidgetData, CachedWidgetData, QAfterSortBy>
      thenByDataJson() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dataJson', Sort.asc);
    });
  }

  QueryBuilder<CachedWidgetData, CachedWidgetData, QAfterSortBy>
      thenByDataJsonDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dataJson', Sort.desc);
    });
  }

  QueryBuilder<CachedWidgetData, CachedWidgetData, QAfterSortBy>
      thenByEquipmentId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'equipmentId', Sort.asc);
    });
  }

  QueryBuilder<CachedWidgetData, CachedWidgetData, QAfterSortBy>
      thenByEquipmentIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'equipmentId', Sort.desc);
    });
  }

  QueryBuilder<CachedWidgetData, CachedWidgetData, QAfterSortBy>
      thenByExpiresAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'expiresAt', Sort.asc);
    });
  }

  QueryBuilder<CachedWidgetData, CachedWidgetData, QAfterSortBy>
      thenByExpiresAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'expiresAt', Sort.desc);
    });
  }

  QueryBuilder<CachedWidgetData, CachedWidgetData, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<CachedWidgetData, CachedWidgetData, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<CachedWidgetData, CachedWidgetData, QAfterSortBy>
      thenByIsExpired() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isExpired', Sort.asc);
    });
  }

  QueryBuilder<CachedWidgetData, CachedWidgetData, QAfterSortBy>
      thenByIsExpiredDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isExpired', Sort.desc);
    });
  }

  QueryBuilder<CachedWidgetData, CachedWidgetData, QAfterSortBy>
      thenByIsRealTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isRealTime', Sort.asc);
    });
  }

  QueryBuilder<CachedWidgetData, CachedWidgetData, QAfterSortBy>
      thenByIsRealTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isRealTime', Sort.desc);
    });
  }

  QueryBuilder<CachedWidgetData, CachedWidgetData, QAfterSortBy>
      thenByUserId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.asc);
    });
  }

  QueryBuilder<CachedWidgetData, CachedWidgetData, QAfterSortBy>
      thenByUserIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.desc);
    });
  }

  QueryBuilder<CachedWidgetData, CachedWidgetData, QAfterSortBy>
      thenByWidgetId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'widgetId', Sort.asc);
    });
  }

  QueryBuilder<CachedWidgetData, CachedWidgetData, QAfterSortBy>
      thenByWidgetIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'widgetId', Sort.desc);
    });
  }

  QueryBuilder<CachedWidgetData, CachedWidgetData, QAfterSortBy>
      thenByWidgetType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'widgetType', Sort.asc);
    });
  }

  QueryBuilder<CachedWidgetData, CachedWidgetData, QAfterSortBy>
      thenByWidgetTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'widgetType', Sort.desc);
    });
  }
}

extension CachedWidgetDataQueryWhereDistinct
    on QueryBuilder<CachedWidgetData, CachedWidgetData, QDistinct> {
  QueryBuilder<CachedWidgetData, CachedWidgetData, QDistinct>
      distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt');
    });
  }

  QueryBuilder<CachedWidgetData, CachedWidgetData, QDistinct>
      distinctByDataJson({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dataJson', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CachedWidgetData, CachedWidgetData, QDistinct>
      distinctByEquipmentId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'equipmentId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CachedWidgetData, CachedWidgetData, QDistinct>
      distinctByExpiresAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'expiresAt');
    });
  }

  QueryBuilder<CachedWidgetData, CachedWidgetData, QDistinct>
      distinctByIsExpired() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isExpired');
    });
  }

  QueryBuilder<CachedWidgetData, CachedWidgetData, QDistinct>
      distinctByIsRealTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isRealTime');
    });
  }

  QueryBuilder<CachedWidgetData, CachedWidgetData, QDistinct> distinctByUserId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'userId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CachedWidgetData, CachedWidgetData, QDistinct>
      distinctByWidgetId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'widgetId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CachedWidgetData, CachedWidgetData, QDistinct>
      distinctByWidgetType({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'widgetType', caseSensitive: caseSensitive);
    });
  }
}

extension CachedWidgetDataQueryProperty
    on QueryBuilder<CachedWidgetData, CachedWidgetData, QQueryProperty> {
  QueryBuilder<CachedWidgetData, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<CachedWidgetData, DateTime, QQueryOperations>
      createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<CachedWidgetData, String, QQueryOperations> dataJsonProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dataJson');
    });
  }

  QueryBuilder<CachedWidgetData, String?, QQueryOperations>
      equipmentIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'equipmentId');
    });
  }

  QueryBuilder<CachedWidgetData, DateTime, QQueryOperations>
      expiresAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'expiresAt');
    });
  }

  QueryBuilder<CachedWidgetData, bool, QQueryOperations> isExpiredProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isExpired');
    });
  }

  QueryBuilder<CachedWidgetData, bool, QQueryOperations> isRealTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isRealTime');
    });
  }

  QueryBuilder<CachedWidgetData, String, QQueryOperations> userIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'userId');
    });
  }

  QueryBuilder<CachedWidgetData, String, QQueryOperations> widgetIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'widgetId');
    });
  }

  QueryBuilder<CachedWidgetData, String, QQueryOperations>
      widgetTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'widgetType');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetCachedDynamicModelCollection on Isar {
  IsarCollection<CachedDynamicModel> get cachedDynamicModels =>
      this.collection();
}

const CachedDynamicModelSchema = CollectionSchema(
  name: r'CachedDynamicModel',
  id: -6843007550863608377,
  properties: {
    r'category': PropertySchema(
      id: 0,
      name: r'category',
      type: IsarType.string,
    ),
    r'createdAt': PropertySchema(
      id: 1,
      name: r'createdAt',
      type: IsarType.dateTime,
    ),
    r'expiresAt': PropertySchema(
      id: 2,
      name: r'expiresAt',
      type: IsarType.dateTime,
    ),
    r'isExpired': PropertySchema(
      id: 3,
      name: r'isExpired',
      type: IsarType.bool,
    ),
    r'isSystemModel': PropertySchema(
      id: 4,
      name: r'isSystemModel',
      type: IsarType.bool,
    ),
    r'modelId': PropertySchema(
      id: 5,
      name: r'modelId',
      type: IsarType.string,
    ),
    r'modelJson': PropertySchema(
      id: 6,
      name: r'modelJson',
      type: IsarType.string,
    ),
    r'modelName': PropertySchema(
      id: 7,
      name: r'modelName',
      type: IsarType.string,
    ),
    r'organizationId': PropertySchema(
      id: 8,
      name: r'organizationId',
      type: IsarType.string,
    ),
    r'version': PropertySchema(
      id: 9,
      name: r'version',
      type: IsarType.string,
    )
  },
  estimateSize: _cachedDynamicModelEstimateSize,
  serialize: _cachedDynamicModelSerialize,
  deserialize: _cachedDynamicModelDeserialize,
  deserializeProp: _cachedDynamicModelDeserializeProp,
  idName: r'id',
  indexes: {
    r'modelId': IndexSchema(
      id: -1910745378942518156,
      name: r'modelId',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'modelId',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
    r'modelName': IndexSchema(
      id: -5766876836036160997,
      name: r'modelName',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'modelName',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
    r'createdAt': IndexSchema(
      id: -3433535483987302584,
      name: r'createdAt',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'createdAt',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _cachedDynamicModelGetId,
  getLinks: _cachedDynamicModelGetLinks,
  attach: _cachedDynamicModelAttach,
  version: '3.1.0+1',
);

int _cachedDynamicModelEstimateSize(
  CachedDynamicModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.category.length * 3;
  bytesCount += 3 + object.modelId.length * 3;
  bytesCount += 3 + object.modelJson.length * 3;
  bytesCount += 3 + object.modelName.length * 3;
  {
    final value = object.organizationId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.version.length * 3;
  return bytesCount;
}

void _cachedDynamicModelSerialize(
  CachedDynamicModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.category);
  writer.writeDateTime(offsets[1], object.createdAt);
  writer.writeDateTime(offsets[2], object.expiresAt);
  writer.writeBool(offsets[3], object.isExpired);
  writer.writeBool(offsets[4], object.isSystemModel);
  writer.writeString(offsets[5], object.modelId);
  writer.writeString(offsets[6], object.modelJson);
  writer.writeString(offsets[7], object.modelName);
  writer.writeString(offsets[8], object.organizationId);
  writer.writeString(offsets[9], object.version);
}

CachedDynamicModel _cachedDynamicModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = CachedDynamicModel();
  object.category = reader.readString(offsets[0]);
  object.createdAt = reader.readDateTime(offsets[1]);
  object.expiresAt = reader.readDateTime(offsets[2]);
  object.id = id;
  object.isSystemModel = reader.readBool(offsets[4]);
  object.modelId = reader.readString(offsets[5]);
  object.modelJson = reader.readString(offsets[6]);
  object.modelName = reader.readString(offsets[7]);
  object.organizationId = reader.readStringOrNull(offsets[8]);
  object.version = reader.readString(offsets[9]);
  return object;
}

P _cachedDynamicModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readDateTime(offset)) as P;
    case 2:
      return (reader.readDateTime(offset)) as P;
    case 3:
      return (reader.readBool(offset)) as P;
    case 4:
      return (reader.readBool(offset)) as P;
    case 5:
      return (reader.readString(offset)) as P;
    case 6:
      return (reader.readString(offset)) as P;
    case 7:
      return (reader.readString(offset)) as P;
    case 8:
      return (reader.readStringOrNull(offset)) as P;
    case 9:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _cachedDynamicModelGetId(CachedDynamicModel object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _cachedDynamicModelGetLinks(
    CachedDynamicModel object) {
  return [];
}

void _cachedDynamicModelAttach(
    IsarCollection<dynamic> col, Id id, CachedDynamicModel object) {
  object.id = id;
}

extension CachedDynamicModelQueryWhereSort
    on QueryBuilder<CachedDynamicModel, CachedDynamicModel, QWhere> {
  QueryBuilder<CachedDynamicModel, CachedDynamicModel, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<CachedDynamicModel, CachedDynamicModel, QAfterWhere>
      anyCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'createdAt'),
      );
    });
  }
}

extension CachedDynamicModelQueryWhere
    on QueryBuilder<CachedDynamicModel, CachedDynamicModel, QWhereClause> {
  QueryBuilder<CachedDynamicModel, CachedDynamicModel, QAfterWhereClause>
      idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<CachedDynamicModel, CachedDynamicModel, QAfterWhereClause>
      idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<CachedDynamicModel, CachedDynamicModel, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<CachedDynamicModel, CachedDynamicModel, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<CachedDynamicModel, CachedDynamicModel, QAfterWhereClause>
      idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CachedDynamicModel, CachedDynamicModel, QAfterWhereClause>
      modelIdEqualTo(String modelId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'modelId',
        value: [modelId],
      ));
    });
  }

  QueryBuilder<CachedDynamicModel, CachedDynamicModel, QAfterWhereClause>
      modelIdNotEqualTo(String modelId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'modelId',
              lower: [],
              upper: [modelId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'modelId',
              lower: [modelId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'modelId',
              lower: [modelId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'modelId',
              lower: [],
              upper: [modelId],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<CachedDynamicModel, CachedDynamicModel, QAfterWhereClause>
      modelNameEqualTo(String modelName) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'modelName',
        value: [modelName],
      ));
    });
  }

  QueryBuilder<CachedDynamicModel, CachedDynamicModel, QAfterWhereClause>
      modelNameNotEqualTo(String modelName) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'modelName',
              lower: [],
              upper: [modelName],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'modelName',
              lower: [modelName],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'modelName',
              lower: [modelName],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'modelName',
              lower: [],
              upper: [modelName],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<CachedDynamicModel, CachedDynamicModel, QAfterWhereClause>
      createdAtEqualTo(DateTime createdAt) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'createdAt',
        value: [createdAt],
      ));
    });
  }

  QueryBuilder<CachedDynamicModel, CachedDynamicModel, QAfterWhereClause>
      createdAtNotEqualTo(DateTime createdAt) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'createdAt',
              lower: [],
              upper: [createdAt],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'createdAt',
              lower: [createdAt],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'createdAt',
              lower: [createdAt],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'createdAt',
              lower: [],
              upper: [createdAt],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<CachedDynamicModel, CachedDynamicModel, QAfterWhereClause>
      createdAtGreaterThan(
    DateTime createdAt, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'createdAt',
        lower: [createdAt],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<CachedDynamicModel, CachedDynamicModel, QAfterWhereClause>
      createdAtLessThan(
    DateTime createdAt, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'createdAt',
        lower: [],
        upper: [createdAt],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<CachedDynamicModel, CachedDynamicModel, QAfterWhereClause>
      createdAtBetween(
    DateTime lowerCreatedAt,
    DateTime upperCreatedAt, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'createdAt',
        lower: [lowerCreatedAt],
        includeLower: includeLower,
        upper: [upperCreatedAt],
        includeUpper: includeUpper,
      ));
    });
  }
}

extension CachedDynamicModelQueryFilter
    on QueryBuilder<CachedDynamicModel, CachedDynamicModel, QFilterCondition> {
  QueryBuilder<CachedDynamicModel, CachedDynamicModel, QAfterFilterCondition>
      categoryEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'category',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedDynamicModel, CachedDynamicModel, QAfterFilterCondition>
      categoryGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'category',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedDynamicModel, CachedDynamicModel, QAfterFilterCondition>
      categoryLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'category',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedDynamicModel, CachedDynamicModel, QAfterFilterCondition>
      categoryBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'category',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedDynamicModel, CachedDynamicModel, QAfterFilterCondition>
      categoryStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'category',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedDynamicModel, CachedDynamicModel, QAfterFilterCondition>
      categoryEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'category',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedDynamicModel, CachedDynamicModel, QAfterFilterCondition>
      categoryContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'category',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedDynamicModel, CachedDynamicModel, QAfterFilterCondition>
      categoryMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'category',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedDynamicModel, CachedDynamicModel, QAfterFilterCondition>
      categoryIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'category',
        value: '',
      ));
    });
  }

  QueryBuilder<CachedDynamicModel, CachedDynamicModel, QAfterFilterCondition>
      categoryIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'category',
        value: '',
      ));
    });
  }

  QueryBuilder<CachedDynamicModel, CachedDynamicModel, QAfterFilterCondition>
      createdAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<CachedDynamicModel, CachedDynamicModel, QAfterFilterCondition>
      createdAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<CachedDynamicModel, CachedDynamicModel, QAfterFilterCondition>
      createdAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<CachedDynamicModel, CachedDynamicModel, QAfterFilterCondition>
      createdAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'createdAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CachedDynamicModel, CachedDynamicModel, QAfterFilterCondition>
      expiresAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'expiresAt',
        value: value,
      ));
    });
  }

  QueryBuilder<CachedDynamicModel, CachedDynamicModel, QAfterFilterCondition>
      expiresAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'expiresAt',
        value: value,
      ));
    });
  }

  QueryBuilder<CachedDynamicModel, CachedDynamicModel, QAfterFilterCondition>
      expiresAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'expiresAt',
        value: value,
      ));
    });
  }

  QueryBuilder<CachedDynamicModel, CachedDynamicModel, QAfterFilterCondition>
      expiresAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'expiresAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CachedDynamicModel, CachedDynamicModel, QAfterFilterCondition>
      idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<CachedDynamicModel, CachedDynamicModel, QAfterFilterCondition>
      idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<CachedDynamicModel, CachedDynamicModel, QAfterFilterCondition>
      idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<CachedDynamicModel, CachedDynamicModel, QAfterFilterCondition>
      idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CachedDynamicModel, CachedDynamicModel, QAfterFilterCondition>
      isExpiredEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isExpired',
        value: value,
      ));
    });
  }

  QueryBuilder<CachedDynamicModel, CachedDynamicModel, QAfterFilterCondition>
      isSystemModelEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isSystemModel',
        value: value,
      ));
    });
  }

  QueryBuilder<CachedDynamicModel, CachedDynamicModel, QAfterFilterCondition>
      modelIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'modelId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedDynamicModel, CachedDynamicModel, QAfterFilterCondition>
      modelIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'modelId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedDynamicModel, CachedDynamicModel, QAfterFilterCondition>
      modelIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'modelId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedDynamicModel, CachedDynamicModel, QAfterFilterCondition>
      modelIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'modelId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedDynamicModel, CachedDynamicModel, QAfterFilterCondition>
      modelIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'modelId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedDynamicModel, CachedDynamicModel, QAfterFilterCondition>
      modelIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'modelId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedDynamicModel, CachedDynamicModel, QAfterFilterCondition>
      modelIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'modelId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedDynamicModel, CachedDynamicModel, QAfterFilterCondition>
      modelIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'modelId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedDynamicModel, CachedDynamicModel, QAfterFilterCondition>
      modelIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'modelId',
        value: '',
      ));
    });
  }

  QueryBuilder<CachedDynamicModel, CachedDynamicModel, QAfterFilterCondition>
      modelIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'modelId',
        value: '',
      ));
    });
  }

  QueryBuilder<CachedDynamicModel, CachedDynamicModel, QAfterFilterCondition>
      modelJsonEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'modelJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedDynamicModel, CachedDynamicModel, QAfterFilterCondition>
      modelJsonGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'modelJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedDynamicModel, CachedDynamicModel, QAfterFilterCondition>
      modelJsonLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'modelJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedDynamicModel, CachedDynamicModel, QAfterFilterCondition>
      modelJsonBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'modelJson',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedDynamicModel, CachedDynamicModel, QAfterFilterCondition>
      modelJsonStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'modelJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedDynamicModel, CachedDynamicModel, QAfterFilterCondition>
      modelJsonEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'modelJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedDynamicModel, CachedDynamicModel, QAfterFilterCondition>
      modelJsonContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'modelJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedDynamicModel, CachedDynamicModel, QAfterFilterCondition>
      modelJsonMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'modelJson',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedDynamicModel, CachedDynamicModel, QAfterFilterCondition>
      modelJsonIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'modelJson',
        value: '',
      ));
    });
  }

  QueryBuilder<CachedDynamicModel, CachedDynamicModel, QAfterFilterCondition>
      modelJsonIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'modelJson',
        value: '',
      ));
    });
  }

  QueryBuilder<CachedDynamicModel, CachedDynamicModel, QAfterFilterCondition>
      modelNameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'modelName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedDynamicModel, CachedDynamicModel, QAfterFilterCondition>
      modelNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'modelName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedDynamicModel, CachedDynamicModel, QAfterFilterCondition>
      modelNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'modelName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedDynamicModel, CachedDynamicModel, QAfterFilterCondition>
      modelNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'modelName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedDynamicModel, CachedDynamicModel, QAfterFilterCondition>
      modelNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'modelName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedDynamicModel, CachedDynamicModel, QAfterFilterCondition>
      modelNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'modelName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedDynamicModel, CachedDynamicModel, QAfterFilterCondition>
      modelNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'modelName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedDynamicModel, CachedDynamicModel, QAfterFilterCondition>
      modelNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'modelName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedDynamicModel, CachedDynamicModel, QAfterFilterCondition>
      modelNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'modelName',
        value: '',
      ));
    });
  }

  QueryBuilder<CachedDynamicModel, CachedDynamicModel, QAfterFilterCondition>
      modelNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'modelName',
        value: '',
      ));
    });
  }

  QueryBuilder<CachedDynamicModel, CachedDynamicModel, QAfterFilterCondition>
      organizationIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'organizationId',
      ));
    });
  }

  QueryBuilder<CachedDynamicModel, CachedDynamicModel, QAfterFilterCondition>
      organizationIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'organizationId',
      ));
    });
  }

  QueryBuilder<CachedDynamicModel, CachedDynamicModel, QAfterFilterCondition>
      organizationIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'organizationId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedDynamicModel, CachedDynamicModel, QAfterFilterCondition>
      organizationIdGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'organizationId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedDynamicModel, CachedDynamicModel, QAfterFilterCondition>
      organizationIdLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'organizationId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedDynamicModel, CachedDynamicModel, QAfterFilterCondition>
      organizationIdBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'organizationId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedDynamicModel, CachedDynamicModel, QAfterFilterCondition>
      organizationIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'organizationId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedDynamicModel, CachedDynamicModel, QAfterFilterCondition>
      organizationIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'organizationId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedDynamicModel, CachedDynamicModel, QAfterFilterCondition>
      organizationIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'organizationId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedDynamicModel, CachedDynamicModel, QAfterFilterCondition>
      organizationIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'organizationId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedDynamicModel, CachedDynamicModel, QAfterFilterCondition>
      organizationIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'organizationId',
        value: '',
      ));
    });
  }

  QueryBuilder<CachedDynamicModel, CachedDynamicModel, QAfterFilterCondition>
      organizationIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'organizationId',
        value: '',
      ));
    });
  }

  QueryBuilder<CachedDynamicModel, CachedDynamicModel, QAfterFilterCondition>
      versionEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'version',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedDynamicModel, CachedDynamicModel, QAfterFilterCondition>
      versionGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'version',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedDynamicModel, CachedDynamicModel, QAfterFilterCondition>
      versionLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'version',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedDynamicModel, CachedDynamicModel, QAfterFilterCondition>
      versionBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'version',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedDynamicModel, CachedDynamicModel, QAfterFilterCondition>
      versionStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'version',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedDynamicModel, CachedDynamicModel, QAfterFilterCondition>
      versionEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'version',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedDynamicModel, CachedDynamicModel, QAfterFilterCondition>
      versionContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'version',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedDynamicModel, CachedDynamicModel, QAfterFilterCondition>
      versionMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'version',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedDynamicModel, CachedDynamicModel, QAfterFilterCondition>
      versionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'version',
        value: '',
      ));
    });
  }

  QueryBuilder<CachedDynamicModel, CachedDynamicModel, QAfterFilterCondition>
      versionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'version',
        value: '',
      ));
    });
  }
}

extension CachedDynamicModelQueryObject
    on QueryBuilder<CachedDynamicModel, CachedDynamicModel, QFilterCondition> {}

extension CachedDynamicModelQueryLinks
    on QueryBuilder<CachedDynamicModel, CachedDynamicModel, QFilterCondition> {}

extension CachedDynamicModelQuerySortBy
    on QueryBuilder<CachedDynamicModel, CachedDynamicModel, QSortBy> {
  QueryBuilder<CachedDynamicModel, CachedDynamicModel, QAfterSortBy>
      sortByCategory() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'category', Sort.asc);
    });
  }

  QueryBuilder<CachedDynamicModel, CachedDynamicModel, QAfterSortBy>
      sortByCategoryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'category', Sort.desc);
    });
  }

  QueryBuilder<CachedDynamicModel, CachedDynamicModel, QAfterSortBy>
      sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<CachedDynamicModel, CachedDynamicModel, QAfterSortBy>
      sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<CachedDynamicModel, CachedDynamicModel, QAfterSortBy>
      sortByExpiresAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'expiresAt', Sort.asc);
    });
  }

  QueryBuilder<CachedDynamicModel, CachedDynamicModel, QAfterSortBy>
      sortByExpiresAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'expiresAt', Sort.desc);
    });
  }

  QueryBuilder<CachedDynamicModel, CachedDynamicModel, QAfterSortBy>
      sortByIsExpired() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isExpired', Sort.asc);
    });
  }

  QueryBuilder<CachedDynamicModel, CachedDynamicModel, QAfterSortBy>
      sortByIsExpiredDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isExpired', Sort.desc);
    });
  }

  QueryBuilder<CachedDynamicModel, CachedDynamicModel, QAfterSortBy>
      sortByIsSystemModel() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSystemModel', Sort.asc);
    });
  }

  QueryBuilder<CachedDynamicModel, CachedDynamicModel, QAfterSortBy>
      sortByIsSystemModelDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSystemModel', Sort.desc);
    });
  }

  QueryBuilder<CachedDynamicModel, CachedDynamicModel, QAfterSortBy>
      sortByModelId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'modelId', Sort.asc);
    });
  }

  QueryBuilder<CachedDynamicModel, CachedDynamicModel, QAfterSortBy>
      sortByModelIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'modelId', Sort.desc);
    });
  }

  QueryBuilder<CachedDynamicModel, CachedDynamicModel, QAfterSortBy>
      sortByModelJson() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'modelJson', Sort.asc);
    });
  }

  QueryBuilder<CachedDynamicModel, CachedDynamicModel, QAfterSortBy>
      sortByModelJsonDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'modelJson', Sort.desc);
    });
  }

  QueryBuilder<CachedDynamicModel, CachedDynamicModel, QAfterSortBy>
      sortByModelName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'modelName', Sort.asc);
    });
  }

  QueryBuilder<CachedDynamicModel, CachedDynamicModel, QAfterSortBy>
      sortByModelNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'modelName', Sort.desc);
    });
  }

  QueryBuilder<CachedDynamicModel, CachedDynamicModel, QAfterSortBy>
      sortByOrganizationId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'organizationId', Sort.asc);
    });
  }

  QueryBuilder<CachedDynamicModel, CachedDynamicModel, QAfterSortBy>
      sortByOrganizationIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'organizationId', Sort.desc);
    });
  }

  QueryBuilder<CachedDynamicModel, CachedDynamicModel, QAfterSortBy>
      sortByVersion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'version', Sort.asc);
    });
  }

  QueryBuilder<CachedDynamicModel, CachedDynamicModel, QAfterSortBy>
      sortByVersionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'version', Sort.desc);
    });
  }
}

extension CachedDynamicModelQuerySortThenBy
    on QueryBuilder<CachedDynamicModel, CachedDynamicModel, QSortThenBy> {
  QueryBuilder<CachedDynamicModel, CachedDynamicModel, QAfterSortBy>
      thenByCategory() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'category', Sort.asc);
    });
  }

  QueryBuilder<CachedDynamicModel, CachedDynamicModel, QAfterSortBy>
      thenByCategoryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'category', Sort.desc);
    });
  }

  QueryBuilder<CachedDynamicModel, CachedDynamicModel, QAfterSortBy>
      thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<CachedDynamicModel, CachedDynamicModel, QAfterSortBy>
      thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<CachedDynamicModel, CachedDynamicModel, QAfterSortBy>
      thenByExpiresAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'expiresAt', Sort.asc);
    });
  }

  QueryBuilder<CachedDynamicModel, CachedDynamicModel, QAfterSortBy>
      thenByExpiresAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'expiresAt', Sort.desc);
    });
  }

  QueryBuilder<CachedDynamicModel, CachedDynamicModel, QAfterSortBy>
      thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<CachedDynamicModel, CachedDynamicModel, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<CachedDynamicModel, CachedDynamicModel, QAfterSortBy>
      thenByIsExpired() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isExpired', Sort.asc);
    });
  }

  QueryBuilder<CachedDynamicModel, CachedDynamicModel, QAfterSortBy>
      thenByIsExpiredDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isExpired', Sort.desc);
    });
  }

  QueryBuilder<CachedDynamicModel, CachedDynamicModel, QAfterSortBy>
      thenByIsSystemModel() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSystemModel', Sort.asc);
    });
  }

  QueryBuilder<CachedDynamicModel, CachedDynamicModel, QAfterSortBy>
      thenByIsSystemModelDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSystemModel', Sort.desc);
    });
  }

  QueryBuilder<CachedDynamicModel, CachedDynamicModel, QAfterSortBy>
      thenByModelId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'modelId', Sort.asc);
    });
  }

  QueryBuilder<CachedDynamicModel, CachedDynamicModel, QAfterSortBy>
      thenByModelIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'modelId', Sort.desc);
    });
  }

  QueryBuilder<CachedDynamicModel, CachedDynamicModel, QAfterSortBy>
      thenByModelJson() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'modelJson', Sort.asc);
    });
  }

  QueryBuilder<CachedDynamicModel, CachedDynamicModel, QAfterSortBy>
      thenByModelJsonDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'modelJson', Sort.desc);
    });
  }

  QueryBuilder<CachedDynamicModel, CachedDynamicModel, QAfterSortBy>
      thenByModelName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'modelName', Sort.asc);
    });
  }

  QueryBuilder<CachedDynamicModel, CachedDynamicModel, QAfterSortBy>
      thenByModelNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'modelName', Sort.desc);
    });
  }

  QueryBuilder<CachedDynamicModel, CachedDynamicModel, QAfterSortBy>
      thenByOrganizationId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'organizationId', Sort.asc);
    });
  }

  QueryBuilder<CachedDynamicModel, CachedDynamicModel, QAfterSortBy>
      thenByOrganizationIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'organizationId', Sort.desc);
    });
  }

  QueryBuilder<CachedDynamicModel, CachedDynamicModel, QAfterSortBy>
      thenByVersion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'version', Sort.asc);
    });
  }

  QueryBuilder<CachedDynamicModel, CachedDynamicModel, QAfterSortBy>
      thenByVersionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'version', Sort.desc);
    });
  }
}

extension CachedDynamicModelQueryWhereDistinct
    on QueryBuilder<CachedDynamicModel, CachedDynamicModel, QDistinct> {
  QueryBuilder<CachedDynamicModel, CachedDynamicModel, QDistinct>
      distinctByCategory({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'category', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CachedDynamicModel, CachedDynamicModel, QDistinct>
      distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt');
    });
  }

  QueryBuilder<CachedDynamicModel, CachedDynamicModel, QDistinct>
      distinctByExpiresAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'expiresAt');
    });
  }

  QueryBuilder<CachedDynamicModel, CachedDynamicModel, QDistinct>
      distinctByIsExpired() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isExpired');
    });
  }

  QueryBuilder<CachedDynamicModel, CachedDynamicModel, QDistinct>
      distinctByIsSystemModel() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isSystemModel');
    });
  }

  QueryBuilder<CachedDynamicModel, CachedDynamicModel, QDistinct>
      distinctByModelId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'modelId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CachedDynamicModel, CachedDynamicModel, QDistinct>
      distinctByModelJson({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'modelJson', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CachedDynamicModel, CachedDynamicModel, QDistinct>
      distinctByModelName({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'modelName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CachedDynamicModel, CachedDynamicModel, QDistinct>
      distinctByOrganizationId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'organizationId',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CachedDynamicModel, CachedDynamicModel, QDistinct>
      distinctByVersion({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'version', caseSensitive: caseSensitive);
    });
  }
}

extension CachedDynamicModelQueryProperty
    on QueryBuilder<CachedDynamicModel, CachedDynamicModel, QQueryProperty> {
  QueryBuilder<CachedDynamicModel, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<CachedDynamicModel, String, QQueryOperations>
      categoryProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'category');
    });
  }

  QueryBuilder<CachedDynamicModel, DateTime, QQueryOperations>
      createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<CachedDynamicModel, DateTime, QQueryOperations>
      expiresAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'expiresAt');
    });
  }

  QueryBuilder<CachedDynamicModel, bool, QQueryOperations> isExpiredProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isExpired');
    });
  }

  QueryBuilder<CachedDynamicModel, bool, QQueryOperations>
      isSystemModelProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isSystemModel');
    });
  }

  QueryBuilder<CachedDynamicModel, String, QQueryOperations> modelIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'modelId');
    });
  }

  QueryBuilder<CachedDynamicModel, String, QQueryOperations>
      modelJsonProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'modelJson');
    });
  }

  QueryBuilder<CachedDynamicModel, String, QQueryOperations>
      modelNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'modelName');
    });
  }

  QueryBuilder<CachedDynamicModel, String?, QQueryOperations>
      organizationIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'organizationId');
    });
  }

  QueryBuilder<CachedDynamicModel, String, QQueryOperations> versionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'version');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetCachedUserProfileCollection on Isar {
  IsarCollection<CachedUserProfile> get cachedUserProfiles => this.collection();
}

const CachedUserProfileSchema = CollectionSchema(
  name: r'CachedUserProfile',
  id: -5863073774220736086,
  properties: {
    r'createdAt': PropertySchema(
      id: 0,
      name: r'createdAt',
      type: IsarType.dateTime,
    ),
    r'department': PropertySchema(
      id: 1,
      name: r'department',
      type: IsarType.string,
    ),
    r'expiresAt': PropertySchema(
      id: 2,
      name: r'expiresAt',
      type: IsarType.dateTime,
    ),
    r'isExpired': PropertySchema(
      id: 3,
      name: r'isExpired',
      type: IsarType.bool,
    ),
    r'organizationId': PropertySchema(
      id: 4,
      name: r'organizationId',
      type: IsarType.string,
    ),
    r'profileJson': PropertySchema(
      id: 5,
      name: r'profileJson',
      type: IsarType.string,
    ),
    r'specialization': PropertySchema(
      id: 6,
      name: r'specialization',
      type: IsarType.string,
    ),
    r'userId': PropertySchema(
      id: 7,
      name: r'userId',
      type: IsarType.string,
    )
  },
  estimateSize: _cachedUserProfileEstimateSize,
  serialize: _cachedUserProfileSerialize,
  deserialize: _cachedUserProfileDeserialize,
  deserializeProp: _cachedUserProfileDeserializeProp,
  idName: r'id',
  indexes: {
    r'userId': IndexSchema(
      id: -2005826577402374815,
      name: r'userId',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'userId',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
    r'createdAt': IndexSchema(
      id: -3433535483987302584,
      name: r'createdAt',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'createdAt',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _cachedUserProfileGetId,
  getLinks: _cachedUserProfileGetLinks,
  attach: _cachedUserProfileAttach,
  version: '3.1.0+1',
);

int _cachedUserProfileEstimateSize(
  CachedUserProfile object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.department;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.organizationId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.profileJson.length * 3;
  {
    final value = object.specialization;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.userId.length * 3;
  return bytesCount;
}

void _cachedUserProfileSerialize(
  CachedUserProfile object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDateTime(offsets[0], object.createdAt);
  writer.writeString(offsets[1], object.department);
  writer.writeDateTime(offsets[2], object.expiresAt);
  writer.writeBool(offsets[3], object.isExpired);
  writer.writeString(offsets[4], object.organizationId);
  writer.writeString(offsets[5], object.profileJson);
  writer.writeString(offsets[6], object.specialization);
  writer.writeString(offsets[7], object.userId);
}

CachedUserProfile _cachedUserProfileDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = CachedUserProfile();
  object.createdAt = reader.readDateTime(offsets[0]);
  object.department = reader.readStringOrNull(offsets[1]);
  object.expiresAt = reader.readDateTime(offsets[2]);
  object.id = id;
  object.organizationId = reader.readStringOrNull(offsets[4]);
  object.profileJson = reader.readString(offsets[5]);
  object.specialization = reader.readStringOrNull(offsets[6]);
  object.userId = reader.readString(offsets[7]);
  return object;
}

P _cachedUserProfileDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDateTime(offset)) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    case 2:
      return (reader.readDateTime(offset)) as P;
    case 3:
      return (reader.readBool(offset)) as P;
    case 4:
      return (reader.readStringOrNull(offset)) as P;
    case 5:
      return (reader.readString(offset)) as P;
    case 6:
      return (reader.readStringOrNull(offset)) as P;
    case 7:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _cachedUserProfileGetId(CachedUserProfile object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _cachedUserProfileGetLinks(
    CachedUserProfile object) {
  return [];
}

void _cachedUserProfileAttach(
    IsarCollection<dynamic> col, Id id, CachedUserProfile object) {
  object.id = id;
}

extension CachedUserProfileQueryWhereSort
    on QueryBuilder<CachedUserProfile, CachedUserProfile, QWhere> {
  QueryBuilder<CachedUserProfile, CachedUserProfile, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<CachedUserProfile, CachedUserProfile, QAfterWhere>
      anyCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'createdAt'),
      );
    });
  }
}

extension CachedUserProfileQueryWhere
    on QueryBuilder<CachedUserProfile, CachedUserProfile, QWhereClause> {
  QueryBuilder<CachedUserProfile, CachedUserProfile, QAfterWhereClause>
      idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<CachedUserProfile, CachedUserProfile, QAfterWhereClause>
      idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<CachedUserProfile, CachedUserProfile, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<CachedUserProfile, CachedUserProfile, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<CachedUserProfile, CachedUserProfile, QAfterWhereClause>
      idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CachedUserProfile, CachedUserProfile, QAfterWhereClause>
      userIdEqualTo(String userId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'userId',
        value: [userId],
      ));
    });
  }

  QueryBuilder<CachedUserProfile, CachedUserProfile, QAfterWhereClause>
      userIdNotEqualTo(String userId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'userId',
              lower: [],
              upper: [userId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'userId',
              lower: [userId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'userId',
              lower: [userId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'userId',
              lower: [],
              upper: [userId],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<CachedUserProfile, CachedUserProfile, QAfterWhereClause>
      createdAtEqualTo(DateTime createdAt) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'createdAt',
        value: [createdAt],
      ));
    });
  }

  QueryBuilder<CachedUserProfile, CachedUserProfile, QAfterWhereClause>
      createdAtNotEqualTo(DateTime createdAt) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'createdAt',
              lower: [],
              upper: [createdAt],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'createdAt',
              lower: [createdAt],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'createdAt',
              lower: [createdAt],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'createdAt',
              lower: [],
              upper: [createdAt],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<CachedUserProfile, CachedUserProfile, QAfterWhereClause>
      createdAtGreaterThan(
    DateTime createdAt, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'createdAt',
        lower: [createdAt],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<CachedUserProfile, CachedUserProfile, QAfterWhereClause>
      createdAtLessThan(
    DateTime createdAt, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'createdAt',
        lower: [],
        upper: [createdAt],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<CachedUserProfile, CachedUserProfile, QAfterWhereClause>
      createdAtBetween(
    DateTime lowerCreatedAt,
    DateTime upperCreatedAt, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'createdAt',
        lower: [lowerCreatedAt],
        includeLower: includeLower,
        upper: [upperCreatedAt],
        includeUpper: includeUpper,
      ));
    });
  }
}

extension CachedUserProfileQueryFilter
    on QueryBuilder<CachedUserProfile, CachedUserProfile, QFilterCondition> {
  QueryBuilder<CachedUserProfile, CachedUserProfile, QAfterFilterCondition>
      createdAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<CachedUserProfile, CachedUserProfile, QAfterFilterCondition>
      createdAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<CachedUserProfile, CachedUserProfile, QAfterFilterCondition>
      createdAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<CachedUserProfile, CachedUserProfile, QAfterFilterCondition>
      createdAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'createdAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CachedUserProfile, CachedUserProfile, QAfterFilterCondition>
      departmentIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'department',
      ));
    });
  }

  QueryBuilder<CachedUserProfile, CachedUserProfile, QAfterFilterCondition>
      departmentIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'department',
      ));
    });
  }

  QueryBuilder<CachedUserProfile, CachedUserProfile, QAfterFilterCondition>
      departmentEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'department',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedUserProfile, CachedUserProfile, QAfterFilterCondition>
      departmentGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'department',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedUserProfile, CachedUserProfile, QAfterFilterCondition>
      departmentLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'department',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedUserProfile, CachedUserProfile, QAfterFilterCondition>
      departmentBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'department',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedUserProfile, CachedUserProfile, QAfterFilterCondition>
      departmentStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'department',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedUserProfile, CachedUserProfile, QAfterFilterCondition>
      departmentEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'department',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedUserProfile, CachedUserProfile, QAfterFilterCondition>
      departmentContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'department',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedUserProfile, CachedUserProfile, QAfterFilterCondition>
      departmentMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'department',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedUserProfile, CachedUserProfile, QAfterFilterCondition>
      departmentIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'department',
        value: '',
      ));
    });
  }

  QueryBuilder<CachedUserProfile, CachedUserProfile, QAfterFilterCondition>
      departmentIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'department',
        value: '',
      ));
    });
  }

  QueryBuilder<CachedUserProfile, CachedUserProfile, QAfterFilterCondition>
      expiresAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'expiresAt',
        value: value,
      ));
    });
  }

  QueryBuilder<CachedUserProfile, CachedUserProfile, QAfterFilterCondition>
      expiresAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'expiresAt',
        value: value,
      ));
    });
  }

  QueryBuilder<CachedUserProfile, CachedUserProfile, QAfterFilterCondition>
      expiresAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'expiresAt',
        value: value,
      ));
    });
  }

  QueryBuilder<CachedUserProfile, CachedUserProfile, QAfterFilterCondition>
      expiresAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'expiresAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CachedUserProfile, CachedUserProfile, QAfterFilterCondition>
      idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<CachedUserProfile, CachedUserProfile, QAfterFilterCondition>
      idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<CachedUserProfile, CachedUserProfile, QAfterFilterCondition>
      idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<CachedUserProfile, CachedUserProfile, QAfterFilterCondition>
      idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CachedUserProfile, CachedUserProfile, QAfterFilterCondition>
      isExpiredEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isExpired',
        value: value,
      ));
    });
  }

  QueryBuilder<CachedUserProfile, CachedUserProfile, QAfterFilterCondition>
      organizationIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'organizationId',
      ));
    });
  }

  QueryBuilder<CachedUserProfile, CachedUserProfile, QAfterFilterCondition>
      organizationIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'organizationId',
      ));
    });
  }

  QueryBuilder<CachedUserProfile, CachedUserProfile, QAfterFilterCondition>
      organizationIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'organizationId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedUserProfile, CachedUserProfile, QAfterFilterCondition>
      organizationIdGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'organizationId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedUserProfile, CachedUserProfile, QAfterFilterCondition>
      organizationIdLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'organizationId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedUserProfile, CachedUserProfile, QAfterFilterCondition>
      organizationIdBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'organizationId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedUserProfile, CachedUserProfile, QAfterFilterCondition>
      organizationIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'organizationId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedUserProfile, CachedUserProfile, QAfterFilterCondition>
      organizationIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'organizationId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedUserProfile, CachedUserProfile, QAfterFilterCondition>
      organizationIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'organizationId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedUserProfile, CachedUserProfile, QAfterFilterCondition>
      organizationIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'organizationId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedUserProfile, CachedUserProfile, QAfterFilterCondition>
      organizationIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'organizationId',
        value: '',
      ));
    });
  }

  QueryBuilder<CachedUserProfile, CachedUserProfile, QAfterFilterCondition>
      organizationIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'organizationId',
        value: '',
      ));
    });
  }

  QueryBuilder<CachedUserProfile, CachedUserProfile, QAfterFilterCondition>
      profileJsonEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'profileJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedUserProfile, CachedUserProfile, QAfterFilterCondition>
      profileJsonGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'profileJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedUserProfile, CachedUserProfile, QAfterFilterCondition>
      profileJsonLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'profileJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedUserProfile, CachedUserProfile, QAfterFilterCondition>
      profileJsonBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'profileJson',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedUserProfile, CachedUserProfile, QAfterFilterCondition>
      profileJsonStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'profileJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedUserProfile, CachedUserProfile, QAfterFilterCondition>
      profileJsonEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'profileJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedUserProfile, CachedUserProfile, QAfterFilterCondition>
      profileJsonContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'profileJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedUserProfile, CachedUserProfile, QAfterFilterCondition>
      profileJsonMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'profileJson',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedUserProfile, CachedUserProfile, QAfterFilterCondition>
      profileJsonIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'profileJson',
        value: '',
      ));
    });
  }

  QueryBuilder<CachedUserProfile, CachedUserProfile, QAfterFilterCondition>
      profileJsonIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'profileJson',
        value: '',
      ));
    });
  }

  QueryBuilder<CachedUserProfile, CachedUserProfile, QAfterFilterCondition>
      specializationIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'specialization',
      ));
    });
  }

  QueryBuilder<CachedUserProfile, CachedUserProfile, QAfterFilterCondition>
      specializationIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'specialization',
      ));
    });
  }

  QueryBuilder<CachedUserProfile, CachedUserProfile, QAfterFilterCondition>
      specializationEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'specialization',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedUserProfile, CachedUserProfile, QAfterFilterCondition>
      specializationGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'specialization',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedUserProfile, CachedUserProfile, QAfterFilterCondition>
      specializationLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'specialization',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedUserProfile, CachedUserProfile, QAfterFilterCondition>
      specializationBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'specialization',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedUserProfile, CachedUserProfile, QAfterFilterCondition>
      specializationStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'specialization',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedUserProfile, CachedUserProfile, QAfterFilterCondition>
      specializationEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'specialization',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedUserProfile, CachedUserProfile, QAfterFilterCondition>
      specializationContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'specialization',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedUserProfile, CachedUserProfile, QAfterFilterCondition>
      specializationMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'specialization',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedUserProfile, CachedUserProfile, QAfterFilterCondition>
      specializationIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'specialization',
        value: '',
      ));
    });
  }

  QueryBuilder<CachedUserProfile, CachedUserProfile, QAfterFilterCondition>
      specializationIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'specialization',
        value: '',
      ));
    });
  }

  QueryBuilder<CachedUserProfile, CachedUserProfile, QAfterFilterCondition>
      userIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'userId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedUserProfile, CachedUserProfile, QAfterFilterCondition>
      userIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'userId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedUserProfile, CachedUserProfile, QAfterFilterCondition>
      userIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'userId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedUserProfile, CachedUserProfile, QAfterFilterCondition>
      userIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'userId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedUserProfile, CachedUserProfile, QAfterFilterCondition>
      userIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'userId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedUserProfile, CachedUserProfile, QAfterFilterCondition>
      userIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'userId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedUserProfile, CachedUserProfile, QAfterFilterCondition>
      userIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'userId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedUserProfile, CachedUserProfile, QAfterFilterCondition>
      userIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'userId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedUserProfile, CachedUserProfile, QAfterFilterCondition>
      userIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'userId',
        value: '',
      ));
    });
  }

  QueryBuilder<CachedUserProfile, CachedUserProfile, QAfterFilterCondition>
      userIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'userId',
        value: '',
      ));
    });
  }
}

extension CachedUserProfileQueryObject
    on QueryBuilder<CachedUserProfile, CachedUserProfile, QFilterCondition> {}

extension CachedUserProfileQueryLinks
    on QueryBuilder<CachedUserProfile, CachedUserProfile, QFilterCondition> {}

extension CachedUserProfileQuerySortBy
    on QueryBuilder<CachedUserProfile, CachedUserProfile, QSortBy> {
  QueryBuilder<CachedUserProfile, CachedUserProfile, QAfterSortBy>
      sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<CachedUserProfile, CachedUserProfile, QAfterSortBy>
      sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<CachedUserProfile, CachedUserProfile, QAfterSortBy>
      sortByDepartment() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'department', Sort.asc);
    });
  }

  QueryBuilder<CachedUserProfile, CachedUserProfile, QAfterSortBy>
      sortByDepartmentDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'department', Sort.desc);
    });
  }

  QueryBuilder<CachedUserProfile, CachedUserProfile, QAfterSortBy>
      sortByExpiresAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'expiresAt', Sort.asc);
    });
  }

  QueryBuilder<CachedUserProfile, CachedUserProfile, QAfterSortBy>
      sortByExpiresAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'expiresAt', Sort.desc);
    });
  }

  QueryBuilder<CachedUserProfile, CachedUserProfile, QAfterSortBy>
      sortByIsExpired() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isExpired', Sort.asc);
    });
  }

  QueryBuilder<CachedUserProfile, CachedUserProfile, QAfterSortBy>
      sortByIsExpiredDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isExpired', Sort.desc);
    });
  }

  QueryBuilder<CachedUserProfile, CachedUserProfile, QAfterSortBy>
      sortByOrganizationId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'organizationId', Sort.asc);
    });
  }

  QueryBuilder<CachedUserProfile, CachedUserProfile, QAfterSortBy>
      sortByOrganizationIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'organizationId', Sort.desc);
    });
  }

  QueryBuilder<CachedUserProfile, CachedUserProfile, QAfterSortBy>
      sortByProfileJson() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'profileJson', Sort.asc);
    });
  }

  QueryBuilder<CachedUserProfile, CachedUserProfile, QAfterSortBy>
      sortByProfileJsonDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'profileJson', Sort.desc);
    });
  }

  QueryBuilder<CachedUserProfile, CachedUserProfile, QAfterSortBy>
      sortBySpecialization() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'specialization', Sort.asc);
    });
  }

  QueryBuilder<CachedUserProfile, CachedUserProfile, QAfterSortBy>
      sortBySpecializationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'specialization', Sort.desc);
    });
  }

  QueryBuilder<CachedUserProfile, CachedUserProfile, QAfterSortBy>
      sortByUserId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.asc);
    });
  }

  QueryBuilder<CachedUserProfile, CachedUserProfile, QAfterSortBy>
      sortByUserIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.desc);
    });
  }
}

extension CachedUserProfileQuerySortThenBy
    on QueryBuilder<CachedUserProfile, CachedUserProfile, QSortThenBy> {
  QueryBuilder<CachedUserProfile, CachedUserProfile, QAfterSortBy>
      thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<CachedUserProfile, CachedUserProfile, QAfterSortBy>
      thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<CachedUserProfile, CachedUserProfile, QAfterSortBy>
      thenByDepartment() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'department', Sort.asc);
    });
  }

  QueryBuilder<CachedUserProfile, CachedUserProfile, QAfterSortBy>
      thenByDepartmentDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'department', Sort.desc);
    });
  }

  QueryBuilder<CachedUserProfile, CachedUserProfile, QAfterSortBy>
      thenByExpiresAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'expiresAt', Sort.asc);
    });
  }

  QueryBuilder<CachedUserProfile, CachedUserProfile, QAfterSortBy>
      thenByExpiresAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'expiresAt', Sort.desc);
    });
  }

  QueryBuilder<CachedUserProfile, CachedUserProfile, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<CachedUserProfile, CachedUserProfile, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<CachedUserProfile, CachedUserProfile, QAfterSortBy>
      thenByIsExpired() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isExpired', Sort.asc);
    });
  }

  QueryBuilder<CachedUserProfile, CachedUserProfile, QAfterSortBy>
      thenByIsExpiredDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isExpired', Sort.desc);
    });
  }

  QueryBuilder<CachedUserProfile, CachedUserProfile, QAfterSortBy>
      thenByOrganizationId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'organizationId', Sort.asc);
    });
  }

  QueryBuilder<CachedUserProfile, CachedUserProfile, QAfterSortBy>
      thenByOrganizationIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'organizationId', Sort.desc);
    });
  }

  QueryBuilder<CachedUserProfile, CachedUserProfile, QAfterSortBy>
      thenByProfileJson() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'profileJson', Sort.asc);
    });
  }

  QueryBuilder<CachedUserProfile, CachedUserProfile, QAfterSortBy>
      thenByProfileJsonDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'profileJson', Sort.desc);
    });
  }

  QueryBuilder<CachedUserProfile, CachedUserProfile, QAfterSortBy>
      thenBySpecialization() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'specialization', Sort.asc);
    });
  }

  QueryBuilder<CachedUserProfile, CachedUserProfile, QAfterSortBy>
      thenBySpecializationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'specialization', Sort.desc);
    });
  }

  QueryBuilder<CachedUserProfile, CachedUserProfile, QAfterSortBy>
      thenByUserId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.asc);
    });
  }

  QueryBuilder<CachedUserProfile, CachedUserProfile, QAfterSortBy>
      thenByUserIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.desc);
    });
  }
}

extension CachedUserProfileQueryWhereDistinct
    on QueryBuilder<CachedUserProfile, CachedUserProfile, QDistinct> {
  QueryBuilder<CachedUserProfile, CachedUserProfile, QDistinct>
      distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt');
    });
  }

  QueryBuilder<CachedUserProfile, CachedUserProfile, QDistinct>
      distinctByDepartment({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'department', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CachedUserProfile, CachedUserProfile, QDistinct>
      distinctByExpiresAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'expiresAt');
    });
  }

  QueryBuilder<CachedUserProfile, CachedUserProfile, QDistinct>
      distinctByIsExpired() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isExpired');
    });
  }

  QueryBuilder<CachedUserProfile, CachedUserProfile, QDistinct>
      distinctByOrganizationId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'organizationId',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CachedUserProfile, CachedUserProfile, QDistinct>
      distinctByProfileJson({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'profileJson', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CachedUserProfile, CachedUserProfile, QDistinct>
      distinctBySpecialization({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'specialization',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CachedUserProfile, CachedUserProfile, QDistinct>
      distinctByUserId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'userId', caseSensitive: caseSensitive);
    });
  }
}

extension CachedUserProfileQueryProperty
    on QueryBuilder<CachedUserProfile, CachedUserProfile, QQueryProperty> {
  QueryBuilder<CachedUserProfile, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<CachedUserProfile, DateTime, QQueryOperations>
      createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<CachedUserProfile, String?, QQueryOperations>
      departmentProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'department');
    });
  }

  QueryBuilder<CachedUserProfile, DateTime, QQueryOperations>
      expiresAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'expiresAt');
    });
  }

  QueryBuilder<CachedUserProfile, bool, QQueryOperations> isExpiredProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isExpired');
    });
  }

  QueryBuilder<CachedUserProfile, String?, QQueryOperations>
      organizationIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'organizationId');
    });
  }

  QueryBuilder<CachedUserProfile, String, QQueryOperations>
      profileJsonProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'profileJson');
    });
  }

  QueryBuilder<CachedUserProfile, String?, QQueryOperations>
      specializationProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'specialization');
    });
  }

  QueryBuilder<CachedUserProfile, String, QQueryOperations> userIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'userId');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetCachedOrganizationCollection on Isar {
  IsarCollection<CachedOrganization> get cachedOrganizations =>
      this.collection();
}

const CachedOrganizationSchema = CollectionSchema(
  name: r'CachedOrganization',
  id: 5331327316101227459,
  properties: {
    r'createdAt': PropertySchema(
      id: 0,
      name: r'createdAt',
      type: IsarType.dateTime,
    ),
    r'expiresAt': PropertySchema(
      id: 1,
      name: r'expiresAt',
      type: IsarType.dateTime,
    ),
    r'isActive': PropertySchema(
      id: 2,
      name: r'isActive',
      type: IsarType.bool,
    ),
    r'isExpired': PropertySchema(
      id: 3,
      name: r'isExpired',
      type: IsarType.bool,
    ),
    r'organizationId': PropertySchema(
      id: 4,
      name: r'organizationId',
      type: IsarType.string,
    ),
    r'organizationJson': PropertySchema(
      id: 5,
      name: r'organizationJson',
      type: IsarType.string,
    ),
    r'organizationType': PropertySchema(
      id: 6,
      name: r'organizationType',
      type: IsarType.string,
    )
  },
  estimateSize: _cachedOrganizationEstimateSize,
  serialize: _cachedOrganizationSerialize,
  deserialize: _cachedOrganizationDeserialize,
  deserializeProp: _cachedOrganizationDeserializeProp,
  idName: r'id',
  indexes: {
    r'organizationId': IndexSchema(
      id: 6034903298354724267,
      name: r'organizationId',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'organizationId',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
    r'createdAt': IndexSchema(
      id: -3433535483987302584,
      name: r'createdAt',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'createdAt',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _cachedOrganizationGetId,
  getLinks: _cachedOrganizationGetLinks,
  attach: _cachedOrganizationAttach,
  version: '3.1.0+1',
);

int _cachedOrganizationEstimateSize(
  CachedOrganization object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.organizationId.length * 3;
  bytesCount += 3 + object.organizationJson.length * 3;
  bytesCount += 3 + object.organizationType.length * 3;
  return bytesCount;
}

void _cachedOrganizationSerialize(
  CachedOrganization object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDateTime(offsets[0], object.createdAt);
  writer.writeDateTime(offsets[1], object.expiresAt);
  writer.writeBool(offsets[2], object.isActive);
  writer.writeBool(offsets[3], object.isExpired);
  writer.writeString(offsets[4], object.organizationId);
  writer.writeString(offsets[5], object.organizationJson);
  writer.writeString(offsets[6], object.organizationType);
}

CachedOrganization _cachedOrganizationDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = CachedOrganization();
  object.createdAt = reader.readDateTime(offsets[0]);
  object.expiresAt = reader.readDateTime(offsets[1]);
  object.id = id;
  object.isActive = reader.readBool(offsets[2]);
  object.organizationId = reader.readString(offsets[4]);
  object.organizationJson = reader.readString(offsets[5]);
  object.organizationType = reader.readString(offsets[6]);
  return object;
}

P _cachedOrganizationDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDateTime(offset)) as P;
    case 1:
      return (reader.readDateTime(offset)) as P;
    case 2:
      return (reader.readBool(offset)) as P;
    case 3:
      return (reader.readBool(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
      return (reader.readString(offset)) as P;
    case 6:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _cachedOrganizationGetId(CachedOrganization object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _cachedOrganizationGetLinks(
    CachedOrganization object) {
  return [];
}

void _cachedOrganizationAttach(
    IsarCollection<dynamic> col, Id id, CachedOrganization object) {
  object.id = id;
}

extension CachedOrganizationQueryWhereSort
    on QueryBuilder<CachedOrganization, CachedOrganization, QWhere> {
  QueryBuilder<CachedOrganization, CachedOrganization, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<CachedOrganization, CachedOrganization, QAfterWhere>
      anyCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'createdAt'),
      );
    });
  }
}

extension CachedOrganizationQueryWhere
    on QueryBuilder<CachedOrganization, CachedOrganization, QWhereClause> {
  QueryBuilder<CachedOrganization, CachedOrganization, QAfterWhereClause>
      idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<CachedOrganization, CachedOrganization, QAfterWhereClause>
      idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<CachedOrganization, CachedOrganization, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<CachedOrganization, CachedOrganization, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<CachedOrganization, CachedOrganization, QAfterWhereClause>
      idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CachedOrganization, CachedOrganization, QAfterWhereClause>
      organizationIdEqualTo(String organizationId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'organizationId',
        value: [organizationId],
      ));
    });
  }

  QueryBuilder<CachedOrganization, CachedOrganization, QAfterWhereClause>
      organizationIdNotEqualTo(String organizationId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'organizationId',
              lower: [],
              upper: [organizationId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'organizationId',
              lower: [organizationId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'organizationId',
              lower: [organizationId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'organizationId',
              lower: [],
              upper: [organizationId],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<CachedOrganization, CachedOrganization, QAfterWhereClause>
      createdAtEqualTo(DateTime createdAt) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'createdAt',
        value: [createdAt],
      ));
    });
  }

  QueryBuilder<CachedOrganization, CachedOrganization, QAfterWhereClause>
      createdAtNotEqualTo(DateTime createdAt) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'createdAt',
              lower: [],
              upper: [createdAt],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'createdAt',
              lower: [createdAt],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'createdAt',
              lower: [createdAt],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'createdAt',
              lower: [],
              upper: [createdAt],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<CachedOrganization, CachedOrganization, QAfterWhereClause>
      createdAtGreaterThan(
    DateTime createdAt, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'createdAt',
        lower: [createdAt],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<CachedOrganization, CachedOrganization, QAfterWhereClause>
      createdAtLessThan(
    DateTime createdAt, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'createdAt',
        lower: [],
        upper: [createdAt],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<CachedOrganization, CachedOrganization, QAfterWhereClause>
      createdAtBetween(
    DateTime lowerCreatedAt,
    DateTime upperCreatedAt, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'createdAt',
        lower: [lowerCreatedAt],
        includeLower: includeLower,
        upper: [upperCreatedAt],
        includeUpper: includeUpper,
      ));
    });
  }
}

extension CachedOrganizationQueryFilter
    on QueryBuilder<CachedOrganization, CachedOrganization, QFilterCondition> {
  QueryBuilder<CachedOrganization, CachedOrganization, QAfterFilterCondition>
      createdAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<CachedOrganization, CachedOrganization, QAfterFilterCondition>
      createdAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<CachedOrganization, CachedOrganization, QAfterFilterCondition>
      createdAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<CachedOrganization, CachedOrganization, QAfterFilterCondition>
      createdAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'createdAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CachedOrganization, CachedOrganization, QAfterFilterCondition>
      expiresAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'expiresAt',
        value: value,
      ));
    });
  }

  QueryBuilder<CachedOrganization, CachedOrganization, QAfterFilterCondition>
      expiresAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'expiresAt',
        value: value,
      ));
    });
  }

  QueryBuilder<CachedOrganization, CachedOrganization, QAfterFilterCondition>
      expiresAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'expiresAt',
        value: value,
      ));
    });
  }

  QueryBuilder<CachedOrganization, CachedOrganization, QAfterFilterCondition>
      expiresAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'expiresAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CachedOrganization, CachedOrganization, QAfterFilterCondition>
      idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<CachedOrganization, CachedOrganization, QAfterFilterCondition>
      idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<CachedOrganization, CachedOrganization, QAfterFilterCondition>
      idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<CachedOrganization, CachedOrganization, QAfterFilterCondition>
      idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CachedOrganization, CachedOrganization, QAfterFilterCondition>
      isActiveEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isActive',
        value: value,
      ));
    });
  }

  QueryBuilder<CachedOrganization, CachedOrganization, QAfterFilterCondition>
      isExpiredEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isExpired',
        value: value,
      ));
    });
  }

  QueryBuilder<CachedOrganization, CachedOrganization, QAfterFilterCondition>
      organizationIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'organizationId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedOrganization, CachedOrganization, QAfterFilterCondition>
      organizationIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'organizationId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedOrganization, CachedOrganization, QAfterFilterCondition>
      organizationIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'organizationId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedOrganization, CachedOrganization, QAfterFilterCondition>
      organizationIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'organizationId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedOrganization, CachedOrganization, QAfterFilterCondition>
      organizationIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'organizationId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedOrganization, CachedOrganization, QAfterFilterCondition>
      organizationIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'organizationId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedOrganization, CachedOrganization, QAfterFilterCondition>
      organizationIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'organizationId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedOrganization, CachedOrganization, QAfterFilterCondition>
      organizationIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'organizationId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedOrganization, CachedOrganization, QAfterFilterCondition>
      organizationIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'organizationId',
        value: '',
      ));
    });
  }

  QueryBuilder<CachedOrganization, CachedOrganization, QAfterFilterCondition>
      organizationIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'organizationId',
        value: '',
      ));
    });
  }

  QueryBuilder<CachedOrganization, CachedOrganization, QAfterFilterCondition>
      organizationJsonEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'organizationJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedOrganization, CachedOrganization, QAfterFilterCondition>
      organizationJsonGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'organizationJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedOrganization, CachedOrganization, QAfterFilterCondition>
      organizationJsonLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'organizationJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedOrganization, CachedOrganization, QAfterFilterCondition>
      organizationJsonBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'organizationJson',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedOrganization, CachedOrganization, QAfterFilterCondition>
      organizationJsonStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'organizationJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedOrganization, CachedOrganization, QAfterFilterCondition>
      organizationJsonEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'organizationJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedOrganization, CachedOrganization, QAfterFilterCondition>
      organizationJsonContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'organizationJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedOrganization, CachedOrganization, QAfterFilterCondition>
      organizationJsonMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'organizationJson',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedOrganization, CachedOrganization, QAfterFilterCondition>
      organizationJsonIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'organizationJson',
        value: '',
      ));
    });
  }

  QueryBuilder<CachedOrganization, CachedOrganization, QAfterFilterCondition>
      organizationJsonIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'organizationJson',
        value: '',
      ));
    });
  }

  QueryBuilder<CachedOrganization, CachedOrganization, QAfterFilterCondition>
      organizationTypeEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'organizationType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedOrganization, CachedOrganization, QAfterFilterCondition>
      organizationTypeGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'organizationType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedOrganization, CachedOrganization, QAfterFilterCondition>
      organizationTypeLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'organizationType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedOrganization, CachedOrganization, QAfterFilterCondition>
      organizationTypeBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'organizationType',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedOrganization, CachedOrganization, QAfterFilterCondition>
      organizationTypeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'organizationType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedOrganization, CachedOrganization, QAfterFilterCondition>
      organizationTypeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'organizationType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedOrganization, CachedOrganization, QAfterFilterCondition>
      organizationTypeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'organizationType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedOrganization, CachedOrganization, QAfterFilterCondition>
      organizationTypeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'organizationType',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedOrganization, CachedOrganization, QAfterFilterCondition>
      organizationTypeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'organizationType',
        value: '',
      ));
    });
  }

  QueryBuilder<CachedOrganization, CachedOrganization, QAfterFilterCondition>
      organizationTypeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'organizationType',
        value: '',
      ));
    });
  }
}

extension CachedOrganizationQueryObject
    on QueryBuilder<CachedOrganization, CachedOrganization, QFilterCondition> {}

extension CachedOrganizationQueryLinks
    on QueryBuilder<CachedOrganization, CachedOrganization, QFilterCondition> {}

extension CachedOrganizationQuerySortBy
    on QueryBuilder<CachedOrganization, CachedOrganization, QSortBy> {
  QueryBuilder<CachedOrganization, CachedOrganization, QAfterSortBy>
      sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<CachedOrganization, CachedOrganization, QAfterSortBy>
      sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<CachedOrganization, CachedOrganization, QAfterSortBy>
      sortByExpiresAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'expiresAt', Sort.asc);
    });
  }

  QueryBuilder<CachedOrganization, CachedOrganization, QAfterSortBy>
      sortByExpiresAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'expiresAt', Sort.desc);
    });
  }

  QueryBuilder<CachedOrganization, CachedOrganization, QAfterSortBy>
      sortByIsActive() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isActive', Sort.asc);
    });
  }

  QueryBuilder<CachedOrganization, CachedOrganization, QAfterSortBy>
      sortByIsActiveDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isActive', Sort.desc);
    });
  }

  QueryBuilder<CachedOrganization, CachedOrganization, QAfterSortBy>
      sortByIsExpired() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isExpired', Sort.asc);
    });
  }

  QueryBuilder<CachedOrganization, CachedOrganization, QAfterSortBy>
      sortByIsExpiredDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isExpired', Sort.desc);
    });
  }

  QueryBuilder<CachedOrganization, CachedOrganization, QAfterSortBy>
      sortByOrganizationId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'organizationId', Sort.asc);
    });
  }

  QueryBuilder<CachedOrganization, CachedOrganization, QAfterSortBy>
      sortByOrganizationIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'organizationId', Sort.desc);
    });
  }

  QueryBuilder<CachedOrganization, CachedOrganization, QAfterSortBy>
      sortByOrganizationJson() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'organizationJson', Sort.asc);
    });
  }

  QueryBuilder<CachedOrganization, CachedOrganization, QAfterSortBy>
      sortByOrganizationJsonDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'organizationJson', Sort.desc);
    });
  }

  QueryBuilder<CachedOrganization, CachedOrganization, QAfterSortBy>
      sortByOrganizationType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'organizationType', Sort.asc);
    });
  }

  QueryBuilder<CachedOrganization, CachedOrganization, QAfterSortBy>
      sortByOrganizationTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'organizationType', Sort.desc);
    });
  }
}

extension CachedOrganizationQuerySortThenBy
    on QueryBuilder<CachedOrganization, CachedOrganization, QSortThenBy> {
  QueryBuilder<CachedOrganization, CachedOrganization, QAfterSortBy>
      thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<CachedOrganization, CachedOrganization, QAfterSortBy>
      thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<CachedOrganization, CachedOrganization, QAfterSortBy>
      thenByExpiresAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'expiresAt', Sort.asc);
    });
  }

  QueryBuilder<CachedOrganization, CachedOrganization, QAfterSortBy>
      thenByExpiresAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'expiresAt', Sort.desc);
    });
  }

  QueryBuilder<CachedOrganization, CachedOrganization, QAfterSortBy>
      thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<CachedOrganization, CachedOrganization, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<CachedOrganization, CachedOrganization, QAfterSortBy>
      thenByIsActive() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isActive', Sort.asc);
    });
  }

  QueryBuilder<CachedOrganization, CachedOrganization, QAfterSortBy>
      thenByIsActiveDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isActive', Sort.desc);
    });
  }

  QueryBuilder<CachedOrganization, CachedOrganization, QAfterSortBy>
      thenByIsExpired() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isExpired', Sort.asc);
    });
  }

  QueryBuilder<CachedOrganization, CachedOrganization, QAfterSortBy>
      thenByIsExpiredDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isExpired', Sort.desc);
    });
  }

  QueryBuilder<CachedOrganization, CachedOrganization, QAfterSortBy>
      thenByOrganizationId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'organizationId', Sort.asc);
    });
  }

  QueryBuilder<CachedOrganization, CachedOrganization, QAfterSortBy>
      thenByOrganizationIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'organizationId', Sort.desc);
    });
  }

  QueryBuilder<CachedOrganization, CachedOrganization, QAfterSortBy>
      thenByOrganizationJson() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'organizationJson', Sort.asc);
    });
  }

  QueryBuilder<CachedOrganization, CachedOrganization, QAfterSortBy>
      thenByOrganizationJsonDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'organizationJson', Sort.desc);
    });
  }

  QueryBuilder<CachedOrganization, CachedOrganization, QAfterSortBy>
      thenByOrganizationType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'organizationType', Sort.asc);
    });
  }

  QueryBuilder<CachedOrganization, CachedOrganization, QAfterSortBy>
      thenByOrganizationTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'organizationType', Sort.desc);
    });
  }
}

extension CachedOrganizationQueryWhereDistinct
    on QueryBuilder<CachedOrganization, CachedOrganization, QDistinct> {
  QueryBuilder<CachedOrganization, CachedOrganization, QDistinct>
      distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt');
    });
  }

  QueryBuilder<CachedOrganization, CachedOrganization, QDistinct>
      distinctByExpiresAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'expiresAt');
    });
  }

  QueryBuilder<CachedOrganization, CachedOrganization, QDistinct>
      distinctByIsActive() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isActive');
    });
  }

  QueryBuilder<CachedOrganization, CachedOrganization, QDistinct>
      distinctByIsExpired() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isExpired');
    });
  }

  QueryBuilder<CachedOrganization, CachedOrganization, QDistinct>
      distinctByOrganizationId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'organizationId',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CachedOrganization, CachedOrganization, QDistinct>
      distinctByOrganizationJson({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'organizationJson',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CachedOrganization, CachedOrganization, QDistinct>
      distinctByOrganizationType({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'organizationType',
          caseSensitive: caseSensitive);
    });
  }
}

extension CachedOrganizationQueryProperty
    on QueryBuilder<CachedOrganization, CachedOrganization, QQueryProperty> {
  QueryBuilder<CachedOrganization, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<CachedOrganization, DateTime, QQueryOperations>
      createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<CachedOrganization, DateTime, QQueryOperations>
      expiresAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'expiresAt');
    });
  }

  QueryBuilder<CachedOrganization, bool, QQueryOperations> isActiveProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isActive');
    });
  }

  QueryBuilder<CachedOrganization, bool, QQueryOperations> isExpiredProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isExpired');
    });
  }

  QueryBuilder<CachedOrganization, String, QQueryOperations>
      organizationIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'organizationId');
    });
  }

  QueryBuilder<CachedOrganization, String, QQueryOperations>
      organizationJsonProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'organizationJson');
    });
  }

  QueryBuilder<CachedOrganization, String, QQueryOperations>
      organizationTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'organizationType');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetCachedPermissionsCollection on Isar {
  IsarCollection<CachedPermissions> get cachedPermissions => this.collection();
}

const CachedPermissionsSchema = CollectionSchema(
  name: r'CachedPermissions',
  id: -2664863671775315560,
  properties: {
    r'context': PropertySchema(
      id: 0,
      name: r'context',
      type: IsarType.string,
    ),
    r'createdAt': PropertySchema(
      id: 1,
      name: r'createdAt',
      type: IsarType.dateTime,
    ),
    r'expiresAt': PropertySchema(
      id: 2,
      name: r'expiresAt',
      type: IsarType.dateTime,
    ),
    r'isExpired': PropertySchema(
      id: 3,
      name: r'isExpired',
      type: IsarType.bool,
    ),
    r'permissionsJson': PropertySchema(
      id: 4,
      name: r'permissionsJson',
      type: IsarType.string,
    ),
    r'userId': PropertySchema(
      id: 5,
      name: r'userId',
      type: IsarType.string,
    )
  },
  estimateSize: _cachedPermissionsEstimateSize,
  serialize: _cachedPermissionsSerialize,
  deserialize: _cachedPermissionsDeserialize,
  deserializeProp: _cachedPermissionsDeserializeProp,
  idName: r'id',
  indexes: {
    r'userId': IndexSchema(
      id: -2005826577402374815,
      name: r'userId',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'userId',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
    r'createdAt': IndexSchema(
      id: -3433535483987302584,
      name: r'createdAt',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'createdAt',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _cachedPermissionsGetId,
  getLinks: _cachedPermissionsGetLinks,
  attach: _cachedPermissionsAttach,
  version: '3.1.0+1',
);

int _cachedPermissionsEstimateSize(
  CachedPermissions object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.context;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.permissionsJson.length * 3;
  bytesCount += 3 + object.userId.length * 3;
  return bytesCount;
}

void _cachedPermissionsSerialize(
  CachedPermissions object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.context);
  writer.writeDateTime(offsets[1], object.createdAt);
  writer.writeDateTime(offsets[2], object.expiresAt);
  writer.writeBool(offsets[3], object.isExpired);
  writer.writeString(offsets[4], object.permissionsJson);
  writer.writeString(offsets[5], object.userId);
}

CachedPermissions _cachedPermissionsDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = CachedPermissions();
  object.context = reader.readStringOrNull(offsets[0]);
  object.createdAt = reader.readDateTime(offsets[1]);
  object.expiresAt = reader.readDateTime(offsets[2]);
  object.id = id;
  object.permissionsJson = reader.readString(offsets[4]);
  object.userId = reader.readString(offsets[5]);
  return object;
}

P _cachedPermissionsDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readDateTime(offset)) as P;
    case 2:
      return (reader.readDateTime(offset)) as P;
    case 3:
      return (reader.readBool(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _cachedPermissionsGetId(CachedPermissions object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _cachedPermissionsGetLinks(
    CachedPermissions object) {
  return [];
}

void _cachedPermissionsAttach(
    IsarCollection<dynamic> col, Id id, CachedPermissions object) {
  object.id = id;
}

extension CachedPermissionsQueryWhereSort
    on QueryBuilder<CachedPermissions, CachedPermissions, QWhere> {
  QueryBuilder<CachedPermissions, CachedPermissions, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<CachedPermissions, CachedPermissions, QAfterWhere>
      anyCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'createdAt'),
      );
    });
  }
}

extension CachedPermissionsQueryWhere
    on QueryBuilder<CachedPermissions, CachedPermissions, QWhereClause> {
  QueryBuilder<CachedPermissions, CachedPermissions, QAfterWhereClause>
      idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<CachedPermissions, CachedPermissions, QAfterWhereClause>
      idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<CachedPermissions, CachedPermissions, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<CachedPermissions, CachedPermissions, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<CachedPermissions, CachedPermissions, QAfterWhereClause>
      idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CachedPermissions, CachedPermissions, QAfterWhereClause>
      userIdEqualTo(String userId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'userId',
        value: [userId],
      ));
    });
  }

  QueryBuilder<CachedPermissions, CachedPermissions, QAfterWhereClause>
      userIdNotEqualTo(String userId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'userId',
              lower: [],
              upper: [userId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'userId',
              lower: [userId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'userId',
              lower: [userId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'userId',
              lower: [],
              upper: [userId],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<CachedPermissions, CachedPermissions, QAfterWhereClause>
      createdAtEqualTo(DateTime createdAt) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'createdAt',
        value: [createdAt],
      ));
    });
  }

  QueryBuilder<CachedPermissions, CachedPermissions, QAfterWhereClause>
      createdAtNotEqualTo(DateTime createdAt) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'createdAt',
              lower: [],
              upper: [createdAt],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'createdAt',
              lower: [createdAt],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'createdAt',
              lower: [createdAt],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'createdAt',
              lower: [],
              upper: [createdAt],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<CachedPermissions, CachedPermissions, QAfterWhereClause>
      createdAtGreaterThan(
    DateTime createdAt, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'createdAt',
        lower: [createdAt],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<CachedPermissions, CachedPermissions, QAfterWhereClause>
      createdAtLessThan(
    DateTime createdAt, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'createdAt',
        lower: [],
        upper: [createdAt],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<CachedPermissions, CachedPermissions, QAfterWhereClause>
      createdAtBetween(
    DateTime lowerCreatedAt,
    DateTime upperCreatedAt, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'createdAt',
        lower: [lowerCreatedAt],
        includeLower: includeLower,
        upper: [upperCreatedAt],
        includeUpper: includeUpper,
      ));
    });
  }
}

extension CachedPermissionsQueryFilter
    on QueryBuilder<CachedPermissions, CachedPermissions, QFilterCondition> {
  QueryBuilder<CachedPermissions, CachedPermissions, QAfterFilterCondition>
      contextIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'context',
      ));
    });
  }

  QueryBuilder<CachedPermissions, CachedPermissions, QAfterFilterCondition>
      contextIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'context',
      ));
    });
  }

  QueryBuilder<CachedPermissions, CachedPermissions, QAfterFilterCondition>
      contextEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'context',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedPermissions, CachedPermissions, QAfterFilterCondition>
      contextGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'context',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedPermissions, CachedPermissions, QAfterFilterCondition>
      contextLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'context',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedPermissions, CachedPermissions, QAfterFilterCondition>
      contextBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'context',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedPermissions, CachedPermissions, QAfterFilterCondition>
      contextStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'context',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedPermissions, CachedPermissions, QAfterFilterCondition>
      contextEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'context',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedPermissions, CachedPermissions, QAfterFilterCondition>
      contextContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'context',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedPermissions, CachedPermissions, QAfterFilterCondition>
      contextMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'context',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedPermissions, CachedPermissions, QAfterFilterCondition>
      contextIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'context',
        value: '',
      ));
    });
  }

  QueryBuilder<CachedPermissions, CachedPermissions, QAfterFilterCondition>
      contextIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'context',
        value: '',
      ));
    });
  }

  QueryBuilder<CachedPermissions, CachedPermissions, QAfterFilterCondition>
      createdAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<CachedPermissions, CachedPermissions, QAfterFilterCondition>
      createdAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<CachedPermissions, CachedPermissions, QAfterFilterCondition>
      createdAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<CachedPermissions, CachedPermissions, QAfterFilterCondition>
      createdAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'createdAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CachedPermissions, CachedPermissions, QAfterFilterCondition>
      expiresAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'expiresAt',
        value: value,
      ));
    });
  }

  QueryBuilder<CachedPermissions, CachedPermissions, QAfterFilterCondition>
      expiresAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'expiresAt',
        value: value,
      ));
    });
  }

  QueryBuilder<CachedPermissions, CachedPermissions, QAfterFilterCondition>
      expiresAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'expiresAt',
        value: value,
      ));
    });
  }

  QueryBuilder<CachedPermissions, CachedPermissions, QAfterFilterCondition>
      expiresAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'expiresAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CachedPermissions, CachedPermissions, QAfterFilterCondition>
      idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<CachedPermissions, CachedPermissions, QAfterFilterCondition>
      idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<CachedPermissions, CachedPermissions, QAfterFilterCondition>
      idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<CachedPermissions, CachedPermissions, QAfterFilterCondition>
      idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CachedPermissions, CachedPermissions, QAfterFilterCondition>
      isExpiredEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isExpired',
        value: value,
      ));
    });
  }

  QueryBuilder<CachedPermissions, CachedPermissions, QAfterFilterCondition>
      permissionsJsonEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'permissionsJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedPermissions, CachedPermissions, QAfterFilterCondition>
      permissionsJsonGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'permissionsJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedPermissions, CachedPermissions, QAfterFilterCondition>
      permissionsJsonLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'permissionsJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedPermissions, CachedPermissions, QAfterFilterCondition>
      permissionsJsonBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'permissionsJson',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedPermissions, CachedPermissions, QAfterFilterCondition>
      permissionsJsonStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'permissionsJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedPermissions, CachedPermissions, QAfterFilterCondition>
      permissionsJsonEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'permissionsJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedPermissions, CachedPermissions, QAfterFilterCondition>
      permissionsJsonContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'permissionsJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedPermissions, CachedPermissions, QAfterFilterCondition>
      permissionsJsonMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'permissionsJson',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedPermissions, CachedPermissions, QAfterFilterCondition>
      permissionsJsonIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'permissionsJson',
        value: '',
      ));
    });
  }

  QueryBuilder<CachedPermissions, CachedPermissions, QAfterFilterCondition>
      permissionsJsonIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'permissionsJson',
        value: '',
      ));
    });
  }

  QueryBuilder<CachedPermissions, CachedPermissions, QAfterFilterCondition>
      userIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'userId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedPermissions, CachedPermissions, QAfterFilterCondition>
      userIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'userId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedPermissions, CachedPermissions, QAfterFilterCondition>
      userIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'userId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedPermissions, CachedPermissions, QAfterFilterCondition>
      userIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'userId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedPermissions, CachedPermissions, QAfterFilterCondition>
      userIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'userId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedPermissions, CachedPermissions, QAfterFilterCondition>
      userIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'userId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedPermissions, CachedPermissions, QAfterFilterCondition>
      userIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'userId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedPermissions, CachedPermissions, QAfterFilterCondition>
      userIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'userId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedPermissions, CachedPermissions, QAfterFilterCondition>
      userIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'userId',
        value: '',
      ));
    });
  }

  QueryBuilder<CachedPermissions, CachedPermissions, QAfterFilterCondition>
      userIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'userId',
        value: '',
      ));
    });
  }
}

extension CachedPermissionsQueryObject
    on QueryBuilder<CachedPermissions, CachedPermissions, QFilterCondition> {}

extension CachedPermissionsQueryLinks
    on QueryBuilder<CachedPermissions, CachedPermissions, QFilterCondition> {}

extension CachedPermissionsQuerySortBy
    on QueryBuilder<CachedPermissions, CachedPermissions, QSortBy> {
  QueryBuilder<CachedPermissions, CachedPermissions, QAfterSortBy>
      sortByContext() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'context', Sort.asc);
    });
  }

  QueryBuilder<CachedPermissions, CachedPermissions, QAfterSortBy>
      sortByContextDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'context', Sort.desc);
    });
  }

  QueryBuilder<CachedPermissions, CachedPermissions, QAfterSortBy>
      sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<CachedPermissions, CachedPermissions, QAfterSortBy>
      sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<CachedPermissions, CachedPermissions, QAfterSortBy>
      sortByExpiresAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'expiresAt', Sort.asc);
    });
  }

  QueryBuilder<CachedPermissions, CachedPermissions, QAfterSortBy>
      sortByExpiresAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'expiresAt', Sort.desc);
    });
  }

  QueryBuilder<CachedPermissions, CachedPermissions, QAfterSortBy>
      sortByIsExpired() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isExpired', Sort.asc);
    });
  }

  QueryBuilder<CachedPermissions, CachedPermissions, QAfterSortBy>
      sortByIsExpiredDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isExpired', Sort.desc);
    });
  }

  QueryBuilder<CachedPermissions, CachedPermissions, QAfterSortBy>
      sortByPermissionsJson() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'permissionsJson', Sort.asc);
    });
  }

  QueryBuilder<CachedPermissions, CachedPermissions, QAfterSortBy>
      sortByPermissionsJsonDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'permissionsJson', Sort.desc);
    });
  }

  QueryBuilder<CachedPermissions, CachedPermissions, QAfterSortBy>
      sortByUserId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.asc);
    });
  }

  QueryBuilder<CachedPermissions, CachedPermissions, QAfterSortBy>
      sortByUserIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.desc);
    });
  }
}

extension CachedPermissionsQuerySortThenBy
    on QueryBuilder<CachedPermissions, CachedPermissions, QSortThenBy> {
  QueryBuilder<CachedPermissions, CachedPermissions, QAfterSortBy>
      thenByContext() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'context', Sort.asc);
    });
  }

  QueryBuilder<CachedPermissions, CachedPermissions, QAfterSortBy>
      thenByContextDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'context', Sort.desc);
    });
  }

  QueryBuilder<CachedPermissions, CachedPermissions, QAfterSortBy>
      thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<CachedPermissions, CachedPermissions, QAfterSortBy>
      thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<CachedPermissions, CachedPermissions, QAfterSortBy>
      thenByExpiresAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'expiresAt', Sort.asc);
    });
  }

  QueryBuilder<CachedPermissions, CachedPermissions, QAfterSortBy>
      thenByExpiresAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'expiresAt', Sort.desc);
    });
  }

  QueryBuilder<CachedPermissions, CachedPermissions, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<CachedPermissions, CachedPermissions, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<CachedPermissions, CachedPermissions, QAfterSortBy>
      thenByIsExpired() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isExpired', Sort.asc);
    });
  }

  QueryBuilder<CachedPermissions, CachedPermissions, QAfterSortBy>
      thenByIsExpiredDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isExpired', Sort.desc);
    });
  }

  QueryBuilder<CachedPermissions, CachedPermissions, QAfterSortBy>
      thenByPermissionsJson() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'permissionsJson', Sort.asc);
    });
  }

  QueryBuilder<CachedPermissions, CachedPermissions, QAfterSortBy>
      thenByPermissionsJsonDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'permissionsJson', Sort.desc);
    });
  }

  QueryBuilder<CachedPermissions, CachedPermissions, QAfterSortBy>
      thenByUserId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.asc);
    });
  }

  QueryBuilder<CachedPermissions, CachedPermissions, QAfterSortBy>
      thenByUserIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.desc);
    });
  }
}

extension CachedPermissionsQueryWhereDistinct
    on QueryBuilder<CachedPermissions, CachedPermissions, QDistinct> {
  QueryBuilder<CachedPermissions, CachedPermissions, QDistinct>
      distinctByContext({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'context', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CachedPermissions, CachedPermissions, QDistinct>
      distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt');
    });
  }

  QueryBuilder<CachedPermissions, CachedPermissions, QDistinct>
      distinctByExpiresAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'expiresAt');
    });
  }

  QueryBuilder<CachedPermissions, CachedPermissions, QDistinct>
      distinctByIsExpired() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isExpired');
    });
  }

  QueryBuilder<CachedPermissions, CachedPermissions, QDistinct>
      distinctByPermissionsJson({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'permissionsJson',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CachedPermissions, CachedPermissions, QDistinct>
      distinctByUserId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'userId', caseSensitive: caseSensitive);
    });
  }
}

extension CachedPermissionsQueryProperty
    on QueryBuilder<CachedPermissions, CachedPermissions, QQueryProperty> {
  QueryBuilder<CachedPermissions, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<CachedPermissions, String?, QQueryOperations> contextProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'context');
    });
  }

  QueryBuilder<CachedPermissions, DateTime, QQueryOperations>
      createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<CachedPermissions, DateTime, QQueryOperations>
      expiresAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'expiresAt');
    });
  }

  QueryBuilder<CachedPermissions, bool, QQueryOperations> isExpiredProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isExpired');
    });
  }

  QueryBuilder<CachedPermissions, String, QQueryOperations>
      permissionsJsonProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'permissionsJson');
    });
  }

  QueryBuilder<CachedPermissions, String, QQueryOperations> userIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'userId');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetSystemMetadataCollection on Isar {
  IsarCollection<SystemMetadata> get systemMetadatas => this.collection();
}

const SystemMetadataSchema = CollectionSchema(
  name: r'SystemMetadata',
  id: 1655991868742086395,
  properties: {
    r'description': PropertySchema(
      id: 0,
      name: r'description',
      type: IsarType.string,
    ),
    r'key': PropertySchema(
      id: 1,
      name: r'key',
      type: IsarType.string,
    ),
    r'updatedAt': PropertySchema(
      id: 2,
      name: r'updatedAt',
      type: IsarType.dateTime,
    ),
    r'value': PropertySchema(
      id: 3,
      name: r'value',
      type: IsarType.string,
    )
  },
  estimateSize: _systemMetadataEstimateSize,
  serialize: _systemMetadataSerialize,
  deserialize: _systemMetadataDeserialize,
  deserializeProp: _systemMetadataDeserializeProp,
  idName: r'id',
  indexes: {
    r'key': IndexSchema(
      id: -4906094122524121629,
      name: r'key',
      unique: true,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'key',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _systemMetadataGetId,
  getLinks: _systemMetadataGetLinks,
  attach: _systemMetadataAttach,
  version: '3.1.0+1',
);

int _systemMetadataEstimateSize(
  SystemMetadata object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.description;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.key.length * 3;
  bytesCount += 3 + object.value.length * 3;
  return bytesCount;
}

void _systemMetadataSerialize(
  SystemMetadata object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.description);
  writer.writeString(offsets[1], object.key);
  writer.writeDateTime(offsets[2], object.updatedAt);
  writer.writeString(offsets[3], object.value);
}

SystemMetadata _systemMetadataDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = SystemMetadata();
  object.description = reader.readStringOrNull(offsets[0]);
  object.id = id;
  object.key = reader.readString(offsets[1]);
  object.updatedAt = reader.readDateTime(offsets[2]);
  object.value = reader.readString(offsets[3]);
  return object;
}

P _systemMetadataDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readDateTime(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _systemMetadataGetId(SystemMetadata object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _systemMetadataGetLinks(SystemMetadata object) {
  return [];
}

void _systemMetadataAttach(
    IsarCollection<dynamic> col, Id id, SystemMetadata object) {
  object.id = id;
}

extension SystemMetadataByIndex on IsarCollection<SystemMetadata> {
  Future<SystemMetadata?> getByKey(String key) {
    return getByIndex(r'key', [key]);
  }

  SystemMetadata? getByKeySync(String key) {
    return getByIndexSync(r'key', [key]);
  }

  Future<bool> deleteByKey(String key) {
    return deleteByIndex(r'key', [key]);
  }

  bool deleteByKeySync(String key) {
    return deleteByIndexSync(r'key', [key]);
  }

  Future<List<SystemMetadata?>> getAllByKey(List<String> keyValues) {
    final values = keyValues.map((e) => [e]).toList();
    return getAllByIndex(r'key', values);
  }

  List<SystemMetadata?> getAllByKeySync(List<String> keyValues) {
    final values = keyValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'key', values);
  }

  Future<int> deleteAllByKey(List<String> keyValues) {
    final values = keyValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'key', values);
  }

  int deleteAllByKeySync(List<String> keyValues) {
    final values = keyValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'key', values);
  }

  Future<Id> putByKey(SystemMetadata object) {
    return putByIndex(r'key', object);
  }

  Id putByKeySync(SystemMetadata object, {bool saveLinks = true}) {
    return putByIndexSync(r'key', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByKey(List<SystemMetadata> objects) {
    return putAllByIndex(r'key', objects);
  }

  List<Id> putAllByKeySync(List<SystemMetadata> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'key', objects, saveLinks: saveLinks);
  }
}

extension SystemMetadataQueryWhereSort
    on QueryBuilder<SystemMetadata, SystemMetadata, QWhere> {
  QueryBuilder<SystemMetadata, SystemMetadata, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension SystemMetadataQueryWhere
    on QueryBuilder<SystemMetadata, SystemMetadata, QWhereClause> {
  QueryBuilder<SystemMetadata, SystemMetadata, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<SystemMetadata, SystemMetadata, QAfterWhereClause> idNotEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<SystemMetadata, SystemMetadata, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<SystemMetadata, SystemMetadata, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<SystemMetadata, SystemMetadata, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<SystemMetadata, SystemMetadata, QAfterWhereClause> keyEqualTo(
      String key) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'key',
        value: [key],
      ));
    });
  }

  QueryBuilder<SystemMetadata, SystemMetadata, QAfterWhereClause> keyNotEqualTo(
      String key) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'key',
              lower: [],
              upper: [key],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'key',
              lower: [key],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'key',
              lower: [key],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'key',
              lower: [],
              upper: [key],
              includeUpper: false,
            ));
      }
    });
  }
}

extension SystemMetadataQueryFilter
    on QueryBuilder<SystemMetadata, SystemMetadata, QFilterCondition> {
  QueryBuilder<SystemMetadata, SystemMetadata, QAfterFilterCondition>
      descriptionIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'description',
      ));
    });
  }

  QueryBuilder<SystemMetadata, SystemMetadata, QAfterFilterCondition>
      descriptionIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'description',
      ));
    });
  }

  QueryBuilder<SystemMetadata, SystemMetadata, QAfterFilterCondition>
      descriptionEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SystemMetadata, SystemMetadata, QAfterFilterCondition>
      descriptionGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SystemMetadata, SystemMetadata, QAfterFilterCondition>
      descriptionLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SystemMetadata, SystemMetadata, QAfterFilterCondition>
      descriptionBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'description',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SystemMetadata, SystemMetadata, QAfterFilterCondition>
      descriptionStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SystemMetadata, SystemMetadata, QAfterFilterCondition>
      descriptionEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SystemMetadata, SystemMetadata, QAfterFilterCondition>
      descriptionContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SystemMetadata, SystemMetadata, QAfterFilterCondition>
      descriptionMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'description',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SystemMetadata, SystemMetadata, QAfterFilterCondition>
      descriptionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'description',
        value: '',
      ));
    });
  }

  QueryBuilder<SystemMetadata, SystemMetadata, QAfterFilterCondition>
      descriptionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'description',
        value: '',
      ));
    });
  }

  QueryBuilder<SystemMetadata, SystemMetadata, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<SystemMetadata, SystemMetadata, QAfterFilterCondition>
      idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<SystemMetadata, SystemMetadata, QAfterFilterCondition>
      idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<SystemMetadata, SystemMetadata, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<SystemMetadata, SystemMetadata, QAfterFilterCondition>
      keyEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'key',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SystemMetadata, SystemMetadata, QAfterFilterCondition>
      keyGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'key',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SystemMetadata, SystemMetadata, QAfterFilterCondition>
      keyLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'key',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SystemMetadata, SystemMetadata, QAfterFilterCondition>
      keyBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'key',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SystemMetadata, SystemMetadata, QAfterFilterCondition>
      keyStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'key',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SystemMetadata, SystemMetadata, QAfterFilterCondition>
      keyEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'key',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SystemMetadata, SystemMetadata, QAfterFilterCondition>
      keyContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'key',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SystemMetadata, SystemMetadata, QAfterFilterCondition>
      keyMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'key',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SystemMetadata, SystemMetadata, QAfterFilterCondition>
      keyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'key',
        value: '',
      ));
    });
  }

  QueryBuilder<SystemMetadata, SystemMetadata, QAfterFilterCondition>
      keyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'key',
        value: '',
      ));
    });
  }

  QueryBuilder<SystemMetadata, SystemMetadata, QAfterFilterCondition>
      updatedAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<SystemMetadata, SystemMetadata, QAfterFilterCondition>
      updatedAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<SystemMetadata, SystemMetadata, QAfterFilterCondition>
      updatedAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<SystemMetadata, SystemMetadata, QAfterFilterCondition>
      updatedAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'updatedAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<SystemMetadata, SystemMetadata, QAfterFilterCondition>
      valueEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'value',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SystemMetadata, SystemMetadata, QAfterFilterCondition>
      valueGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'value',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SystemMetadata, SystemMetadata, QAfterFilterCondition>
      valueLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'value',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SystemMetadata, SystemMetadata, QAfterFilterCondition>
      valueBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'value',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SystemMetadata, SystemMetadata, QAfterFilterCondition>
      valueStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'value',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SystemMetadata, SystemMetadata, QAfterFilterCondition>
      valueEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'value',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SystemMetadata, SystemMetadata, QAfterFilterCondition>
      valueContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'value',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SystemMetadata, SystemMetadata, QAfterFilterCondition>
      valueMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'value',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SystemMetadata, SystemMetadata, QAfterFilterCondition>
      valueIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'value',
        value: '',
      ));
    });
  }

  QueryBuilder<SystemMetadata, SystemMetadata, QAfterFilterCondition>
      valueIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'value',
        value: '',
      ));
    });
  }
}

extension SystemMetadataQueryObject
    on QueryBuilder<SystemMetadata, SystemMetadata, QFilterCondition> {}

extension SystemMetadataQueryLinks
    on QueryBuilder<SystemMetadata, SystemMetadata, QFilterCondition> {}

extension SystemMetadataQuerySortBy
    on QueryBuilder<SystemMetadata, SystemMetadata, QSortBy> {
  QueryBuilder<SystemMetadata, SystemMetadata, QAfterSortBy>
      sortByDescription() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.asc);
    });
  }

  QueryBuilder<SystemMetadata, SystemMetadata, QAfterSortBy>
      sortByDescriptionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.desc);
    });
  }

  QueryBuilder<SystemMetadata, SystemMetadata, QAfterSortBy> sortByKey() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'key', Sort.asc);
    });
  }

  QueryBuilder<SystemMetadata, SystemMetadata, QAfterSortBy> sortByKeyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'key', Sort.desc);
    });
  }

  QueryBuilder<SystemMetadata, SystemMetadata, QAfterSortBy> sortByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<SystemMetadata, SystemMetadata, QAfterSortBy>
      sortByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }

  QueryBuilder<SystemMetadata, SystemMetadata, QAfterSortBy> sortByValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'value', Sort.asc);
    });
  }

  QueryBuilder<SystemMetadata, SystemMetadata, QAfterSortBy> sortByValueDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'value', Sort.desc);
    });
  }
}

extension SystemMetadataQuerySortThenBy
    on QueryBuilder<SystemMetadata, SystemMetadata, QSortThenBy> {
  QueryBuilder<SystemMetadata, SystemMetadata, QAfterSortBy>
      thenByDescription() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.asc);
    });
  }

  QueryBuilder<SystemMetadata, SystemMetadata, QAfterSortBy>
      thenByDescriptionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.desc);
    });
  }

  QueryBuilder<SystemMetadata, SystemMetadata, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<SystemMetadata, SystemMetadata, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<SystemMetadata, SystemMetadata, QAfterSortBy> thenByKey() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'key', Sort.asc);
    });
  }

  QueryBuilder<SystemMetadata, SystemMetadata, QAfterSortBy> thenByKeyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'key', Sort.desc);
    });
  }

  QueryBuilder<SystemMetadata, SystemMetadata, QAfterSortBy> thenByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<SystemMetadata, SystemMetadata, QAfterSortBy>
      thenByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }

  QueryBuilder<SystemMetadata, SystemMetadata, QAfterSortBy> thenByValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'value', Sort.asc);
    });
  }

  QueryBuilder<SystemMetadata, SystemMetadata, QAfterSortBy> thenByValueDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'value', Sort.desc);
    });
  }
}

extension SystemMetadataQueryWhereDistinct
    on QueryBuilder<SystemMetadata, SystemMetadata, QDistinct> {
  QueryBuilder<SystemMetadata, SystemMetadata, QDistinct> distinctByDescription(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'description', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SystemMetadata, SystemMetadata, QDistinct> distinctByKey(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'key', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SystemMetadata, SystemMetadata, QDistinct>
      distinctByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'updatedAt');
    });
  }

  QueryBuilder<SystemMetadata, SystemMetadata, QDistinct> distinctByValue(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'value', caseSensitive: caseSensitive);
    });
  }
}

extension SystemMetadataQueryProperty
    on QueryBuilder<SystemMetadata, SystemMetadata, QQueryProperty> {
  QueryBuilder<SystemMetadata, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<SystemMetadata, String?, QQueryOperations>
      descriptionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'description');
    });
  }

  QueryBuilder<SystemMetadata, String, QQueryOperations> keyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'key');
    });
  }

  QueryBuilder<SystemMetadata, DateTime, QQueryOperations> updatedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'updatedAt');
    });
  }

  QueryBuilder<SystemMetadata, String, QQueryOperations> valueProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'value');
    });
  }
}
