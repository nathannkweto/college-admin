//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of admin_api;

class LogisticsTimetablePostRequest {
  /// Returns a new [LogisticsTimetablePostRequest] instance.
  LogisticsTimetablePostRequest({
    required this.semesterPublicId,
    required this.programPublicId,
    required this.coursePublicId,
    required this.day,
    required this.startTime,
    required this.endTime,
    required this.location,
  });

  String semesterPublicId;

  String programPublicId;

  String coursePublicId;

  LogisticsTimetablePostRequestDayEnum day;

  String startTime;

  String endTime;

  String location;

  @override
  bool operator ==(Object other) => identical(this, other) || other is LogisticsTimetablePostRequest &&
    other.semesterPublicId == semesterPublicId &&
    other.programPublicId == programPublicId &&
    other.coursePublicId == coursePublicId &&
    other.day == day &&
    other.startTime == startTime &&
    other.endTime == endTime &&
    other.location == location;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (semesterPublicId.hashCode) +
    (programPublicId.hashCode) +
    (coursePublicId.hashCode) +
    (day.hashCode) +
    (startTime.hashCode) +
    (endTime.hashCode) +
    (location.hashCode);

  @override
  String toString() => 'LogisticsTimetablePostRequest[semesterPublicId=$semesterPublicId, programPublicId=$programPublicId, coursePublicId=$coursePublicId, day=$day, startTime=$startTime, endTime=$endTime, location=$location]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'semester_public_id'] = this.semesterPublicId;
      json[r'program_public_id'] = this.programPublicId;
      json[r'course_public_id'] = this.coursePublicId;
      json[r'day'] = this.day;
      json[r'start_time'] = this.startTime;
      json[r'end_time'] = this.endTime;
      json[r'location'] = this.location;
    return json;
  }

  /// Returns a new [LogisticsTimetablePostRequest] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static LogisticsTimetablePostRequest? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "LogisticsTimetablePostRequest[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "LogisticsTimetablePostRequest[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return LogisticsTimetablePostRequest(
        semesterPublicId: mapValueOfType<String>(json, r'semester_public_id')!,
        programPublicId: mapValueOfType<String>(json, r'program_public_id')!,
        coursePublicId: mapValueOfType<String>(json, r'course_public_id')!,
        day: LogisticsTimetablePostRequestDayEnum.fromJson(json[r'day'])!,
        startTime: mapValueOfType<String>(json, r'start_time')!,
        endTime: mapValueOfType<String>(json, r'end_time')!,
        location: mapValueOfType<String>(json, r'location')!,
      );
    }
    return null;
  }

  static List<LogisticsTimetablePostRequest> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <LogisticsTimetablePostRequest>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = LogisticsTimetablePostRequest.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, LogisticsTimetablePostRequest> mapFromJson(dynamic json) {
    final map = <String, LogisticsTimetablePostRequest>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = LogisticsTimetablePostRequest.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of LogisticsTimetablePostRequest-objects as value to a dart map
  static Map<String, List<LogisticsTimetablePostRequest>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<LogisticsTimetablePostRequest>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = LogisticsTimetablePostRequest.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'semester_public_id',
    'program_public_id',
    'course_public_id',
    'day',
    'start_time',
    'end_time',
    'location',
  };
}


class LogisticsTimetablePostRequestDayEnum {
  /// Instantiate a new enum with the provided [value].
  const LogisticsTimetablePostRequestDayEnum._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const MON = LogisticsTimetablePostRequestDayEnum._(r'MON');
  static const TUE = LogisticsTimetablePostRequestDayEnum._(r'TUE');
  static const WED = LogisticsTimetablePostRequestDayEnum._(r'WED');
  static const THU = LogisticsTimetablePostRequestDayEnum._(r'THU');
  static const FRI = LogisticsTimetablePostRequestDayEnum._(r'FRI');
  static const SAT = LogisticsTimetablePostRequestDayEnum._(r'SAT');
  static const SUN = LogisticsTimetablePostRequestDayEnum._(r'SUN');

  /// List of all possible values in this [enum][LogisticsTimetablePostRequestDayEnum].
  static const values = <LogisticsTimetablePostRequestDayEnum>[
    MON,
    TUE,
    WED,
    THU,
    FRI,
    SAT,
    SUN,
  ];

  static LogisticsTimetablePostRequestDayEnum? fromJson(dynamic value) => LogisticsTimetablePostRequestDayEnumTypeTransformer().decode(value);

  static List<LogisticsTimetablePostRequestDayEnum> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <LogisticsTimetablePostRequestDayEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = LogisticsTimetablePostRequestDayEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [LogisticsTimetablePostRequestDayEnum] to String,
/// and [decode] dynamic data back to [LogisticsTimetablePostRequestDayEnum].
class LogisticsTimetablePostRequestDayEnumTypeTransformer {
  factory LogisticsTimetablePostRequestDayEnumTypeTransformer() => _instance ??= const LogisticsTimetablePostRequestDayEnumTypeTransformer._();

  const LogisticsTimetablePostRequestDayEnumTypeTransformer._();

  String encode(LogisticsTimetablePostRequestDayEnum data) => data.value;

  /// Decodes a [dynamic value][data] to a LogisticsTimetablePostRequestDayEnum.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  LogisticsTimetablePostRequestDayEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'MON': return LogisticsTimetablePostRequestDayEnum.MON;
        case r'TUE': return LogisticsTimetablePostRequestDayEnum.TUE;
        case r'WED': return LogisticsTimetablePostRequestDayEnum.WED;
        case r'THU': return LogisticsTimetablePostRequestDayEnum.THU;
        case r'FRI': return LogisticsTimetablePostRequestDayEnum.FRI;
        case r'SAT': return LogisticsTimetablePostRequestDayEnum.SAT;
        case r'SUN': return LogisticsTimetablePostRequestDayEnum.SUN;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [LogisticsTimetablePostRequestDayEnumTypeTransformer] instance.
  static LogisticsTimetablePostRequestDayEnumTypeTransformer? _instance;
}


