//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of admin_api;

class ExamPaperRequest {
  /// Returns a new [ExamPaperRequest] instance.
  ExamPaperRequest({
    required this.seasonPublicId,
    required this.coursePublicId,
    required this.programPublicId,
    required this.date,
    required this.startTime,
    required this.durationMinutes,
    required this.location,
  });

  String seasonPublicId;

  String coursePublicId;

  String programPublicId;

  DateTime date;

  String startTime;

  int durationMinutes;

  String location;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ExamPaperRequest &&
    other.seasonPublicId == seasonPublicId &&
    other.coursePublicId == coursePublicId &&
    other.programPublicId == programPublicId &&
    other.date == date &&
    other.startTime == startTime &&
    other.durationMinutes == durationMinutes &&
    other.location == location;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (seasonPublicId.hashCode) +
    (coursePublicId.hashCode) +
    (programPublicId.hashCode) +
    (date.hashCode) +
    (startTime.hashCode) +
    (durationMinutes.hashCode) +
    (location.hashCode);

  @override
  String toString() => 'ExamPaperRequest[seasonPublicId=$seasonPublicId, coursePublicId=$coursePublicId, programPublicId=$programPublicId, date=$date, startTime=$startTime, durationMinutes=$durationMinutes, location=$location]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'season_public_id'] = this.seasonPublicId;
      json[r'course_public_id'] = this.coursePublicId;
      json[r'program_public_id'] = this.programPublicId;
      json[r'date'] = _dateFormatter.format(this.date.toUtc());
      json[r'start_time'] = this.startTime;
      json[r'duration_minutes'] = this.durationMinutes;
      json[r'location'] = this.location;
    return json;
  }

  /// Returns a new [ExamPaperRequest] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ExamPaperRequest? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "ExamPaperRequest[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "ExamPaperRequest[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return ExamPaperRequest(
        seasonPublicId: mapValueOfType<String>(json, r'season_public_id')!,
        coursePublicId: mapValueOfType<String>(json, r'course_public_id')!,
        programPublicId: mapValueOfType<String>(json, r'program_public_id')!,
        date: mapDateTime(json, r'date', r'')!,
        startTime: mapValueOfType<String>(json, r'start_time')!,
        durationMinutes: mapValueOfType<int>(json, r'duration_minutes')!,
        location: mapValueOfType<String>(json, r'location')!,
      );
    }
    return null;
  }

  static List<ExamPaperRequest> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ExamPaperRequest>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ExamPaperRequest.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ExamPaperRequest> mapFromJson(dynamic json) {
    final map = <String, ExamPaperRequest>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ExamPaperRequest.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ExamPaperRequest-objects as value to a dart map
  static Map<String, List<ExamPaperRequest>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ExamPaperRequest>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = ExamPaperRequest.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'season_public_id',
    'course_public_id',
    'program_public_id',
    'date',
    'start_time',
    'duration_minutes',
    'location',
  };
}

