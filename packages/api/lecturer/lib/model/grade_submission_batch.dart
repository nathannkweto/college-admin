//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of lecturer_api;

class GradeSubmissionBatch {
  /// Returns a new [GradeSubmissionBatch] instance.
  GradeSubmissionBatch({
    required this.programCourseId,
    required this.semester,
    this.submissions = const [],
  });

  /// The internal database ID of the program_course (from CourseCohortDetails)
  int programCourseId;

  /// The semester context (e.g., \"2024-2025 Semester 1\")
  String semester;

  List<GradeSubmission> submissions;

  @override
  bool operator ==(Object other) => identical(this, other) || other is GradeSubmissionBatch &&
    other.programCourseId == programCourseId &&
    other.semester == semester &&
    _deepEquality.equals(other.submissions, submissions);

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (programCourseId.hashCode) +
    (semester.hashCode) +
    (submissions.hashCode);

  @override
  String toString() => 'GradeSubmissionBatch[programCourseId=$programCourseId, semester=$semester, submissions=$submissions]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'program_course_id'] = this.programCourseId;
      json[r'semester'] = this.semester;
      json[r'submissions'] = this.submissions;
    return json;
  }

  /// Returns a new [GradeSubmissionBatch] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static GradeSubmissionBatch? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "GradeSubmissionBatch[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "GradeSubmissionBatch[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return GradeSubmissionBatch(
        programCourseId: mapValueOfType<int>(json, r'program_course_id')!,
        semester: mapValueOfType<String>(json, r'semester')!,
        submissions: GradeSubmission.listFromJson(json[r'submissions']),
      );
    }
    return null;
  }

  static List<GradeSubmissionBatch> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <GradeSubmissionBatch>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = GradeSubmissionBatch.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, GradeSubmissionBatch> mapFromJson(dynamic json) {
    final map = <String, GradeSubmissionBatch>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = GradeSubmissionBatch.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of GradeSubmissionBatch-objects as value to a dart map
  static Map<String, List<GradeSubmissionBatch>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<GradeSubmissionBatch>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = GradeSubmissionBatch.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'program_course_id',
    'semester',
    'submissions',
  };
}

