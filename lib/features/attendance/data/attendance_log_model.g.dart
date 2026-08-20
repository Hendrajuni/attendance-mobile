// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attendance_log_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetAttendanceLogCollection on Isar {
  IsarCollection<AttendanceLog> get attendanceLogs => this.collection();
}

const AttendanceLogSchema = CollectionSchema(
  name: r'AttendanceLog',
  id: 1511539404068289100,
  properties: {
    r'isMockLocation': PropertySchema(
      id: 0,
      name: r'isMockLocation',
      type: IsarType.bool,
    ),
    r'isSynced': PropertySchema(
      id: 1,
      name: r'isSynced',
      type: IsarType.bool,
    ),
    r'latitude': PropertySchema(
      id: 2,
      name: r'latitude',
      type: IsarType.double,
    ),
    r'logCategory': PropertySchema(
      id: 3,
      name: r'logCategory',
      type: IsarType.string,
    ),
    r'longitude': PropertySchema(
      id: 4,
      name: r'longitude',
      type: IsarType.double,
    ),
    r'photoBase64': PropertySchema(
      id: 5,
      name: r'photoBase64',
      type: IsarType.string,
    ),
    r'timestamp': PropertySchema(
      id: 6,
      name: r'timestamp',
      type: IsarType.dateTime,
    )
  },
  estimateSize: _attendanceLogEstimateSize,
  serialize: _attendanceLogSerialize,
  deserialize: _attendanceLogDeserialize,
  deserializeProp: _attendanceLogDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _attendanceLogGetId,
  getLinks: _attendanceLogGetLinks,
  attach: _attendanceLogAttach,
  version: '3.1.0+1',
);

