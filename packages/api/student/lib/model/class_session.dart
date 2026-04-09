//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of student_api;

class ClassSession {
  /// Returns a new [ClassSession] instance.
  ClassSession({
    this.publicId,
    this.courseCode,
    this.courseName,
    this.startTime,
    this.endTime,
    this.location,
    this.lecturerName,
    this.colorHex,
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
  String? courseCode;

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
  String? startTime;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? endTime;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? location;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? lecturerName;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? colorHex;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ClassSession &&
    other.publicId == publicId &&
    other.courseCode == courseCode &&
    other.courseName == courseName &&
    other.startTime == startTime &&
    other.endTime == endTime &&
    other.location == location &&
    other.lecturerName == lecturerName &&
    other.colorHex == colorHex;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (publicId == null ? 0 : publicId!.hashCode) +
    (courseCode == null ? 0 : courseCode!.hashCode) +
    (courseName == null ? 0 : courseName!.hashCode) +
    (startTime == null ? 0 : startTime!.hashCode) +
    (endTime == null ? 0 : endTime!.hashCode) +
    (location == null ? 0 : location!.hashCode) +
    (lecturerName == null ? 0 : lecturerName!.hashCode) +
    (colorHex == null ? 0 : colorHex!.hashCode);

  @override
  String toString() => 'ClassSession[publicId=$publicId, courseCode=$courseCode, courseName=$courseName, startTime=$startTime, endTime=$endTime, location=$location, lecturerName=$lecturerName, colorHex=$colorHex]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.publicId != null) {
      json[r'public_id'] = this.publicId;
    } else {
      json[r'public_id'] = null;
    }
    if (this.courseCode != null) {
      json[r'course_code'] = this.courseCode;
    } else {
      json[r'course_code'] = null;
    }
    if (this.courseName != null) {
      json[r'course_name'] = this.courseName;
    } else {
      json[r'course_name'] = null;
    }
    if (this.startTime != null) {
      json[r'start_time'] = this.startTime;
    } else {
      json[r'start_time'] = null;
    }
    if (this.endTime != null) {
      json[r'end_time'] = this.endTime;
    } else {
      json[r'end_time'] = null;
    }
    if (this.location != null) {
      json[r'location'] = this.location;
    } else {
      json[r'location'] = null;
    }
    if (this.lecturerName != null) {
      json[r'lecturer_name'] = this.lecturerName;
    } else {
      json[r'lecturer_name'] = null;
    }
    if (this.colorHex != null) {
      json[r'color_hex'] = this.colorHex;
    } else {
      json[r'color_hex'] = null;
    }
    return json;
  }

  /// Returns a new [ClassSession] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ClassSession? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "ClassSession[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "ClassSession[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return ClassSession(
        publicId: mapValueOfType<String>(json, r'public_id'),
        courseCode: mapValueOfType<String>(json, r'course_code'),
        courseName: mapValueOfType<String>(json, r'course_name'),
        startTime: mapValueOfType<String>(json, r'start_time'),
        endTime: mapValueOfType<String>(json, r'end_time'),
        location: mapValueOfType<String>(json, r'location'),
        lecturerName: mapValueOfType<String>(json, r'lecturer_name'),
        colorHex: mapValueOfType<String>(json, r'color_hex'),
      );
    }
    return null;
  }

  static List<ClassSession> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ClassSession>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ClassSession.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ClassSession> mapFromJson(dynamic json) {
    final map = <String, ClassSession>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ClassSession.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ClassSession-objects as value to a dart map
  static Map<String, List<ClassSession>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ClassSession>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = ClassSession.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}

