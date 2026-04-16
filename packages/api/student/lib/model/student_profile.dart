//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of student_api;

class StudentProfile {
  /// Returns a new [StudentProfile] instance.
  StudentProfile({
    this.studentId,
    this.firstName,
    this.lastName,
    this.email,
    this.programName,
    this.currentSemester,
    this.avatarUrl,
  });

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? studentId;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? firstName;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? lastName;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? email;

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
  int? currentSemester;

  String? avatarUrl;

  @override
  bool operator ==(Object other) => identical(this, other) || other is StudentProfile &&
    other.studentId == studentId &&
    other.firstName == firstName &&
    other.lastName == lastName &&
    other.email == email &&
    other.programName == programName &&
    other.currentSemester == currentSemester &&
    other.avatarUrl == avatarUrl;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (studentId == null ? 0 : studentId!.hashCode) +
    (firstName == null ? 0 : firstName!.hashCode) +
    (lastName == null ? 0 : lastName!.hashCode) +
    (email == null ? 0 : email!.hashCode) +
    (programName == null ? 0 : programName!.hashCode) +
    (currentSemester == null ? 0 : currentSemester!.hashCode) +
    (avatarUrl == null ? 0 : avatarUrl!.hashCode);

  @override
  String toString() => 'StudentProfile[studentId=$studentId, firstName=$firstName, lastName=$lastName, email=$email, programName=$programName, currentSemester=$currentSemester, avatarUrl=$avatarUrl]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.studentId != null) {
      json[r'student_id'] = this.studentId;
    } else {
      json[r'student_id'] = null;
    }
    if (this.firstName != null) {
      json[r'first_name'] = this.firstName;
    } else {
      json[r'first_name'] = null;
    }
    if (this.lastName != null) {
      json[r'last_name'] = this.lastName;
    } else {
      json[r'last_name'] = null;
    }
    if (this.email != null) {
      json[r'email'] = this.email;
    } else {
      json[r'email'] = null;
    }
    if (this.programName != null) {
      json[r'program_name'] = this.programName;
    } else {
      json[r'program_name'] = null;
    }
    if (this.currentSemester != null) {
      json[r'current_semester'] = this.currentSemester;
    } else {
      json[r'current_semester'] = null;
    }
    if (this.avatarUrl != null) {
      json[r'avatar_url'] = this.avatarUrl;
    } else {
      json[r'avatar_url'] = null;
    }
    return json;
  }

  /// Returns a new [StudentProfile] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static StudentProfile? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "StudentProfile[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "StudentProfile[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return StudentProfile(
        studentId: mapValueOfType<String>(json, r'student_id'),
        firstName: mapValueOfType<String>(json, r'first_name'),
        lastName: mapValueOfType<String>(json, r'last_name'),
        email: mapValueOfType<String>(json, r'email'),
        programName: mapValueOfType<String>(json, r'program_name'),
        currentSemester: mapValueOfType<int>(json, r'current_semester'),
        avatarUrl: mapValueOfType<String>(json, r'avatar_url'),
      );
    }
    return null;
  }

  static List<StudentProfile> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <StudentProfile>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = StudentProfile.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, StudentProfile> mapFromJson(dynamic json) {
    final map = <String, StudentProfile>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = StudentProfile.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of StudentProfile-objects as value to a dart map
  static Map<String, List<StudentProfile>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<StudentProfile>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = StudentProfile.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}

