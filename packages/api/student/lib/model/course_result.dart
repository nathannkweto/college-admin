//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of student_api;

class CourseResult {
  /// Returns a new [CourseResult] instance.
  CourseResult({
    this.courseName,
    this.grade,
    this.score,
    this.isPublished,
  });

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? courseName;

  /// The letter grade (e.g., 'A', 'B', 'F') or 'N/A' if not published/ongoing.
  String? grade;

  /// The raw score (0-100). Null if not published.
  num? score;

  /// Indicates if the result is officially released.
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  bool? isPublished;

  @override
  bool operator ==(Object other) => identical(this, other) || other is CourseResult &&
    other.courseName == courseName &&
    other.grade == grade &&
    other.score == score &&
    other.isPublished == isPublished;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (courseName == null ? 0 : courseName!.hashCode) +
    (grade == null ? 0 : grade!.hashCode) +
    (score == null ? 0 : score!.hashCode) +
    (isPublished == null ? 0 : isPublished!.hashCode);

  @override
  String toString() => 'CourseResult[courseName=$courseName, grade=$grade, score=$score, isPublished=$isPublished]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.courseName != null) {
      json[r'course_name'] = this.courseName;
    } else {
      json[r'course_name'] = null;
    }
    if (this.grade != null) {
      json[r'grade'] = this.grade;
    } else {
      json[r'grade'] = null;
    }
    if (this.score != null) {
      json[r'score'] = this.score;
    } else {
      json[r'score'] = null;
    }
    if (this.isPublished != null) {
      json[r'is_published'] = this.isPublished;
    } else {
      json[r'is_published'] = null;
    }
    return json;
  }

  /// Returns a new [CourseResult] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static CourseResult? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "CourseResult[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "CourseResult[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return CourseResult(
        courseName: mapValueOfType<String>(json, r'course_name'),
        grade: mapValueOfType<String>(json, r'grade'),
        score: json[r'score'] == null
            ? null
            : num.parse('${json[r'score']}'),
        isPublished: mapValueOfType<bool>(json, r'is_published'),
      );
    }
    return null;
  }

  static List<CourseResult> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <CourseResult>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = CourseResult.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, CourseResult> mapFromJson(dynamic json) {
    final map = <String, CourseResult>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = CourseResult.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of CourseResult-objects as value to a dart map
  static Map<String, List<CourseResult>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<CourseResult>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = CourseResult.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}

