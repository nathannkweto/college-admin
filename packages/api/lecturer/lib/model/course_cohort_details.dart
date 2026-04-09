//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of lecturer_api;

class CourseCohortDetails {
  /// Returns a new [CourseCohortDetails] instance.
  CourseCohortDetails({
    required this.programCourseId,
    this.course,
    this.program,
    this.context,
    this.students = const [],
  });

  /// The internal database ID (not UUID) required for the grading endpoint.
  int programCourseId;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  CourseCohortDetailsCourse? course;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  CourseCohortDetailsProgram? program;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  CourseCohortDetailsContext? context;

  List<StudentGradeRecord> students;

  @override
  bool operator ==(Object other) => identical(this, other) || other is CourseCohortDetails &&
    other.programCourseId == programCourseId &&
    other.course == course &&
    other.program == program &&
    other.context == context &&
    _deepEquality.equals(other.students, students);

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (programCourseId.hashCode) +
    (course == null ? 0 : course!.hashCode) +
    (program == null ? 0 : program!.hashCode) +
    (context == null ? 0 : context!.hashCode) +
    (students.hashCode);

  @override
  String toString() => 'CourseCohortDetails[programCourseId=$programCourseId, course=$course, program=$program, context=$context, students=$students]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'program_course_id'] = this.programCourseId;
    if (this.course != null) {
      json[r'course'] = this.course;
    } else {
      json[r'course'] = null;
    }
    if (this.program != null) {
      json[r'program'] = this.program;
    } else {
      json[r'program'] = null;
    }
    if (this.context != null) {
      json[r'context'] = this.context;
    } else {
      json[r'context'] = null;
    }
      json[r'students'] = this.students;
    return json;
  }

  /// Returns a new [CourseCohortDetails] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static CourseCohortDetails? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "CourseCohortDetails[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "CourseCohortDetails[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return CourseCohortDetails(
        programCourseId: mapValueOfType<int>(json, r'program_course_id')!,
        course: CourseCohortDetailsCourse.fromJson(json[r'course']),
        program: CourseCohortDetailsProgram.fromJson(json[r'program']),
        context: CourseCohortDetailsContext.fromJson(json[r'context']),
        students: StudentGradeRecord.listFromJson(json[r'students']),
      );
    }
    return null;
  }

  static List<CourseCohortDetails> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <CourseCohortDetails>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = CourseCohortDetails.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, CourseCohortDetails> mapFromJson(dynamic json) {
    final map = <String, CourseCohortDetails>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = CourseCohortDetails.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of CourseCohortDetails-objects as value to a dart map
  static Map<String, List<CourseCohortDetails>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<CourseCohortDetails>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = CourseCohortDetails.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'program_course_id',
  };
}

