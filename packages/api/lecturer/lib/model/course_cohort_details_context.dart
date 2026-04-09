//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of lecturer_api;

class CourseCohortDetailsContext {
  /// Returns a new [CourseCohortDetailsContext] instance.
  CourseCohortDetailsContext({
    this.semester,
    this.semesterSequence,
    this.studentCount,
  });

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? semester;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? semesterSequence;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? studentCount;

  @override
  bool operator ==(Object other) => identical(this, other) || other is CourseCohortDetailsContext &&
    other.semester == semester &&
    other.semesterSequence == semesterSequence &&
    other.studentCount == studentCount;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (semester == null ? 0 : semester!.hashCode) +
    (semesterSequence == null ? 0 : semesterSequence!.hashCode) +
    (studentCount == null ? 0 : studentCount!.hashCode);

  @override
  String toString() => 'CourseCohortDetailsContext[semester=$semester, semesterSequence=$semesterSequence, studentCount=$studentCount]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.semester != null) {
      json[r'semester'] = this.semester;
    } else {
      json[r'semester'] = null;
    }
    if (this.semesterSequence != null) {
      json[r'semester_sequence'] = this.semesterSequence;
    } else {
      json[r'semester_sequence'] = null;
    }
    if (this.studentCount != null) {
      json[r'student_count'] = this.studentCount;
    } else {
      json[r'student_count'] = null;
    }
    return json;
  }

  /// Returns a new [CourseCohortDetailsContext] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static CourseCohortDetailsContext? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "CourseCohortDetailsContext[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "CourseCohortDetailsContext[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return CourseCohortDetailsContext(
        semester: mapValueOfType<String>(json, r'semester'),
        semesterSequence: mapValueOfType<int>(json, r'semester_sequence'),
        studentCount: mapValueOfType<int>(json, r'student_count'),
      );
    }
    return null;
  }

  static List<CourseCohortDetailsContext> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <CourseCohortDetailsContext>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = CourseCohortDetailsContext.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, CourseCohortDetailsContext> mapFromJson(dynamic json) {
    final map = <String, CourseCohortDetailsContext>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = CourseCohortDetailsContext.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of CourseCohortDetailsContext-objects as value to a dart map
  static Map<String, List<CourseCohortDetailsContext>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<CourseCohortDetailsContext>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = CourseCohortDetailsContext.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}

