//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of admin_api;

class Semester {
  /// Returns a new [Semester] instance.
  Semester({
    this.publicId,
    this.academicYear,
    this.semesterNumber,
    this.isActive,
    this.startDate,
    this.lengthWeeks,
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
  String? academicYear;

  SemesterSemesterNumberEnum? semesterNumber;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  bool? isActive;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  DateTime? startDate;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? lengthWeeks;

  @override
  bool operator ==(Object other) => identical(this, other) || other is Semester &&
    other.publicId == publicId &&
    other.academicYear == academicYear &&
    other.semesterNumber == semesterNumber &&
    other.isActive == isActive &&
    other.startDate == startDate &&
    other.lengthWeeks == lengthWeeks;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (publicId == null ? 0 : publicId!.hashCode) +
    (academicYear == null ? 0 : academicYear!.hashCode) +
    (semesterNumber == null ? 0 : semesterNumber!.hashCode) +
    (isActive == null ? 0 : isActive!.hashCode) +
    (startDate == null ? 0 : startDate!.hashCode) +
    (lengthWeeks == null ? 0 : lengthWeeks!.hashCode);

  @override
  String toString() => 'Semester[publicId=$publicId, academicYear=$academicYear, semesterNumber=$semesterNumber, isActive=$isActive, startDate=$startDate, lengthWeeks=$lengthWeeks]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.publicId != null) {
      json[r'public_id'] = this.publicId;
    } else {
      json[r'public_id'] = null;
    }
    if (this.academicYear != null) {
      json[r'academic_year'] = this.academicYear;
    } else {
      json[r'academic_year'] = null;
    }
    if (this.semesterNumber != null) {
      json[r'semester_number'] = this.semesterNumber;
    } else {
      json[r'semester_number'] = null;
    }
    if (this.isActive != null) {
      json[r'is_active'] = this.isActive;
    } else {
      json[r'is_active'] = null;
    }
    if (this.startDate != null) {
      json[r'start_date'] = _dateFormatter.format(this.startDate!.toUtc());
    } else {
      json[r'start_date'] = null;
    }
    if (this.lengthWeeks != null) {
      json[r'length_weeks'] = this.lengthWeeks;
    } else {
      json[r'length_weeks'] = null;
    }
    return json;
  }

  /// Returns a new [Semester] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static Semester? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "Semester[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "Semester[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return Semester(
        publicId: mapValueOfType<String>(json, r'public_id'),
        academicYear: mapValueOfType<String>(json, r'academic_year'),
        semesterNumber: SemesterSemesterNumberEnum.fromJson(json[r'semester_number']),
        isActive: mapValueOfType<bool>(json, r'is_active'),
        startDate: mapDateTime(json, r'start_date', r''),
        lengthWeeks: mapValueOfType<int>(json, r'length_weeks'),
      );
    }
    return null;
  }

  static List<Semester> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <Semester>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = Semester.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, Semester> mapFromJson(dynamic json) {
    final map = <String, Semester>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = Semester.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of Semester-objects as value to a dart map
  static Map<String, List<Semester>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<Semester>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = Semester.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}


class SemesterSemesterNumberEnum {
  /// Instantiate a new enum with the provided [value].
  const SemesterSemesterNumberEnum._(this.value);

  /// The underlying value of this enum member.
  final int value;

  @override
  String toString() => value.toString();

  int toJson() => value;

  static const number1 = SemesterSemesterNumberEnum._(1);
  static const number2 = SemesterSemesterNumberEnum._(2);

  /// List of all possible values in this [enum][SemesterSemesterNumberEnum].
  static const values = <SemesterSemesterNumberEnum>[
    number1,
    number2,
  ];

  static SemesterSemesterNumberEnum? fromJson(dynamic value) => SemesterSemesterNumberEnumTypeTransformer().decode(value);

  static List<SemesterSemesterNumberEnum> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <SemesterSemesterNumberEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = SemesterSemesterNumberEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [SemesterSemesterNumberEnum] to int,
/// and [decode] dynamic data back to [SemesterSemesterNumberEnum].
class SemesterSemesterNumberEnumTypeTransformer {
  factory SemesterSemesterNumberEnumTypeTransformer() => _instance ??= const SemesterSemesterNumberEnumTypeTransformer._();

  const SemesterSemesterNumberEnumTypeTransformer._();

  int encode(SemesterSemesterNumberEnum data) => data.value;

  /// Decodes a [dynamic value][data] to a SemesterSemesterNumberEnum.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  SemesterSemesterNumberEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case 1: return SemesterSemesterNumberEnum.number1;
        case 2: return SemesterSemesterNumberEnum.number2;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [SemesterSemesterNumberEnumTypeTransformer] instance.
  static SemesterSemesterNumberEnumTypeTransformer? _instance;
}


