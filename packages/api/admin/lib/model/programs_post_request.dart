//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of admin_api;

class ProgramsPostRequest {
  /// Returns a new [ProgramsPostRequest] instance.
  ProgramsPostRequest({
    required this.name,
    required this.code,
    required this.qualificationPublicId,
    required this.departmentPublicId,
    required this.totalSemesters,
  });

  String name;

  String code;

  String qualificationPublicId;

  String departmentPublicId;

  int totalSemesters;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ProgramsPostRequest &&
    other.name == name &&
    other.code == code &&
    other.qualificationPublicId == qualificationPublicId &&
    other.departmentPublicId == departmentPublicId &&
    other.totalSemesters == totalSemesters;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (name.hashCode) +
    (code.hashCode) +
    (qualificationPublicId.hashCode) +
    (departmentPublicId.hashCode) +
    (totalSemesters.hashCode);

  @override
  String toString() => 'ProgramsPostRequest[name=$name, code=$code, qualificationPublicId=$qualificationPublicId, departmentPublicId=$departmentPublicId, totalSemesters=$totalSemesters]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'name'] = this.name;
      json[r'code'] = this.code;
      json[r'qualification_public_id'] = this.qualificationPublicId;
      json[r'department_public_id'] = this.departmentPublicId;
      json[r'total_semesters'] = this.totalSemesters;
    return json;
  }

  /// Returns a new [ProgramsPostRequest] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ProgramsPostRequest? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "ProgramsPostRequest[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "ProgramsPostRequest[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return ProgramsPostRequest(
        name: mapValueOfType<String>(json, r'name')!,
        code: mapValueOfType<String>(json, r'code')!,
        qualificationPublicId: mapValueOfType<String>(json, r'qualification_public_id')!,
        departmentPublicId: mapValueOfType<String>(json, r'department_public_id')!,
        totalSemesters: mapValueOfType<int>(json, r'total_semesters')!,
      );
    }
    return null;
  }

  static List<ProgramsPostRequest> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ProgramsPostRequest>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ProgramsPostRequest.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ProgramsPostRequest> mapFromJson(dynamic json) {
    final map = <String, ProgramsPostRequest>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ProgramsPostRequest.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ProgramsPostRequest-objects as value to a dart map
  static Map<String, List<ProgramsPostRequest>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ProgramsPostRequest>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = ProgramsPostRequest.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'name',
    'code',
    'qualification_public_id',
    'department_public_id',
    'total_semesters',
  };
}