int _attendanceLogEstimateSize(
  AttendanceLog object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.logCategory.length * 3;
  {
    final value = object.photoBase64;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _attendanceLogSerialize(
  AttendanceLog object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeBool(offsets[0], object.isMockLocation);
  writer.writeBool(offsets[1], object.isSynced);
  writer.writeDouble(offsets[2], object.latitude);
  writer.writeString(offsets[3], object.logCategory);
  writer.writeDouble(offsets[4], object.longitude);
  writer.writeString(offsets[5], object.photoBase64);
  writer.writeDateTime(offsets[6], object.timestamp);
}

AttendanceLog _attendanceLogDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = AttendanceLog();
  object.id = id;
  object.isMockLocation = reader.readBool(offsets[0]);
  object.isSynced = reader.readBool(offsets[1]);
  object.latitude = reader.readDouble(offsets[2]);
  object.logCategory = reader.readString(offsets[3]);
  object.longitude = reader.readDouble(offsets[4]);
  object.photoBase64 = reader.readStringOrNull(offsets[5]);
  object.timestamp = reader.readDateTime(offsets[6]);
  return object;
}

P _attendanceLogDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readBool(offset)) as P;
    case 1:
      return (reader.readBool(offset)) as P;
    case 2:
      return (reader.readDouble(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readDouble(offset)) as P;
    case 5:
      return (reader.readStringOrNull(offset)) as P;
    case 6:
      return (reader.readDateTime(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _attendanceLogGetId(AttendanceLog object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _attendanceLogGetLinks(AttendanceLog object) {
  return [];
}

void _attendanceLogAttach(
    IsarCollection<dynamic> col, Id id, AttendanceLog object) {
  object.id = id;
}

extension AttendanceLogQueryWhereSort
    on QueryBuilder<AttendanceLog, AttendanceLog, QWhere> {
  QueryBuilder<AttendanceLog, AttendanceLog, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension AttendanceLogQueryWhere
    on QueryBuilder<AttendanceLog, AttendanceLog, QWhereClause> {
  QueryBuilder<AttendanceLog, AttendanceLog, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<AttendanceLog, AttendanceLog, QAfterWhereClause> idNotEqualTo(
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

  QueryBuilder<AttendanceLog, AttendanceLog, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<AttendanceLog, AttendanceLog, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<AttendanceLog, AttendanceLog, QAfterWhereClause> idBetween(
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
}

extension AttendanceLogQueryFilter
    on QueryBuilder<AttendanceLog, AttendanceLog, QFilterCondition> {
  QueryBuilder<AttendanceLog, AttendanceLog, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<AttendanceLog, AttendanceLog, QAfterFilterCondition>
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

  QueryBuilder<AttendanceLog, AttendanceLog, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<AttendanceLog, AttendanceLog, QAfterFilterCondition> idBetween(
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

  QueryBuilder<AttendanceLog, AttendanceLog, QAfterFilterCondition>
      isMockLocationEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isMockLocation',
        value: value,
      ));
    });
  }

  QueryBuilder<AttendanceLog, AttendanceLog, QAfterFilterCondition>
      isSyncedEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isSynced',
        value: value,
      ));
    });
  }

  QueryBuilder<AttendanceLog, AttendanceLog, QAfterFilterCondition>
      latitudeEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'latitude',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<AttendanceLog, AttendanceLog, QAfterFilterCondition>
      latitudeGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'latitude',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<AttendanceLog, AttendanceLog, QAfterFilterCondition>
      latitudeLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'latitude',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<AttendanceLog, AttendanceLog, QAfterFilterCondition>
      latitudeBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'latitude',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<AttendanceLog, AttendanceLog, QAfterFilterCondition>
      logCategoryEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'logCategory',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AttendanceLog, AttendanceLog, QAfterFilterCondition>
      logCategoryGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'logCategory',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AttendanceLog, AttendanceLog, QAfterFilterCondition>
      logCategoryLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'logCategory',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AttendanceLog, AttendanceLog, QAfterFilterCondition>
      logCategoryBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'logCategory',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AttendanceLog, AttendanceLog, QAfterFilterCondition>
      logCategoryStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'logCategory',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AttendanceLog, AttendanceLog, QAfterFilterCondition>
      logCategoryEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'logCategory',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AttendanceLog, AttendanceLog, QAfterFilterCondition>
      logCategoryContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'logCategory',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AttendanceLog, AttendanceLog, QAfterFilterCondition>
      logCategoryMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'logCategory',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AttendanceLog, AttendanceLog, QAfterFilterCondition>
      logCategoryIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'logCategory',
        value: '',
      ));
    });
  }

  QueryBuilder<AttendanceLog, AttendanceLog, QAfterFilterCondition>
      logCategoryIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'logCategory',
        value: '',
      ));
    });
  }

  QueryBuilder<AttendanceLog, AttendanceLog, QAfterFilterCondition>
      longitudeEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'longitude',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<AttendanceLog, AttendanceLog, QAfterFilterCondition>
      longitudeGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'longitude',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<AttendanceLog, AttendanceLog, QAfterFilterCondition>
      longitudeLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'longitude',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<AttendanceLog, AttendanceLog, QAfterFilterCondition>
      longitudeBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'longitude',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<AttendanceLog, AttendanceLog, QAfterFilterCondition>
      photoBase64IsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'photoBase64',
      ));
    });
  }

  QueryBuilder<AttendanceLog, AttendanceLog, QAfterFilterCondition>
      photoBase64IsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'photoBase64',
      ));
    });
  }

  QueryBuilder<AttendanceLog, AttendanceLog, QAfterFilterCondition>
      photoBase64EqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'photoBase64',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AttendanceLog, AttendanceLog, QAfterFilterCondition>
      photoBase64GreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'photoBase64',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AttendanceLog, AttendanceLog, QAfterFilterCondition>
      photoBase64LessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'photoBase64',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AttendanceLog, AttendanceLog, QAfterFilterCondition>
      photoBase64Between(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'photoBase64',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AttendanceLog, AttendanceLog, QAfterFilterCondition>
      photoBase64StartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'photoBase64',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AttendanceLog, AttendanceLog, QAfterFilterCondition>
      photoBase64EndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'photoBase64',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AttendanceLog, AttendanceLog, QAfterFilterCondition>
      photoBase64Contains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'photoBase64',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AttendanceLog, AttendanceLog, QAfterFilterCondition>
      photoBase64Matches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'photoBase64',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AttendanceLog, AttendanceLog, QAfterFilterCondition>
      photoBase64IsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'photoBase64',
        value: '',
      ));
    });
  }

  QueryBuilder<AttendanceLog, AttendanceLog, QAfterFilterCondition>
      photoBase64IsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'photoBase64',
        value: '',
      ));
    });
  }

  QueryBuilder<AttendanceLog, AttendanceLog, QAfterFilterCondition>
      timestampEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'timestamp',
        value: value,
      ));
    });
  }

  QueryBuilder<AttendanceLog, AttendanceLog, QAfterFilterCondition>
      timestampGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'timestamp',
        value: value,
      ));
    });
  }

  QueryBuilder<AttendanceLog, AttendanceLog, QAfterFilterCondition>
      timestampLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'timestamp',
        value: value,
      ));
    });
  }

  QueryBuilder<AttendanceLog, AttendanceLog, QAfterFilterCondition>
      timestampBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'timestamp',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension AttendanceLogQueryObject
    on QueryBuilder<AttendanceLog, AttendanceLog, QFilterCondition> {}

