//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of lecturer_api;

class CourseCohortDetailsCourse {
  /// Returns a new [CourseCohortDetailsCourse] instance.
  CourseCohortDetailsCourse({
    this.name,
    this.code,
    this.description,
  });

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? name;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? code;

  String? description;

  @override
  bool operator ==(Object other) => identical(this, other) || other is CourseCohortDetailsCourse &&
    other.name == name &&
    other.code == code &&
    other.description == description;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (name == null ? 0 : name!.hashCode) +
    (code == null ? 0 : code!.hashCode) +
    (description == null ? 0 : description!.hashCode);

  @override
  String toString() => 'CourseCohortDetailsCourse[name=$name, code=$code, description=$description]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.name != null) {
      json[r'name'] = this.name;
    } else {
      json[r'name'] = null;
    }
    if (this.code != null) {
      json[r'code'] = this.code;
    } else {
      json[r'code'] = null;
    }
    if (this.description != null) {
      json[r'description'] = this.description;
    } else {
      json[r'description'] = null;
    }
    return json;
  }

  /// Returns a new [CourseCohortDetailsCourse] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static CourseCohortDetailsCourse? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "CourseCohortDetailsCourse[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "CourseCohortDetailsCourse[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return CourseCohortDetailsCourse(
        name: mapValueOfType<String>(json, r'name'),
        code: mapValueOfType<String>(json, r'code'),
        description: mapValueOfType<String>(json, r'description'),
      );
    }
    return null;
  }

  static List<CourseCohortDetailsCourse> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <CourseCohortDetailsCourse>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = CourseCohortDetailsCourse.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, CourseCohortDetailsCourse> mapFromJson(dynamic json) {
    final map = <String, CourseCohortDetailsCourse>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = CourseCohortDetailsCourse.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of CourseCohortDetailsCourse-objects as value to a dart map
  static Map<String, List<CourseCohortDetailsCourse>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<CourseCohortDetailsCourse>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = CourseCohortDetailsCourse.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}

