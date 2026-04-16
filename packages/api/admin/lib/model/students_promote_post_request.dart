//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of admin_api;

class StudentsPromotePostRequest {
  /// Returns a new [StudentsPromotePostRequest] instance.
  StudentsPromotePostRequest({
    this.excludeStudentIds = const [],
  });

  List<String> excludeStudentIds;

  @override
  bool operator ==(Object other) => identical(this, other) || other is StudentsPromotePostRequest &&
    _deepEquality.equals(other.excludeStudentIds, excludeStudentIds);

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (excludeStudentIds.hashCode);

  @override
  String toString() => 'StudentsPromotePostRequest[excludeStudentIds=$excludeStudentIds]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'exclude_student_ids'] = this.excludeStudentIds;
    return json;
  }

  /// Returns a new [StudentsPromotePostRequest] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static StudentsPromotePostRequest? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "StudentsPromotePostRequest[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "StudentsPromotePostRequest[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return StudentsPromotePostRequest(
        excludeStudentIds: json[r'exclude_student_ids'] is Iterable
            ? (json[r'exclude_student_ids'] as Iterable).cast<String>().toList(growable: false)
            : const [],
      );
    }
    return null;
  }

  static List<StudentsPromotePostRequest> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <StudentsPromotePostRequest>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = StudentsPromotePostRequest.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, StudentsPromotePostRequest> mapFromJson(dynamic json) {
    final map = <String, StudentsPromotePostRequest>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = StudentsPromotePostRequest.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of StudentsPromotePostRequest-objects as value to a dart map
  static Map<String, List<StudentsPromotePostRequest>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<StudentsPromotePostRequest>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = StudentsPromotePostRequest.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}

