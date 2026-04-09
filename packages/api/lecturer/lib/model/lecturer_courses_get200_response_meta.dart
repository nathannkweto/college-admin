//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of lecturer_api;

class LecturerCoursesGet200ResponseMeta {
  /// Returns a new [LecturerCoursesGet200ResponseMeta] instance.
  LecturerCoursesGet200ResponseMeta({
    this.semester,
    this.type,
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
  String? type;

  @override
  bool operator ==(Object other) => identical(this, other) || other is LecturerCoursesGet200ResponseMeta &&
    other.semester == semester &&
    other.type == type;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (semester == null ? 0 : semester!.hashCode) +
    (type == null ? 0 : type!.hashCode);

  @override
  String toString() => 'LecturerCoursesGet200ResponseMeta[semester=$semester, type=$type]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.semester != null) {
      json[r'semester'] = this.semester;
    } else {
      json[r'semester'] = null;
    }
    if (this.type != null) {
      json[r'type'] = this.type;
    } else {
      json[r'type'] = null;
    }
    return json;
  }

  /// Returns a new [LecturerCoursesGet200ResponseMeta] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static LecturerCoursesGet200ResponseMeta? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "LecturerCoursesGet200ResponseMeta[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "LecturerCoursesGet200ResponseMeta[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return LecturerCoursesGet200ResponseMeta(
        semester: mapValueOfType<String>(json, r'semester'),
        type: mapValueOfType<String>(json, r'type'),
      );
    }
    return null;
  }

  static List<LecturerCoursesGet200ResponseMeta> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <LecturerCoursesGet200ResponseMeta>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = LecturerCoursesGet200ResponseMeta.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, LecturerCoursesGet200ResponseMeta> mapFromJson(dynamic json) {
    final map = <String, LecturerCoursesGet200ResponseMeta>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = LecturerCoursesGet200ResponseMeta.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of LecturerCoursesGet200ResponseMeta-objects as value to a dart map
  static Map<String, List<LecturerCoursesGet200ResponseMeta>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<LecturerCoursesGet200ResponseMeta>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = LecturerCoursesGet200ResponseMeta.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}

