//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of admin_api;

class ExamSeasonsPostRequest {
  /// Returns a new [ExamSeasonsPostRequest] instance.
  ExamSeasonsPostRequest({
    required this.name,
    required this.semesterPublicId,
  });

  String name;

  String semesterPublicId;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ExamSeasonsPostRequest &&
    other.name == name &&
    other.semesterPublicId == semesterPublicId;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (name.hashCode) +
    (semesterPublicId.hashCode);

  @override
  String toString() => 'ExamSeasonsPostRequest[name=$name, semesterPublicId=$semesterPublicId]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'name'] = this.name;
      json[r'semester_public_id'] = this.semesterPublicId;
    return json;
  }

  /// Returns a new [ExamSeasonsPostRequest] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ExamSeasonsPostRequest? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "ExamSeasonsPostRequest[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "ExamSeasonsPostRequest[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return ExamSeasonsPostRequest(
        name: mapValueOfType<String>(json, r'name')!,
        semesterPublicId: mapValueOfType<String>(json, r'semester_public_id')!,
      );
    }
    return null;
  }

  static List<ExamSeasonsPostRequest> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ExamSeasonsPostRequest>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ExamSeasonsPostRequest.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ExamSeasonsPostRequest> mapFromJson(dynamic json) {
    final map = <String, ExamSeasonsPostRequest>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ExamSeasonsPostRequest.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ExamSeasonsPostRequest-objects as value to a dart map
  static Map<String, List<ExamSeasonsPostRequest>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ExamSeasonsPostRequest>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = ExamSeasonsPostRequest.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'name',
    'semester_public_id',
  };
}

