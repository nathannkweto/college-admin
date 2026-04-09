//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of admin_api;

class CoursesPostRequest {
  /// Returns a new [CoursesPostRequest] instance.
  CoursesPostRequest({
    required this.name,
    required this.code,
    required this.departmentPublicId,
  });

  String name;

  String code;

  String departmentPublicId;

  @override
  bool operator ==(Object other) => identical(this, other) || other is CoursesPostRequest &&
    other.name == name &&
    other.code == code &&
    other.departmentPublicId == departmentPublicId;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (name.hashCode) +
    (code.hashCode) +
    (departmentPublicId.hashCode);

  @override
  String toString() => 'CoursesPostRequest[name=$name, code=$code, departmentPublicId=$departmentPublicId]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'name'] = this.name;
      json[r'code'] = this.code;
      json[r'department_public_id'] = this.departmentPublicId;
    return json;
  }

  /// Returns a new [CoursesPostRequest] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static CoursesPostRequest? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "CoursesPostRequest[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "CoursesPostRequest[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return CoursesPostRequest(
        name: mapValueOfType<String>(json, r'name')!,
        code: mapValueOfType<String>(json, r'code')!,
        departmentPublicId: mapValueOfType<String>(json, r'department_public_id')!,
      );
    }
    return null;
  }

  static List<CoursesPostRequest> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <CoursesPostRequest>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = CoursesPostRequest.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, CoursesPostRequest> mapFromJson(dynamic json) {
    final map = <String, CoursesPostRequest>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = CoursesPostRequest.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of CoursesPostRequest-objects as value to a dart map
  static Map<String, List<CoursesPostRequest>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<CoursesPostRequest>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = CoursesPostRequest.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'name',
    'code',
    'department_public_id',
  };
}