extension AttendanceLogQueryLinks
    on QueryBuilder<AttendanceLog, AttendanceLog, QFilterCondition> {}

extension AttendanceLogQuerySortBy
    on QueryBuilder<AttendanceLog, AttendanceLog, QSortBy> {
  QueryBuilder<AttendanceLog, AttendanceLog, QAfterSortBy>
      sortByIsMockLocation() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isMockLocation', Sort.asc);
    });
  }

  QueryBuilder<AttendanceLog, AttendanceLog, QAfterSortBy>
      sortByIsMockLocationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isMockLocation', Sort.desc);
    });
  }

  QueryBuilder<AttendanceLog, AttendanceLog, QAfterSortBy> sortByIsSynced() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSynced', Sort.asc);
    });
  }

  QueryBuilder<AttendanceLog, AttendanceLog, QAfterSortBy>
      sortByIsSyncedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSynced', Sort.desc);
    });
  }

  QueryBuilder<AttendanceLog, AttendanceLog, QAfterSortBy> sortByLatitude() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'latitude', Sort.asc);
    });
  }

  QueryBuilder<AttendanceLog, AttendanceLog, QAfterSortBy>
      sortByLatitudeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'latitude', Sort.desc);
    });
  }

  QueryBuilder<AttendanceLog, AttendanceLog, QAfterSortBy> sortByLogCategory() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'logCategory', Sort.asc);
    });
  }

  QueryBuilder<AttendanceLog, AttendanceLog, QAfterSortBy>
      sortByLogCategoryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'logCategory', Sort.desc);
    });
  }

  QueryBuilder<AttendanceLog, AttendanceLog, QAfterSortBy> sortByLongitude() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'longitude', Sort.asc);
    });
  }

  QueryBuilder<AttendanceLog, AttendanceLog, QAfterSortBy>
      sortByLongitudeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'longitude', Sort.desc);
    });
  }

  QueryBuilder<AttendanceLog, AttendanceLog, QAfterSortBy> sortByPhotoBase64() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'photoBase64', Sort.asc);
    });
  }

  QueryBuilder<AttendanceLog, AttendanceLog, QAfterSortBy>
      sortByPhotoBase64Desc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'photoBase64', Sort.desc);
    });
  }

  QueryBuilder<AttendanceLog, AttendanceLog, QAfterSortBy> sortByTimestamp() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timestamp', Sort.asc);
    });
  }

  QueryBuilder<AttendanceLog, AttendanceLog, QAfterSortBy>
      sortByTimestampDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timestamp', Sort.desc);
    });
  }
}

