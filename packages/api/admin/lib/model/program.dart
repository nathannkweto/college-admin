//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of admin_api;

class Program {
  /// Returns a new [Program] instance.
  Program({
    this.publicId,
    this.name,
    this.code,
    this.totalSemesters,
    this.qualification,
    this.department,
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
  String? name;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? code;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? totalSemesters;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  Qualification? qualification;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  Department? department;

  @override
  bool operator ==(Object other) => identical(this, other) || other is Program &&
    other.publicId == publicId &&
    other.name == name &&
    other.code == code &&
    other.totalSemesters == totalSemesters &&
    other.qualification == qualification &&
    other.department == department;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (publicId == null ? 0 : publicId!.hashCode) +
    (name == null ? 0 : name!.hashCode) +
    (code == null ? 0 : code!.hashCode) +
    (totalSemesters == null ? 0 : totalSemesters!.hashCode) +
    (qualification == null ? 0 : qualification!.hashCode) +
    (department == null ? 0 : department!.hashCode);

  @override
  String toString() => 'Program[publicId=$publicId, name=$name, code=$code, totalSemesters=$totalSemesters, qualification=$qualification, department=$department]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.publicId != null) {
      json[r'public_id'] = this.publicId;
    } else {
      json[r'public_id'] = null;
    }
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
    if (this.totalSemesters != null) {
      json[r'total_semesters'] = this.totalSemesters;
    } else {
      json[r'total_semesters'] = null;
    }
    if (this.qualification != null) {
      json[r'qualification'] = this.qualification;
    } else {
      json[r'qualification'] = null;
    }
    if (this.department != null) {
      json[r'department'] = this.department;
    } else {
      json[r'department'] = null;
    }
    return json;
  }

  /// Returns a new [Program] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static Program? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "Program[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "Program[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return Program(
        publicId: mapValueOfType<String>(json, r'public_id'),
        name: mapValueOfType<String>(json, r'name'),
        code: mapValueOfType<String>(json, r'code'),
        totalSemesters: mapValueOfType<int>(json, r'total_semesters'),
        qualification: Qualification.fromJson(json[r'qualification']),
        department: Department.fromJson(json[r'department']),
      );
    }
    return null;
  }

  static List<Program> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <Program>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = Program.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, Program> mapFromJson(dynamic json) {
    final map = <String, Program>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = Program.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of Program-objects as value to a dart map
  static Map<String, List<Program>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<Program>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = Program.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}

