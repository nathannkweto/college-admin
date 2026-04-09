//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of lecturer_api;

class StudentGradeRecord {
  /// Returns a new [StudentGradeRecord] instance.
  StudentGradeRecord({
    this.publicId,
    this.studentId,
    this.firstName,
    this.lastName,
    this.avatar,
    this.currentGrade,
    this.currentStatus,
  });

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? publicId;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? studentId;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? firstName;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? lastName;

  String? avatar;

  /// The existing grade if already submitted
  double? currentGrade;

  StudentGradeRecordCurrentStatusEnum? currentStatus;

  @override
  bool operator ==(Object other) => identical(this, other) || other is StudentGradeRecord &&
    other.publicId == publicId &&
    other.studentId == studentId &&
    other.firstName == firstName &&
    other.lastName == lastName &&
    other.avatar == avatar &&
    other.currentGrade == currentGrade &&
    other.currentStatus == currentStatus;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (publicId == null ? 0 : publicId!.hashCode) +
    (studentId == null ? 0 : studentId!.hashCode) +
    (firstName == null ? 0 : firstName!.hashCode) +
    (lastName == null ? 0 : lastName!.hashCode) +
    (avatar == null ? 0 : avatar!.hashCode) +
    (currentGrade == null ? 0 : currentGrade!.hashCode) +
    (currentStatus == null ? 0 : currentStatus!.hashCode);

  @override
  String toString() => 'StudentGradeRecord[publicId=$publicId, studentId=$studentId, firstName=$firstName, lastName=$lastName, avatar=$avatar, currentGrade=$currentGrade, currentStatus=$currentStatus]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.publicId != null) {
      json[r'public_id'] = this.publicId;
    } else {
      json[r'public_id'] = null;
    }
    if (this.studentId != null) {
      json[r'student_id'] = this.studentId;
    } else {
      json[r'student_id'] = null;
    }
    if (this.firstName != null) {
      json[r'first_name'] = this.firstName;
    } else {
      json[r'first_name'] = null;
    }
    if (this.lastName != null) {
      json[r'last_name'] = this.lastName;
    } else {
      json[r'last_name'] = null;
    }
    if (this.avatar != null) {
      json[r'avatar'] = this.avatar;
    } else {
      json[r'avatar'] = null;
    }
    if (this.currentGrade != null) {
      json[r'current_grade'] = this.currentGrade;
    } else {
      json[r'current_grade'] = null;
    }
    if (this.currentStatus != null) {
      json[r'current_status'] = this.currentStatus;
    } else {
      json[r'current_status'] = null;
    }
    return json;
  }

  /// Returns a new [StudentGradeRecord] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static StudentGradeRecord? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "StudentGradeRecord[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "StudentGradeRecord[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return StudentGradeRecord(
        publicId: mapValueOfType<String>(json, r'public_id'),
        studentId: mapValueOfType<String>(json, r'student_id'),
        firstName: mapValueOfType<String>(json, r'first_name'),
        lastName: mapValueOfType<String>(json, r'last_name'),
        avatar: mapValueOfType<String>(json, r'avatar'),
        currentGrade: mapValueOfType<double>(json, r'current_grade'),
        currentStatus: StudentGradeRecordCurrentStatusEnum.fromJson(json[r'current_status']),
      );
    }
    return null;
  }

  static List<StudentGradeRecord> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <StudentGradeRecord>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = StudentGradeRecord.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, StudentGradeRecord> mapFromJson(dynamic json) {
    final map = <String, StudentGradeRecord>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = StudentGradeRecord.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of StudentGradeRecord-objects as value to a dart map
  static Map<String, List<StudentGradeRecord>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<StudentGradeRecord>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = StudentGradeRecord.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}


class StudentGradeRecordCurrentStatusEnum {
  /// Instantiate a new enum with the provided [value].
  const StudentGradeRecordCurrentStatusEnum._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const PASS = StudentGradeRecordCurrentStatusEnum._(r'PASS');
  static const FAIL = StudentGradeRecordCurrentStatusEnum._(r'FAIL');
  static const PENDING = StudentGradeRecordCurrentStatusEnum._(r'PENDING');

  /// List of all possible values in this [enum][StudentGradeRecordCurrentStatusEnum].
  static const values = <StudentGradeRecordCurrentStatusEnum>[
    PASS,
    FAIL,
    PENDING,
  ];

  static StudentGradeRecordCurrentStatusEnum? fromJson(dynamic value) => StudentGradeRecordCurrentStatusEnumTypeTransformer().decode(value);

  static List<StudentGradeRecordCurrentStatusEnum> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <StudentGradeRecordCurrentStatusEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = StudentGradeRecordCurrentStatusEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [StudentGradeRecordCurrentStatusEnum] to String,
/// and [decode] dynamic data back to [StudentGradeRecordCurrentStatusEnum].
class StudentGradeRecordCurrentStatusEnumTypeTransformer {
  factory StudentGradeRecordCurrentStatusEnumTypeTransformer() => _instance ??= const StudentGradeRecordCurrentStatusEnumTypeTransformer._();

  const StudentGradeRecordCurrentStatusEnumTypeTransformer._();

  String encode(StudentGradeRecordCurrentStatusEnum data) => data.value;

  /// Decodes a [dynamic value][data] to a StudentGradeRecordCurrentStatusEnum.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  StudentGradeRecordCurrentStatusEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'PASS': return StudentGradeRecordCurrentStatusEnum.PASS;
        case r'FAIL': return StudentGradeRecordCurrentStatusEnum.FAIL;
        case r'PENDING': return StudentGradeRecordCurrentStatusEnum.PENDING;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [StudentGradeRecordCurrentStatusEnumTypeTransformer] instance.
  static StudentGradeRecordCurrentStatusEnumTypeTransformer? _instance;
}


