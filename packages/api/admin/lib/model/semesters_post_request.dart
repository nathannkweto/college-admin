//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of admin_api;

class SemestersPostRequest {
  /// Returns a new [SemestersPostRequest] instance.
  SemestersPostRequest({
    required this.academicYear,
    required this.semesterNumber,
    required this.startDate,
    required this.lengthWeeks,
    this.isActive = false,
  });

  String academicYear;

  int semesterNumber;

  DateTime startDate;

  int lengthWeeks;

  /// Set to true to immediately start this semester and trigger enrollment.
  bool isActive;

  @override
  bool operator ==(Object other) => identical(this, other) || other is SemestersPostRequest &&
    other.academicYear == academicYear &&
    other.semesterNumber == semesterNumber &&
    other.startDate == startDate &&
    other.lengthWeeks == lengthWeeks &&
    other.isActive == isActive;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (academicYear.hashCode) +
    (semesterNumber.hashCode) +
    (startDate.hashCode) +
    (lengthWeeks.hashCode) +
    (isActive.hashCode);

  @override
  String toString() => 'SemestersPostRequest[academicYear=$academicYear, semesterNumber=$semesterNumber, startDate=$startDate, lengthWeeks=$lengthWeeks, isActive=$isActive]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'academic_year'] = this.academicYear;
      json[r'semester_number'] = this.semesterNumber;
      json[r'start_date'] = _dateFormatter.format(this.startDate.toUtc());
      json[r'length_weeks'] = this.lengthWeeks;
      json[r'is_active'] = this.isActive;
    return json;
  }

  /// Returns a new [SemestersPostRequest] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static SemestersPostRequest? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "SemestersPostRequest[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "SemestersPostRequest[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return SemestersPostRequest(
        academicYear: mapValueOfType<String>(json, r'academic_year')!,
        semesterNumber: mapValueOfType<int>(json, r'semester_number')!,
        startDate: mapDateTime(json, r'start_date', r'')!,
        lengthWeeks: mapValueOfType<int>(json, r'length_weeks')!,
        isActive: mapValueOfType<bool>(json, r'is_active')!,
      );
    }
    return null;
  }

  static List<SemestersPostRequest> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <SemestersPostRequest>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = SemestersPostRequest.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, SemestersPostRequest> mapFromJson(dynamic json) {
    final map = <String, SemestersPostRequest>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = SemestersPostRequest.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of SemestersPostRequest-objects as value to a dart map
  static Map<String, List<SemestersPostRequest>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<SemestersPostRequest>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = SemestersPostRequest.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'academic_year',
    'semester_number',
    'start_date',
    'length_weeks',
    'is_active',
  };
}

