//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of admin_api;

class DashboardMetrics {
  /// Returns a new [DashboardMetrics] instance.
  DashboardMetrics({
    required this.students,
    required this.lecturers,
    required this.programs,
    required this.levels,
  });

  int students;

  int lecturers;

  int programs;

  int levels;

  @override
  bool operator ==(Object other) => identical(this, other) || other is DashboardMetrics &&
    other.students == students &&
    other.lecturers == lecturers &&
    other.programs == programs &&
    other.levels == levels;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (students.hashCode) +
    (lecturers.hashCode) +
    (programs.hashCode) +
    (levels.hashCode);

  @override
  String toString() => 'DashboardMetrics[students=$students, lecturers=$lecturers, programs=$programs, levels=$levels]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'students'] = this.students;
      json[r'lecturers'] = this.lecturers;
      json[r'programs'] = this.programs;
      json[r'levels'] = this.levels;
    return json;
  }

  /// Returns a new [DashboardMetrics] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static DashboardMetrics? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "DashboardMetrics[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "DashboardMetrics[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return DashboardMetrics(
        students: mapValueOfType<int>(json, r'students')!,
        lecturers: mapValueOfType<int>(json, r'lecturers')!,
        programs: mapValueOfType<int>(json, r'programs')!,
        levels: mapValueOfType<int>(json, r'levels')!,
      );
    }
    return null;
  }

  static List<DashboardMetrics> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <DashboardMetrics>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = DashboardMetrics.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, DashboardMetrics> mapFromJson(dynamic json) {
    final map = <String, DashboardMetrics>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = DashboardMetrics.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of DashboardMetrics-objects as value to a dart map
  static Map<String, List<DashboardMetrics>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<DashboardMetrics>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = DashboardMetrics.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'students',
    'lecturers',
    'programs',
    'levels',
  };
}

