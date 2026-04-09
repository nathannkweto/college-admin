//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of student_api;

class CurriculumSemester {
  /// Returns a new [CurriculumSemester] instance.
  CurriculumSemester({
    this.title,
    this.isCleared,
    this.isCurrent,
    this.courses = const [],
  });

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? title;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  bool? isCleared;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  bool? isCurrent;

  List<CurriculumSemesterCoursesInner> courses;

  @override
  bool operator ==(Object other) => identical(this, other) || other is CurriculumSemester &&
    other.title == title &&
    other.isCleared == isCleared &&
    other.isCurrent == isCurrent &&
    _deepEquality.equals(other.courses, courses);

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (title == null ? 0 : title!.hashCode) +
    (isCleared == null ? 0 : isCleared!.hashCode) +
    (isCurrent == null ? 0 : isCurrent!.hashCode) +
    (courses.hashCode);

  @override
  String toString() => 'CurriculumSemester[title=$title, isCleared=$isCleared, isCurrent=$isCurrent, courses=$courses]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.title != null) {
      json[r'title'] = this.title;
    } else {
      json[r'title'] = null;
    }
    if (this.isCleared != null) {
      json[r'is_cleared'] = this.isCleared;
    } else {
      json[r'is_cleared'] = null;
    }
    if (this.isCurrent != null) {
      json[r'is_current'] = this.isCurrent;
    } else {
      json[r'is_current'] = null;
    }
      json[r'courses'] = this.courses;
    return json;
  }

  /// Returns a new [CurriculumSemester] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static CurriculumSemester? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "CurriculumSemester[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "CurriculumSemester[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return CurriculumSemester(
        title: mapValueOfType<String>(json, r'title'),
        isCleared: mapValueOfType<bool>(json, r'is_cleared'),
        isCurrent: mapValueOfType<bool>(json, r'is_current'),
        courses: CurriculumSemesterCoursesInner.listFromJson(json[r'courses']),
      );
    }
    return null;
  }

  static List<CurriculumSemester> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <CurriculumSemester>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = CurriculumSemester.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, CurriculumSemester> mapFromJson(dynamic json) {
    final map = <String, CurriculumSemester>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = CurriculumSemester.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of CurriculumSemester-objects as value to a dart map
  static Map<String, List<CurriculumSemester>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<CurriculumSemester>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = CurriculumSemester.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}

