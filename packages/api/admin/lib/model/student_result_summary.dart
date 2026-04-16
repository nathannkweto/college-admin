//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of admin_api;

class StudentResultSummary {
  /// Returns a new [StudentResultSummary] instance.
  StudentResultSummary({
    this.studentPublicId,
    this.studentId,
    this.firstName,
    this.lastName,
    this.coursesFailed,
    this.averageScore,
    this.semesterDecision,
    this.status,
  });

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? studentPublicId;

  /// The readable ID, e.g., STU-001
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

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? coursesFailed;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  double? averageScore;

  StudentResultSummarySemesterDecisionEnum? semesterDecision;

  /// Complete if all marks are in, Pending otherwise
  StudentResultSummaryStatusEnum? status;

  @override
  bool operator ==(Object other) => identical(this, other) || other is StudentResultSummary &&
    other.studentPublicId == studentPublicId &&
    other.studentId == studentId &&
    other.firstName == firstName &&
    other.lastName == lastName &&
    other.coursesFailed == coursesFailed &&
    other.averageScore == averageScore &&
    other.semesterDecision == semesterDecision &&
    other.status == status;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (studentPublicId == null ? 0 : studentPublicId!.hashCode) +
    (studentId == null ? 0 : studentId!.hashCode) +
    (firstName == null ? 0 : firstName!.hashCode) +
    (lastName == null ? 0 : lastName!.hashCode) +
    (coursesFailed == null ? 0 : coursesFailed!.hashCode) +
    (averageScore == null ? 0 : averageScore!.hashCode) +
    (semesterDecision == null ? 0 : semesterDecision!.hashCode) +
    (status == null ? 0 : status!.hashCode);

  @override
  String toString() => 'StudentResultSummary[studentPublicId=$studentPublicId, studentId=$studentId, firstName=$firstName, lastName=$lastName, coursesFailed=$coursesFailed, averageScore=$averageScore, semesterDecision=$semesterDecision, status=$status]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.studentPublicId != null) {
      json[r'student_public_id'] = this.studentPublicId;
    } else {
      json[r'student_public_id'] = null;
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
    if (this.coursesFailed != null) {
      json[r'courses_failed'] = this.coursesFailed;
    } else {
      json[r'courses_failed'] = null;
    }
    if (this.averageScore != null) {
      json[r'average_score'] = this.averageScore;
    } else {
      json[r'average_score'] = null;
    }
    if (this.semesterDecision != null) {
      json[r'semester_decision'] = this.semesterDecision;
    } else {
      json[r'semester_decision'] = null;
    }
    if (this.status != null) {
      json[r'status'] = this.status;
    } else {
      json[r'status'] = null;
    }
    return json;
  }

  /// Returns a new [StudentResultSummary] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static StudentResultSummary? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "StudentResultSummary[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "StudentResultSummary[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return StudentResultSummary(
        studentPublicId: mapValueOfType<String>(json, r'student_public_id'),
        studentId: mapValueOfType<String>(json, r'student_id'),
        firstName: mapValueOfType<String>(json, r'first_name'),
        lastName: mapValueOfType<String>(json, r'last_name'),
        coursesFailed: mapValueOfType<int>(json, r'courses_failed'),
        averageScore: mapValueOfType<double>(json, r'average_score'),
        semesterDecision: StudentResultSummarySemesterDecisionEnum.fromJson(json[r'semester_decision']),
        status: StudentResultSummaryStatusEnum.fromJson(json[r'status']),
      );
    }
    return null;
  }

  static List<StudentResultSummary> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <StudentResultSummary>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = StudentResultSummary.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, StudentResultSummary> mapFromJson(dynamic json) {
    final map = <String, StudentResultSummary>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = StudentResultSummary.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of StudentResultSummary-objects as value to a dart map
  static Map<String, List<StudentResultSummary>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<StudentResultSummary>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = StudentResultSummary.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}


