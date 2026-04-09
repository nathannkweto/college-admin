//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of lecturer_api;

class LecturerProfile {
  /// Returns a new [LecturerProfile] instance.
  LecturerProfile({
    this.firstName,
    this.lastName,
    this.title,
    this.department,
    this.lecturerId,
    this.avatarUrl,
  });

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
  String? title;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? department;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? lecturerId;

  String? avatarUrl;

  @override
  bool operator ==(Object other) => identical(this, other) || other is LecturerProfile &&
    other.firstName == firstName &&
    other.lastName == lastName &&
    other.title == title &&
    other.department == department &&
    other.lecturerId == lecturerId &&
    other.avatarUrl == avatarUrl;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (firstName == null ? 0 : firstName!.hashCode) +
    (lastName == null ? 0 : lastName!.hashCode) +
    (title == null ? 0 : title!.hashCode) +
    (department == null ? 0 : department!.hashCode) +
    (lecturerId == null ? 0 : lecturerId!.hashCode) +
    (avatarUrl == null ? 0 : avatarUrl!.hashCode);

  @override
  String toString() => 'LecturerProfile[firstName=$firstName, lastName=$lastName, title=$title, department=$department, lecturerId=$lecturerId, avatarUrl=$avatarUrl]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
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
    if (this.title != null) {
      json[r'title'] = this.title;
    } else {
      json[r'title'] = null;
    }
    if (this.department != null) {
      json[r'department'] = this.department;
    } else {
      json[r'department'] = null;
    }
    if (this.lecturerId != null) {
      json[r'lecturer_id'] = this.lecturerId;
    } else {
      json[r'lecturer_id'] = null;
    }
    if (this.avatarUrl != null) {
      json[r'avatar_url'] = this.avatarUrl;
    } else {
      json[r'avatar_url'] = null;
    }
    return json;
  }

  /// Returns a new [LecturerProfile] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static LecturerProfile? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "LecturerProfile[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "LecturerProfile[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return LecturerProfile(
        firstName: mapValueOfType<String>(json, r'first_name'),
        lastName: mapValueOfType<String>(json, r'last_name'),
        title: mapValueOfType<String>(json, r'title'),
        department: mapValueOfType<String>(json, r'department'),
        lecturerId: mapValueOfType<String>(json, r'lecturer_id'),
        avatarUrl: mapValueOfType<String>(json, r'avatar_url'),
      );
    }
    return null;
  }

  static List<LecturerProfile> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <LecturerProfile>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = LecturerProfile.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, LecturerProfile> mapFromJson(dynamic json) {
    final map = <String, LecturerProfile>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = LecturerProfile.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of LecturerProfile-objects as value to a dart map
  static Map<String, List<LecturerProfile>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<LecturerProfile>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = LecturerProfile.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}

