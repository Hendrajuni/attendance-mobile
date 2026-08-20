// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daily_context_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetDailyContextCollection on Isar {
  IsarCollection<DailyContext> get dailyContexts => this.collection();
}

const DailyContextSchema = CollectionSchema(
  name: r'DailyContext',
  id: 7269795565333381597,
  properties: {
    r'allowedLat': PropertySchema(
      id: 0,
      name: r'allowedLat',
      type: IsarType.double,
    ),
    r'allowedLng': PropertySchema(
      id: 1,
      name: r'allowedLng',
      type: IsarType.double,
    ),
    r'date': PropertySchema(
      id: 2,
      name: r'date',
      type: IsarType.dateTime,
    ),
    r'employeeName': PropertySchema(
      id: 3,
      name: r'employeeName',
      type: IsarType.string,
    ),
    r'radius': PropertySchema(
      id: 4,
      name: r'radius',
      type: IsarType.double,
    ),
    r'shiftIn': PropertySchema(
      id: 5,
      name: r'shiftIn',
      type: IsarType.string,
    ),
    r'shiftName': PropertySchema(
      id: 6,
      name: r'shiftName',
      type: IsarType.string,
    ),
    r'shiftOut': PropertySchema(
      id: 7,
      name: r'shiftOut',
      type: IsarType.string,
    )
  },
  estimateSize: _dailyContextEstimateSize,
  serialize: _dailyContextSerialize,
  deserialize: _dailyContextDeserialize,
  deserializeProp: _dailyContextDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _dailyContextGetId,
  getLinks: _dailyContextGetLinks,
  attach: _dailyContextAttach,
  version: '3.1.0+1',
);

int _dailyContextEstimateSize(
  DailyContext object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.employeeName.length * 3;
  bytesCount += 3 + object.shiftIn.length * 3;
  bytesCount += 3 + object.shiftName.length * 3;
  bytesCount += 3 + object.shiftOut.length * 3;
  return bytesCount;
}

void _dailyContextSerialize(
  DailyContext object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDouble(offsets[0], object.allowedLat);
  writer.writeDouble(offsets[1], object.allowedLng);
  writer.writeDateTime(offsets[2], object.date);
  writer.writeString(offsets[3], object.employeeName);
  writer.writeDouble(offsets[4], object.radius);
  writer.writeString(offsets[5], object.shiftIn);
  writer.writeString(offsets[6], object.shiftName);
  writer.writeString(offsets[7], object.shiftOut);
}

DailyContext _dailyContextDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = DailyContext();
  object.allowedLat = reader.readDouble(offsets[0]);
  object.allowedLng = reader.readDouble(offsets[1]);
  object.date = reader.readDateTime(offsets[2]);
  object.employeeName = reader.readString(offsets[3]);
  object.id = id;
  object.radius = reader.readDouble(offsets[4]);
  object.shiftIn = reader.readString(offsets[5]);
  object.shiftName = reader.readString(offsets[6]);
  object.shiftOut = reader.readString(offsets[7]);
  return object;
}

