//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of lecturer_api;

class GradeSubmission {
  /// Returns a new [GradeSubmission] instance.
  GradeSubmission({
    required this.studentPublicId,
    required this.totalScore,
  });

  String studentPublicId;

  /// Minimum value: 0
  /// Maximum value: 100
  double totalScore;

  @override
  bool operator ==(Object other) => identical(this, other) || other is GradeSubmission &&
    other.studentPublicId == studentPublicId &&
    other.totalScore == totalScore;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (studentPublicId.hashCode) +
    (totalScore.hashCode);

  @override
  String toString() => 'GradeSubmission[studentPublicId=$studentPublicId, totalScore=$totalScore]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'student_public_id'] = this.studentPublicId;
      json[r'total_score'] = this.totalScore;
    return json;
  }

  /// Returns a new [GradeSubmission] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static GradeSubmission? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "GradeSubmission[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "GradeSubmission[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return GradeSubmission(
        studentPublicId: mapValueOfType<String>(json, r'student_public_id')!,
        totalScore: mapValueOfType<double>(json, r'total_score')!,
      );
    }
    return null;
  }

  static List<GradeSubmission> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <GradeSubmission>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = GradeSubmission.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, GradeSubmission> mapFromJson(dynamic json) {
    final map = <String, GradeSubmission>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = GradeSubmission.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of GradeSubmission-objects as value to a dart map
  static Map<String, List<GradeSubmission>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<GradeSubmission>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = GradeSubmission.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'student_public_id',
    'total_score',
  };
}

