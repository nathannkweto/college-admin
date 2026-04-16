//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of student_api;

class CurriculumProgress {
  /// Returns a new [CurriculumProgress] instance.
  CurriculumProgress({
    this.programName,
    this.totalSemesters,
    this.completionPercentage,
    this.semesters = const [],
  });

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? programName;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? totalSemesters;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  double? completionPercentage;

  List<CurriculumSemester> semesters;

  @override
  bool operator ==(Object other) => identical(this, other) || other is CurriculumProgress &&
    other.programName == programName &&
    other.totalSemesters == totalSemesters &&
    other.completionPercentage == completionPercentage &&
    _deepEquality.equals(other.semesters, semesters);

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (programName == null ? 0 : programName!.hashCode) +
    (totalSemesters == null ? 0 : totalSemesters!.hashCode) +
    (completionPercentage == null ? 0 : completionPercentage!.hashCode) +
    (semesters.hashCode);

  @override
  String toString() => 'CurriculumProgress[programName=$programName, totalSemesters=$totalSemesters, completionPercentage=$completionPercentage, semesters=$semesters]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.programName != null) {
      json[r'program_name'] = this.programName;
    } else {
      json[r'program_name'] = null;
    }
    if (this.totalSemesters != null) {
      json[r'total_semesters'] = this.totalSemesters;
    } else {
      json[r'total_semesters'] = null;
    }
    if (this.completionPercentage != null) {
      json[r'completion_percentage'] = this.completionPercentage;
    } else {
      json[r'completion_percentage'] = null;
    }
      json[r'semesters'] = this.semesters;
    return json;
  }

  /// Returns a new [CurriculumProgress] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static CurriculumProgress? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "CurriculumProgress[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "CurriculumProgress[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return CurriculumProgress(
        programName: mapValueOfType<String>(json, r'program_name'),
        totalSemesters: mapValueOfType<int>(json, r'total_semesters'),
        completionPercentage: mapValueOfType<double>(json, r'completion_percentage'),
        semesters: CurriculumSemester.listFromJson(json[r'semesters']),
      );
    }
    return null;
  }

  static List<CurriculumProgress> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <CurriculumProgress>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = CurriculumProgress.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, CurriculumProgress> mapFromJson(dynamic json) {
    final map = <String, CurriculumProgress>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = CurriculumProgress.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of CurriculumProgress-objects as value to a dart map
  static Map<String, List<CurriculumProgress>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<CurriculumProgress>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = CurriculumProgress.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}