class StudentResultSummarySemesterDecisionEnum {
  /// Instantiate a new enum with the provided [value].
  const StudentResultSummarySemesterDecisionEnum._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const PROMOTED = StudentResultSummarySemesterDecisionEnum._(r'PROMOTED');
  static const REPEAT = StudentResultSummarySemesterDecisionEnum._(r'REPEAT');
  static const DISMISSED = StudentResultSummarySemesterDecisionEnum._(r'DISMISSED');
  static const NO_RESULTS = StudentResultSummarySemesterDecisionEnum._(r'NO_RESULTS');

  /// List of all possible values in this [enum][StudentResultSummarySemesterDecisionEnum].
  static const values = <StudentResultSummarySemesterDecisionEnum>[
    PROMOTED,
    REPEAT,
    DISMISSED,
    NO_RESULTS,
  ];

  static StudentResultSummarySemesterDecisionEnum? fromJson(dynamic value) => StudentResultSummarySemesterDecisionEnumTypeTransformer().decode(value);

  static List<StudentResultSummarySemesterDecisionEnum> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <StudentResultSummarySemesterDecisionEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = StudentResultSummarySemesterDecisionEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [StudentResultSummarySemesterDecisionEnum] to String,
/// and [decode] dynamic data back to [StudentResultSummarySemesterDecisionEnum].
class StudentResultSummarySemesterDecisionEnumTypeTransformer {
  factory StudentResultSummarySemesterDecisionEnumTypeTransformer() => _instance ??= const StudentResultSummarySemesterDecisionEnumTypeTransformer._();

  const StudentResultSummarySemesterDecisionEnumTypeTransformer._();

  String encode(StudentResultSummarySemesterDecisionEnum data) => data.value;

  /// Decodes a [dynamic value][data] to a StudentResultSummarySemesterDecisionEnum.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  StudentResultSummarySemesterDecisionEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'PROMOTED': return StudentResultSummarySemesterDecisionEnum.PROMOTED;
        case r'REPEAT': return StudentResultSummarySemesterDecisionEnum.REPEAT;
        case r'DISMISSED': return StudentResultSummarySemesterDecisionEnum.DISMISSED;
        case r'NO_RESULTS': return StudentResultSummarySemesterDecisionEnum.NO_RESULTS;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [StudentResultSummarySemesterDecisionEnumTypeTransformer] instance.
  static StudentResultSummarySemesterDecisionEnumTypeTransformer? _instance;
}


/// Complete if all marks are in, Pending otherwise
class StudentResultSummaryStatusEnum {
  /// Instantiate a new enum with the provided [value].
  const StudentResultSummaryStatusEnum._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const complete = StudentResultSummaryStatusEnum._(r'Complete');
  static const pending = StudentResultSummaryStatusEnum._(r'Pending');

  /// List of all possible values in this [enum][StudentResultSummaryStatusEnum].
  static const values = <StudentResultSummaryStatusEnum>[
    complete,
    pending,
  ];

  static StudentResultSummaryStatusEnum? fromJson(dynamic value) => StudentResultSummaryStatusEnumTypeTransformer().decode(value);

  static List<StudentResultSummaryStatusEnum> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <StudentResultSummaryStatusEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = StudentResultSummaryStatusEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [StudentResultSummaryStatusEnum] to String,
/// and [decode] dynamic data back to [StudentResultSummaryStatusEnum].
class StudentResultSummaryStatusEnumTypeTransformer {
  factory StudentResultSummaryStatusEnumTypeTransformer() => _instance ??= const StudentResultSummaryStatusEnumTypeTransformer._();

  const StudentResultSummaryStatusEnumTypeTransformer._();

  String encode(StudentResultSummaryStatusEnum data) => data.value;

  /// Decodes a [dynamic value][data] to a StudentResultSummaryStatusEnum.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  StudentResultSummaryStatusEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'Complete': return StudentResultSummaryStatusEnum.complete;
        case r'Pending': return StudentResultSummaryStatusEnum.pending;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [StudentResultSummaryStatusEnumTypeTransformer] instance.
  static StudentResultSummaryStatusEnumTypeTransformer? _instance;
}