P _dailyContextDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDouble(offset)) as P;
    case 1:
      return (reader.readDouble(offset)) as P;
    case 2:
      return (reader.readDateTime(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readDouble(offset)) as P;
    case 5:
      return (reader.readString(offset)) as P;
    case 6:
      return (reader.readString(offset)) as P;
    case 7:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _dailyContextGetId(DailyContext object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _dailyContextGetLinks(DailyContext object) {
  return [];
}

void _dailyContextAttach(
    IsarCollection<dynamic> col, Id id, DailyContext object) {
  object.id = id;
}

extension DailyContextQueryWhereSort
    on QueryBuilder<DailyContext, DailyContext, QWhere> {
  QueryBuilder<DailyContext, DailyContext, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension DailyContextQueryWhere
    on QueryBuilder<DailyContext, DailyContext, QWhereClause> {
  QueryBuilder<DailyContext, DailyContext, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<DailyContext, DailyContext, QAfterWhereClause> idNotEqualTo(
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

  QueryBuilder<DailyContext, DailyContext, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<DailyContext, DailyContext, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<DailyContext, DailyContext, QAfterWhereClause> idBetween(
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

extension DailyContextQueryFilter
    on QueryBuilder<DailyContext, DailyContext, QFilterCondition> {
  QueryBuilder<DailyContext, DailyContext, QAfterFilterCondition>
      allowedLatEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'allowedLat',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<DailyContext, DailyContext, QAfterFilterCondition>
      allowedLatGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'allowedLat',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<DailyContext, DailyContext, QAfterFilterCondition>
      allowedLatLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'allowedLat',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<DailyContext, DailyContext, QAfterFilterCondition>
      allowedLatBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'allowedLat',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<DailyContext, DailyContext, QAfterFilterCondition>
      allowedLngEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'allowedLng',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<DailyContext, DailyContext, QAfterFilterCondition>
      allowedLngGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'allowedLng',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<DailyContext, DailyContext, QAfterFilterCondition>
      allowedLngLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'allowedLng',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<DailyContext, DailyContext, QAfterFilterCondition>
      allowedLngBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'allowedLng',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<DailyContext, DailyContext, QAfterFilterCondition> dateEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'date',
        value: value,
      ));
    });
  }

  QueryBuilder<DailyContext, DailyContext, QAfterFilterCondition>
      dateGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'date',
        value: value,
      ));
    });
  }

  QueryBuilder<DailyContext, DailyContext, QAfterFilterCondition> dateLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'date',
        value: value,
      ));
    });
  }

  QueryBuilder<DailyContext, DailyContext, QAfterFilterCondition> dateBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'date',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<DailyContext, DailyContext, QAfterFilterCondition>
      employeeNameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'employeeName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DailyContext, DailyContext, QAfterFilterCondition>
      employeeNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'employeeName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DailyContext, DailyContext, QAfterFilterCondition>
      employeeNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'employeeName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DailyContext, DailyContext, QAfterFilterCondition>
      employeeNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'employeeName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DailyContext, DailyContext, QAfterFilterCondition>
      employeeNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'employeeName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DailyContext, DailyContext, QAfterFilterCondition>
      employeeNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'employeeName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DailyContext, DailyContext, QAfterFilterCondition>
      employeeNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'employeeName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DailyContext, DailyContext, QAfterFilterCondition>
      employeeNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'employeeName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DailyContext, DailyContext, QAfterFilterCondition>
      employeeNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'employeeName',
        value: '',
      ));
    });
  }

  QueryBuilder<DailyContext, DailyContext, QAfterFilterCondition>
      employeeNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'employeeName',
        value: '',
      ));
    });
  }

  QueryBuilder<DailyContext, DailyContext, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<DailyContext, DailyContext, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<DailyContext, DailyContext, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<DailyContext, DailyContext, QAfterFilterCondition> idBetween(
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

  QueryBuilder<DailyContext, DailyContext, QAfterFilterCondition> radiusEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'radius',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<DailyContext, DailyContext, QAfterFilterCondition>
      radiusGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'radius',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<DailyContext, DailyContext, QAfterFilterCondition>
      radiusLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'radius',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<DailyContext, DailyContext, QAfterFilterCondition> radiusBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'radius',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<DailyContext, DailyContext, QAfterFilterCondition>
      shiftInEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'shiftIn',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DailyContext, DailyContext, QAfterFilterCondition>
      shiftInGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'shiftIn',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DailyContext, DailyContext, QAfterFilterCondition>
      shiftInLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'shiftIn',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DailyContext, DailyContext, QAfterFilterCondition>
      shiftInBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'shiftIn',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DailyContext, DailyContext, QAfterFilterCondition>
      shiftInStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'shiftIn',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DailyContext, DailyContext, QAfterFilterCondition>
      shiftInEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'shiftIn',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DailyContext, DailyContext, QAfterFilterCondition>
      shiftInContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'shiftIn',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DailyContext, DailyContext, QAfterFilterCondition>
      shiftInMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'shiftIn',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DailyContext, DailyContext, QAfterFilterCondition>
      shiftInIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'shiftIn',
        value: '',
      ));
    });
  }

  QueryBuilder<DailyContext, DailyContext, QAfterFilterCondition>
      shiftInIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'shiftIn',
        value: '',
      ));
    });
  }

  QueryBuilder<DailyContext, DailyContext, QAfterFilterCondition>
      shiftNameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'shiftName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DailyContext, DailyContext, QAfterFilterCondition>
      shiftNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'shiftName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DailyContext, DailyContext, QAfterFilterCondition>
      shiftNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'shiftName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DailyContext, DailyContext, QAfterFilterCondition>
      shiftNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'shiftName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DailyContext, DailyContext, QAfterFilterCondition>
      shiftNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'shiftName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DailyContext, DailyContext, QAfterFilterCondition>
      shiftNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'shiftName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DailyContext, DailyContext, QAfterFilterCondition>
      shiftNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'shiftName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DailyContext, DailyContext, QAfterFilterCondition>
      shiftNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'shiftName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DailyContext, DailyContext, QAfterFilterCondition>
      shiftNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'shiftName',
        value: '',
      ));
    });
  }

  QueryBuilder<DailyContext, DailyContext, QAfterFilterCondition>
      shiftNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'shiftName',
        value: '',
      ));
    });
  }

  QueryBuilder<DailyContext, DailyContext, QAfterFilterCondition>
      shiftOutEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'shiftOut',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DailyContext, DailyContext, QAfterFilterCondition>
      shiftOutGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'shiftOut',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DailyContext, DailyContext, QAfterFilterCondition>
      shiftOutLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'shiftOut',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DailyContext, DailyContext, QAfterFilterCondition>
      shiftOutBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'shiftOut',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DailyContext, DailyContext, QAfterFilterCondition>
      shiftOutStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'shiftOut',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DailyContext, DailyContext, QAfterFilterCondition>
      shiftOutEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'shiftOut',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DailyContext, DailyContext, QAfterFilterCondition>
      shiftOutContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'shiftOut',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DailyContext, DailyContext, QAfterFilterCondition>
      shiftOutMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'shiftOut',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DailyContext, DailyContext, QAfterFilterCondition>
      shiftOutIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'shiftOut',
        value: '',
      ));
    });
  }

  QueryBuilder<DailyContext, DailyContext, QAfterFilterCondition>
      shiftOutIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'shiftOut',
        value: '',
      ));
    });
  }
}

