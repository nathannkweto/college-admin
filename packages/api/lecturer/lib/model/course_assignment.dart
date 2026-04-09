//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of lecturer_api;

class CourseAssignment {
  /// Returns a new [CourseAssignment] instance.
  CourseAssignment({
    this.publicId,
    this.courseName,
    this.courseCode,
    this.programName,
    this.programCode,
    this.programPublicId,
    this.semesterSequence,
  });

  /// The Course Public ID
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
  String? courseName;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? courseCode;

  /// The specific program this course belongs to (e.g. BSc Computer Science)
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
  String? programCode;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? programPublicId;

  /// The curriculum sequence (1 = Sem 1 Year 1, 3 = Sem 1 Year 2, etc.)
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? semesterSequence;

  @override
  bool operator ==(Object other) => identical(this, other) || other is CourseAssignment &&
    other.publicId == publicId &&
    other.courseName == courseName &&
    other.courseCode == courseCode &&
    other.programName == programName &&
    other.programCode == programCode &&
    other.programPublicId == programPublicId &&
    other.semesterSequence == semesterSequence;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (publicId == null ? 0 : publicId!.hashCode) +
    (courseName == null ? 0 : courseName!.hashCode) +
    (courseCode == null ? 0 : courseCode!.hashCode) +
    (programName == null ? 0 : programName!.hashCode) +
    (programCode == null ? 0 : programCode!.hashCode) +
    (programPublicId == null ? 0 : programPublicId!.hashCode) +
    (semesterSequence == null ? 0 : semesterSequence!.hashCode);

  @override
  String toString() => 'CourseAssignment[publicId=$publicId, courseName=$courseName, courseCode=$courseCode, programName=$programName, programCode=$programCode, programPublicId=$programPublicId, semesterSequence=$semesterSequence]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.publicId != null) {
      json[r'public_id'] = this.publicId;
    } else {
      json[r'public_id'] = null;
    }
    if (this.courseName != null) {
      json[r'course_name'] = this.courseName;
    } else {
      json[r'course_name'] = null;
    }
    if (this.courseCode != null) {
      json[r'course_code'] = this.courseCode;
    } else {
      json[r'course_code'] = null;
    }
    if (this.programName != null) {
      json[r'program_name'] = this.programName;
    } else {
      json[r'program_name'] = null;
    }
    if (this.programCode != null) {
      json[r'program_code'] = this.programCode;
    } else {
      json[r'program_code'] = null;
    }
    if (this.programPublicId != null) {
      json[r'program_public_id'] = this.programPublicId;
    } else {
      json[r'program_public_id'] = null;
    }
    if (this.semesterSequence != null) {
      json[r'semester_sequence'] = this.semesterSequence;
    } else {
      json[r'semester_sequence'] = null;
    }
    return json;
  }

  /// Returns a new [CourseAssignment] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static CourseAssignment? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "CourseAssignment[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "CourseAssignment[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return CourseAssignment(
        publicId: mapValueOfType<String>(json, r'public_id'),
        courseName: mapValueOfType<String>(json, r'course_name'),
        courseCode: mapValueOfType<String>(json, r'course_code'),
        programName: mapValueOfType<String>(json, r'program_name'),
        programCode: mapValueOfType<String>(json, r'program_code'),
        programPublicId: mapValueOfType<String>(json, r'program_public_id'),
        semesterSequence: mapValueOfType<int>(json, r'semester_sequence'),
      );
    }
    return null;
  }

  static List<CourseAssignment> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <CourseAssignment>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = CourseAssignment.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, CourseAssignment> mapFromJson(dynamic json) {
    final map = <String, CourseAssignment>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = CourseAssignment.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of CourseAssignment-objects as value to a dart map
  static Map<String, List<CourseAssignment>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<CourseAssignment>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = CourseAssignment.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}

