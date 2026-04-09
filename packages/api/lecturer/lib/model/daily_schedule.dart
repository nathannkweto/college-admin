//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of lecturer_api;

class DailySchedule {
  /// Returns a new [DailySchedule] instance.
  DailySchedule({
    this.dayName,
    this.isResearchDay,
    this.classes = const [],
  });

  DailyScheduleDayNameEnum? dayName;

  /// True if there are no classes scheduled for this day.
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  bool? isResearchDay;

  List<ClassSession> classes;

  @override
  bool operator ==(Object other) => identical(this, other) || other is DailySchedule &&
    other.dayName == dayName &&
    other.isResearchDay == isResearchDay &&
    _deepEquality.equals(other.classes, classes);

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (dayName == null ? 0 : dayName!.hashCode) +
    (isResearchDay == null ? 0 : isResearchDay!.hashCode) +
    (classes.hashCode);

  @override
  String toString() => 'DailySchedule[dayName=$dayName, isResearchDay=$isResearchDay, classes=$classes]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.dayName != null) {
      json[r'day_name'] = this.dayName;
    } else {
      json[r'day_name'] = null;
    }
    if (this.isResearchDay != null) {
      json[r'is_research_day'] = this.isResearchDay;
    } else {
      json[r'is_research_day'] = null;
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
        dayName: DailyScheduleDayNameEnum.fromJson(json[r'day_name']),
        isResearchDay: mapValueOfType<bool>(json, r'is_research_day'),
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


class DailyScheduleDayNameEnum {
  /// Instantiate a new enum with the provided [value].
  const DailyScheduleDayNameEnum._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const monday = DailyScheduleDayNameEnum._(r'Monday');
  static const tuesday = DailyScheduleDayNameEnum._(r'Tuesday');
  static const wednesday = DailyScheduleDayNameEnum._(r'Wednesday');
  static const thursday = DailyScheduleDayNameEnum._(r'Thursday');
  static const friday = DailyScheduleDayNameEnum._(r'Friday');
  static const saturday = DailyScheduleDayNameEnum._(r'Saturday');
  static const sunday = DailyScheduleDayNameEnum._(r'Sunday');

  /// List of all possible values in this [enum][DailyScheduleDayNameEnum].
  static const values = <DailyScheduleDayNameEnum>[
    monday,
    tuesday,
    wednesday,
    thursday,
    friday,
    saturday,
    sunday,
  ];

  static DailyScheduleDayNameEnum? fromJson(dynamic value) => DailyScheduleDayNameEnumTypeTransformer().decode(value);

  static List<DailyScheduleDayNameEnum> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <DailyScheduleDayNameEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = DailyScheduleDayNameEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [DailyScheduleDayNameEnum] to String,
/// and [decode] dynamic data back to [DailyScheduleDayNameEnum].
class DailyScheduleDayNameEnumTypeTransformer {
  factory DailyScheduleDayNameEnumTypeTransformer() => _instance ??= const DailyScheduleDayNameEnumTypeTransformer._();

  const DailyScheduleDayNameEnumTypeTransformer._();

  String encode(DailyScheduleDayNameEnum data) => data.value;

  /// Decodes a [dynamic value][data] to a DailyScheduleDayNameEnum.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  DailyScheduleDayNameEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'Monday': return DailyScheduleDayNameEnum.monday;
        case r'Tuesday': return DailyScheduleDayNameEnum.tuesday;
        case r'Wednesday': return DailyScheduleDayNameEnum.wednesday;
        case r'Thursday': return DailyScheduleDayNameEnum.thursday;
        case r'Friday': return DailyScheduleDayNameEnum.friday;
        case r'Saturday': return DailyScheduleDayNameEnum.saturday;
        case r'Sunday': return DailyScheduleDayNameEnum.sunday;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [DailyScheduleDayNameEnumTypeTransformer] instance.
  static DailyScheduleDayNameEnumTypeTransformer? _instance;
}