extension DailyContextQueryObject
    on QueryBuilder<DailyContext, DailyContext, QFilterCondition> {}

extension DailyContextQueryLinks
    on QueryBuilder<DailyContext, DailyContext, QFilterCondition> {}

extension DailyContextQuerySortBy
    on QueryBuilder<DailyContext, DailyContext, QSortBy> {
  QueryBuilder<DailyContext, DailyContext, QAfterSortBy> sortByAllowedLat() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'allowedLat', Sort.asc);
    });
  }

  QueryBuilder<DailyContext, DailyContext, QAfterSortBy>
      sortByAllowedLatDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'allowedLat', Sort.desc);
    });
  }

  QueryBuilder<DailyContext, DailyContext, QAfterSortBy> sortByAllowedLng() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'allowedLng', Sort.asc);
    });
  }

  QueryBuilder<DailyContext, DailyContext, QAfterSortBy>
      sortByAllowedLngDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'allowedLng', Sort.desc);
    });
  }

  QueryBuilder<DailyContext, DailyContext, QAfterSortBy> sortByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.asc);
    });
  }

  QueryBuilder<DailyContext, DailyContext, QAfterSortBy> sortByDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.desc);
    });
  }

  QueryBuilder<DailyContext, DailyContext, QAfterSortBy> sortByEmployeeName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'employeeName', Sort.asc);
    });
  }

  QueryBuilder<DailyContext, DailyContext, QAfterSortBy>
      sortByEmployeeNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'employeeName', Sort.desc);
    });
  }

  QueryBuilder<DailyContext, DailyContext, QAfterSortBy> sortByRadius() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'radius', Sort.asc);
    });
  }

  QueryBuilder<DailyContext, DailyContext, QAfterSortBy> sortByRadiusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'radius', Sort.desc);
    });
  }

  QueryBuilder<DailyContext, DailyContext, QAfterSortBy> sortByShiftIn() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'shiftIn', Sort.asc);
    });
  }

  QueryBuilder<DailyContext, DailyContext, QAfterSortBy> sortByShiftInDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'shiftIn', Sort.desc);
    });
  }

  QueryBuilder<DailyContext, DailyContext, QAfterSortBy> sortByShiftName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'shiftName', Sort.asc);
    });
  }

  QueryBuilder<DailyContext, DailyContext, QAfterSortBy> sortByShiftNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'shiftName', Sort.desc);
    });
  }

  QueryBuilder<DailyContext, DailyContext, QAfterSortBy> sortByShiftOut() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'shiftOut', Sort.asc);
    });
  }

  QueryBuilder<DailyContext, DailyContext, QAfterSortBy> sortByShiftOutDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'shiftOut', Sort.desc);
    });
  }
}

