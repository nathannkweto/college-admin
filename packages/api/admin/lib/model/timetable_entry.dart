//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of admin_api;

class TimetableEntry {
  /// Returns a new [TimetableEntry] instance.
  TimetableEntry({
    this.publicId,
    this.day,
    this.startTime,
    this.endTime,
    this.location,
    this.course,
    this.lecturer,
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
  String? day;

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
  String? endTime;

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
  Lecturer? lecturer;

  @override
  bool operator ==(Object other) => identical(this, other) || other is TimetableEntry &&
    other.publicId == publicId &&
    other.day == day &&
    other.startTime == startTime &&
    other.endTime == endTime &&
    other.location == location &&
    other.course == course &&
    other.lecturer == lecturer;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (publicId == null ? 0 : publicId!.hashCode) +
    (day == null ? 0 : day!.hashCode) +
    (startTime == null ? 0 : startTime!.hashCode) +
    (endTime == null ? 0 : endTime!.hashCode) +
    (location == null ? 0 : location!.hashCode) +
    (course == null ? 0 : course!.hashCode) +
    (lecturer == null ? 0 : lecturer!.hashCode);

  @override
  String toString() => 'TimetableEntry[publicId=$publicId, day=$day, startTime=$startTime, endTime=$endTime, location=$location, course=$course, lecturer=$lecturer]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.publicId != null) {
      json[r'public_id'] = this.publicId;
    } else {
      json[r'public_id'] = null;
    }
    if (this.day != null) {
      json[r'day'] = this.day;
    } else {
      json[r'day'] = null;
    }
    if (this.startTime != null) {
      json[r'start_time'] = this.startTime;
    } else {
      json[r'start_time'] = null;
    }
    if (this.endTime != null) {
      json[r'end_time'] = this.endTime;
    } else {
      json[r'end_time'] = null;
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
    if (this.lecturer != null) {
      json[r'lecturer'] = this.lecturer;
    } else {
      json[r'lecturer'] = null;
    }
    return json;
  }

  /// Returns a new [TimetableEntry] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static TimetableEntry? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "TimetableEntry[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "TimetableEntry[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return TimetableEntry(
        publicId: mapValueOfType<String>(json, r'public_id'),
        day: mapValueOfType<String>(json, r'day'),
        startTime: mapValueOfType<String>(json, r'start_time'),
        endTime: mapValueOfType<String>(json, r'end_time'),
        location: mapValueOfType<String>(json, r'location'),
        course: Course.fromJson(json[r'course']),
        lecturer: Lecturer.fromJson(json[r'lecturer']),
      );
    }
    return null;
  }

  static List<TimetableEntry> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <TimetableEntry>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = TimetableEntry.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, TimetableEntry> mapFromJson(dynamic json) {
    final map = <String, TimetableEntry>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = TimetableEntry.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of TimetableEntry-objects as value to a dart map
  static Map<String, List<TimetableEntry>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<TimetableEntry>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = TimetableEntry.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}

