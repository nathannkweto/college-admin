//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of admin_api;

class ProgramCourse {
  /// Returns a new [ProgramCourse] instance.
  ProgramCourse({
    this.publicId,
    required this.name,
    required this.code,
    this.department,
    required this.pivot,
  });

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? publicId;

  String name;

  String code;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  Department? department;

  ProgramCoursePivot pivot;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ProgramCourse &&
    other.publicId == publicId &&
    other.name == name &&
    other.code == code &&
    other.department == department &&
    other.pivot == pivot;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (publicId == null ? 0 : publicId!.hashCode) +
    (name.hashCode) +
    (code.hashCode) +
    (department == null ? 0 : department!.hashCode) +
    (pivot.hashCode);

  @override
  String toString() => 'ProgramCourse[publicId=$publicId, name=$name, code=$code, department=$department, pivot=$pivot]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.publicId != null) {
      json[r'public_id'] = this.publicId;
    } else {
      json[r'public_id'] = null;
    }
      json[r'name'] = this.name;
      json[r'code'] = this.code;
    if (this.department != null) {
      json[r'department'] = this.department;
    } else {
      json[r'department'] = null;
    }
      json[r'pivot'] = this.pivot;
    return json;
  }

  /// Returns a new [ProgramCourse] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ProgramCourse? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "ProgramCourse[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "ProgramCourse[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return ProgramCourse(
        publicId: mapValueOfType<String>(json, r'public_id'),
        name: mapValueOfType<String>(json, r'name')!,
        code: mapValueOfType<String>(json, r'code')!,
        department: Department.fromJson(json[r'department']),
        pivot: ProgramCoursePivot.fromJson(json[r'pivot'])!,
      );
    }
    return null;
  }

  static List<ProgramCourse> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ProgramCourse>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ProgramCourse.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ProgramCourse> mapFromJson(dynamic json) {
    final map = <String, ProgramCourse>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ProgramCourse.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ProgramCourse-objects as value to a dart map
  static Map<String, List<ProgramCourse>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ProgramCourse>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = ProgramCourse.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'name',
    'code',
    'pivot',
  };
}