extension DailyContextQuerySortThenBy
    on QueryBuilder<DailyContext, DailyContext, QSortThenBy> {
  QueryBuilder<DailyContext, DailyContext, QAfterSortBy> thenByAllowedLat() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'allowedLat', Sort.asc);
    });
  }

  QueryBuilder<DailyContext, DailyContext, QAfterSortBy>
      thenByAllowedLatDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'allowedLat', Sort.desc);
    });
  }

  QueryBuilder<DailyContext, DailyContext, QAfterSortBy> thenByAllowedLng() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'allowedLng', Sort.asc);
    });
  }

  QueryBuilder<DailyContext, DailyContext, QAfterSortBy>
      thenByAllowedLngDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'allowedLng', Sort.desc);
    });
  }

  QueryBuilder<DailyContext, DailyContext, QAfterSortBy> thenByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.asc);
    });
  }

  QueryBuilder<DailyContext, DailyContext, QAfterSortBy> thenByDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.desc);
    });
  }

  QueryBuilder<DailyContext, DailyContext, QAfterSortBy> thenByEmployeeName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'employeeName', Sort.asc);
    });
  }

  QueryBuilder<DailyContext, DailyContext, QAfterSortBy>
      thenByEmployeeNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'employeeName', Sort.desc);
    });
  }

  QueryBuilder<DailyContext, DailyContext, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<DailyContext, DailyContext, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<DailyContext, DailyContext, QAfterSortBy> thenByRadius() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'radius', Sort.asc);
    });
  }

  QueryBuilder<DailyContext, DailyContext, QAfterSortBy> thenByRadiusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'radius', Sort.desc);
    });
  }

  QueryBuilder<DailyContext, DailyContext, QAfterSortBy> thenByShiftIn() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'shiftIn', Sort.asc);
    });
  }

  QueryBuilder<DailyContext, DailyContext, QAfterSortBy> thenByShiftInDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'shiftIn', Sort.desc);
    });
  }

  QueryBuilder<DailyContext, DailyContext, QAfterSortBy> thenByShiftName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'shiftName', Sort.asc);
    });
  }

  QueryBuilder<DailyContext, DailyContext, QAfterSortBy> thenByShiftNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'shiftName', Sort.desc);
    });
  }

  QueryBuilder<DailyContext, DailyContext, QAfterSortBy> thenByShiftOut() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'shiftOut', Sort.asc);
    });
  }

  QueryBuilder<DailyContext, DailyContext, QAfterSortBy> thenByShiftOutDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'shiftOut', Sort.desc);
    });
  }
}

extension DailyContextQueryWhereDistinct
    on QueryBuilder<DailyContext, DailyContext, QDistinct> {
  QueryBuilder<DailyContext, DailyContext, QDistinct> distinctByAllowedLat() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'allowedLat');
    });
  }

  QueryBuilder<DailyContext, DailyContext, QDistinct> distinctByAllowedLng() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'allowedLng');
    });
  }

  QueryBuilder<DailyContext, DailyContext, QDistinct> distinctByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'date');
    });
  }

  QueryBuilder<DailyContext, DailyContext, QDistinct> distinctByEmployeeName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'employeeName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DailyContext, DailyContext, QDistinct> distinctByRadius() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'radius');
    });
  }

  QueryBuilder<DailyContext, DailyContext, QDistinct> distinctByShiftIn(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'shiftIn', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DailyContext, DailyContext, QDistinct> distinctByShiftName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'shiftName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DailyContext, DailyContext, QDistinct> distinctByShiftOut(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'shiftOut', caseSensitive: caseSensitive);
    });
  }
}

extension DailyContextQueryProperty
    on QueryBuilder<DailyContext, DailyContext, QQueryProperty> {
  QueryBuilder<DailyContext, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<DailyContext, double, QQueryOperations> allowedLatProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'allowedLat');
    });
  }

  QueryBuilder<DailyContext, double, QQueryOperations> allowedLngProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'allowedLng');
    });
  }

  QueryBuilder<DailyContext, DateTime, QQueryOperations> dateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'date');
    });
  }

  QueryBuilder<DailyContext, String, QQueryOperations> employeeNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'employeeName');
    });
  }

  QueryBuilder<DailyContext, double, QQueryOperations> radiusProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'radius');
    });
  }

  QueryBuilder<DailyContext, String, QQueryOperations> shiftInProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'shiftIn');
    });
  }

  QueryBuilder<DailyContext, String, QQueryOperations> shiftNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'shiftName');
    });
  }

  QueryBuilder<DailyContext, String, QQueryOperations> shiftOutProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'shiftOut');
    });
  }
}
