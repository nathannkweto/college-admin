//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of student_api;

class DailySchedule {
  /// Returns a new [DailySchedule] instance.
  DailySchedule({
    this.dayName,
    this.isFreeDay,
    this.classes = const [],
  });

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? dayName;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  bool? isFreeDay;

  List<ClassSession> classes;

  @override
  bool operator ==(Object other) => identical(this, other) || other is DailySchedule &&
    other.dayName == dayName &&
    other.isFreeDay == isFreeDay &&
    _deepEquality.equals(other.classes, classes);

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (dayName == null ? 0 : dayName!.hashCode) +
    (isFreeDay == null ? 0 : isFreeDay!.hashCode) +
    (classes.hashCode);

  @override
  String toString() => 'DailySchedule[dayName=$dayName, isFreeDay=$isFreeDay, classes=$classes]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.dayName != null) {
      json[r'day_name'] = this.dayName;
    } else {
      json[r'day_name'] = null;
    }
    if (this.isFreeDay != null) {
      json[r'is_free_day'] = this.isFreeDay;
    } else {
      json[r'is_free_day'] = null;
    }
      json[r'classes'] = this.classes;
    return json;
  }

  /// Returns a new [DailySchedule] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static DailySchedule? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "DailySchedule[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "DailySchedule[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return DailySchedule(
        dayName: mapValueOfType<String>(json, r'day_name'),
        isFreeDay: mapValueOfType<bool>(json, r'is_free_day'),
        classes: ClassSession.listFromJson(json[r'classes']),
      );
    }
    return null;
  }

  static List<DailySchedule> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <DailySchedule>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = DailySchedule.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, DailySchedule> mapFromJson(dynamic json) {
    final map = <String, DailySchedule>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = DailySchedule.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of DailySchedule-objects as value to a dart map
  static Map<String, List<DailySchedule>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<DailySchedule>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = DailySchedule.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}

