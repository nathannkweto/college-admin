//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of admin_api;

class ExamPaper {
  /// Returns a new [ExamPaper] instance.
  ExamPaper({
    this.publicId,
    this.date,
    this.startTime,
    this.durationMinutes,
    this.location,
    this.course,
    this.program,
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
  DateTime? date;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? startTime;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? durationMinutes;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? location;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  Course? course;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  Program? program;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ExamPaper &&
    other.publicId == publicId &&
    other.date == date &&
    other.startTime == startTime &&
    other.durationMinutes == durationMinutes &&
    other.location == location &&
    other.course == course &&
    other.program == program;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (publicId == null ? 0 : publicId!.hashCode) +
    (date == null ? 0 : date!.hashCode) +
    (startTime == null ? 0 : startTime!.hashCode) +
    (durationMinutes == null ? 0 : durationMinutes!.hashCode) +
    (location == null ? 0 : location!.hashCode) +
    (course == null ? 0 : course!.hashCode) +
    (program == null ? 0 : program!.hashCode);

  @override
  String toString() => 'ExamPaper[publicId=$publicId, date=$date, startTime=$startTime, durationMinutes=$durationMinutes, location=$location, course=$course, program=$program]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.publicId != null) {
      json[r'public_id'] = this.publicId;
    } else {
      json[r'public_id'] = null;
    }
    if (this.date != null) {
      json[r'date'] = _dateFormatter.format(this.date!.toUtc());
    } else {
      json[r'date'] = null;
    }
    if (this.startTime != null) {
      json[r'start_time'] = this.startTime;
    } else {
      json[r'start_time'] = null;
    }
    if (this.durationMinutes != null) {
      json[r'duration_minutes'] = this.durationMinutes;
    } else {
      json[r'duration_minutes'] = null;
    }
    if (this.location != null) {
      json[r'location'] = this.location;
    } else {
      json[r'location'] = null;
    }
    if (this.course != null) {
      json[r'course'] = this.course;
    } else {
      json[r'course'] = null;
    }
    if (this.program != null) {
      json[r'program'] = this.program;
    } else {
      json[r'program'] = null;
    }
    return json;
  }

  /// Returns a new [ExamPaper] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ExamPaper? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "ExamPaper[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "ExamPaper[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return ExamPaper(
        publicId: mapValueOfType<String>(json, r'public_id'),
        date: mapDateTime(json, r'date', r''),
        startTime: mapValueOfType<String>(json, r'start_time'),
        durationMinutes: mapValueOfType<int>(json, r'duration_minutes'),
        location: mapValueOfType<String>(json, r'location'),
        course: Course.fromJson(json[r'course']),
        program: Program.fromJson(json[r'program']),
      );
    }
    return null;
  }

  static List<ExamPaper> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ExamPaper>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ExamPaper.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ExamPaper> mapFromJson(dynamic json) {
    final map = <String, ExamPaper>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ExamPaper.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ExamPaper-objects as value to a dart map
  static Map<String, List<ExamPaper>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ExamPaper>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = ExamPaper.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}