extension AttendanceLogQuerySortThenBy
    on QueryBuilder<AttendanceLog, AttendanceLog, QSortThenBy> {
  QueryBuilder<AttendanceLog, AttendanceLog, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<AttendanceLog, AttendanceLog, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<AttendanceLog, AttendanceLog, QAfterSortBy>
      thenByIsMockLocation() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isMockLocation', Sort.asc);
    });
  }

  QueryBuilder<AttendanceLog, AttendanceLog, QAfterSortBy>
      thenByIsMockLocationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isMockLocation', Sort.desc);
    });
  }

  QueryBuilder<AttendanceLog, AttendanceLog, QAfterSortBy> thenByIsSynced() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSynced', Sort.asc);
    });
  }

  QueryBuilder<AttendanceLog, AttendanceLog, QAfterSortBy>
      thenByIsSyncedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSynced', Sort.desc);
    });
  }

  QueryBuilder<AttendanceLog, AttendanceLog, QAfterSortBy> thenByLatitude() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'latitude', Sort.asc);
    });
  }

  QueryBuilder<AttendanceLog, AttendanceLog, QAfterSortBy>
      thenByLatitudeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'latitude', Sort.desc);
    });
  }

  QueryBuilder<AttendanceLog, AttendanceLog, QAfterSortBy> thenByLogCategory() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'logCategory', Sort.asc);
    });
  }

  QueryBuilder<AttendanceLog, AttendanceLog, QAfterSortBy>
      thenByLogCategoryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'logCategory', Sort.desc);
    });
  }

  QueryBuilder<AttendanceLog, AttendanceLog, QAfterSortBy> thenByLongitude() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'longitude', Sort.asc);
    });
  }

  QueryBuilder<AttendanceLog, AttendanceLog, QAfterSortBy>
      thenByLongitudeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'longitude', Sort.desc);
    });
  }

  QueryBuilder<AttendanceLog, AttendanceLog, QAfterSortBy> thenByPhotoBase64() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'photoBase64', Sort.asc);
    });
  }

  QueryBuilder<AttendanceLog, AttendanceLog, QAfterSortBy>
      thenByPhotoBase64Desc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'photoBase64', Sort.desc);
    });
  }

  QueryBuilder<AttendanceLog, AttendanceLog, QAfterSortBy> thenByTimestamp() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timestamp', Sort.asc);
    });
  }

  QueryBuilder<AttendanceLog, AttendanceLog, QAfterSortBy>
      thenByTimestampDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timestamp', Sort.desc);
    });
  }
}

extension AttendanceLogQueryWhereDistinct
    on QueryBuilder<AttendanceLog, AttendanceLog, QDistinct> {
  QueryBuilder<AttendanceLog, AttendanceLog, QDistinct>
      distinctByIsMockLocation() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isMockLocation');
    });
  }

  QueryBuilder<AttendanceLog, AttendanceLog, QDistinct> distinctByIsSynced() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isSynced');
    });
  }

  QueryBuilder<AttendanceLog, AttendanceLog, QDistinct> distinctByLatitude() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'latitude');
    });
  }

  QueryBuilder<AttendanceLog, AttendanceLog, QDistinct> distinctByLogCategory(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'logCategory', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AttendanceLog, AttendanceLog, QDistinct> distinctByLongitude() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'longitude');
    });
  }

  QueryBuilder<AttendanceLog, AttendanceLog, QDistinct> distinctByPhotoBase64(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'photoBase64', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AttendanceLog, AttendanceLog, QDistinct> distinctByTimestamp() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'timestamp');
    });
  }
}

extension AttendanceLogQueryProperty
    on QueryBuilder<AttendanceLog, AttendanceLog, QQueryProperty> {
  QueryBuilder<AttendanceLog, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<AttendanceLog, bool, QQueryOperations> isMockLocationProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isMockLocation');
    });
  }

  QueryBuilder<AttendanceLog, bool, QQueryOperations> isSyncedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isSynced');
    });
  }

  QueryBuilder<AttendanceLog, double, QQueryOperations> latitudeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'latitude');
    });
  }

  QueryBuilder<AttendanceLog, String, QQueryOperations> logCategoryProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'logCategory');
    });
  }

  QueryBuilder<AttendanceLog, double, QQueryOperations> longitudeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'longitude');
    });
  }

  QueryBuilder<AttendanceLog, String?, QQueryOperations> photoBase64Property() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'photoBase64');
    });
  }

  QueryBuilder<AttendanceLog, DateTime, QQueryOperations> timestampProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'timestamp');
    });
  }
}
