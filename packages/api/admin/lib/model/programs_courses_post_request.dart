//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of admin_api;

class ProgramsCoursesPostRequest {
  /// Returns a new [ProgramsCoursesPostRequest] instance.
  ProgramsCoursesPostRequest({
    required this.coursePublicId,
    required this.semesterSequence,
    this.lecturerPublicId,
  });

  String coursePublicId;

  int semesterSequence;

  /// Optional: Assign a default lecturer for this course in this program.
  String? lecturerPublicId;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ProgramsCoursesPostRequest &&
    other.coursePublicId == coursePublicId &&
    other.semesterSequence == semesterSequence &&
    other.lecturerPublicId == lecturerPublicId;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (coursePublicId.hashCode) +
    (semesterSequence.hashCode) +
    (lecturerPublicId == null ? 0 : lecturerPublicId!.hashCode);

  @override
  String toString() => 'ProgramsCoursesPostRequest[coursePublicId=$coursePublicId, semesterSequence=$semesterSequence, lecturerPublicId=$lecturerPublicId]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'course_public_id'] = this.coursePublicId;
      json[r'semester_sequence'] = this.semesterSequence;
    if (this.lecturerPublicId != null) {
      json[r'lecturer_public_id'] = this.lecturerPublicId;
    } else {
      json[r'lecturer_public_id'] = null;
    }
    return json;
  }

  /// Returns a new [ProgramsCoursesPostRequest] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ProgramsCoursesPostRequest? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "ProgramsCoursesPostRequest[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "ProgramsCoursesPostRequest[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return ProgramsCoursesPostRequest(
        coursePublicId: mapValueOfType<String>(json, r'course_public_id')!,
        semesterSequence: mapValueOfType<int>(json, r'semester_sequence')!,
        lecturerPublicId: mapValueOfType<String>(json, r'lecturer_public_id'),
      );
    }
    return null;
  }

  static List<ProgramsCoursesPostRequest> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ProgramsCoursesPostRequest>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ProgramsCoursesPostRequest.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ProgramsCoursesPostRequest> mapFromJson(dynamic json) {
    final map = <String, ProgramsCoursesPostRequest>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ProgramsCoursesPostRequest.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ProgramsCoursesPostRequest-objects as value to a dart map
  static Map<String, List<ProgramsCoursesPostRequest>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ProgramsCoursesPostRequest>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = ProgramsCoursesPostRequest.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'course_public_id',
    'semester_sequence',
  };
}

