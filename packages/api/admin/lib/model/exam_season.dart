//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of admin_api;

class ExamSeason {
  /// Returns a new [ExamSeason] instance.
  ExamSeason({
    this.publicId,
    this.name,
    this.isActive,
    this.createdAt,
    this.semester,
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
  String? name;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  bool? isActive;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  DateTime? createdAt;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  Department? semester;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ExamSeason &&
    other.publicId == publicId &&
    other.name == name &&
    other.isActive == isActive &&
    other.createdAt == createdAt &&
    other.semester == semester;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (publicId == null ? 0 : publicId!.hashCode) +
    (name == null ? 0 : name!.hashCode) +
    (isActive == null ? 0 : isActive!.hashCode) +
    (createdAt == null ? 0 : createdAt!.hashCode) +
    (semester == null ? 0 : semester!.hashCode);

  @override
  String toString() => 'ExamSeason[publicId=$publicId, name=$name, isActive=$isActive, createdAt=$createdAt, semester=$semester]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.publicId != null) {
      json[r'public_id'] = this.publicId;
    } else {
      json[r'public_id'] = null;
    }
    if (this.name != null) {
      json[r'name'] = this.name;
    } else {
      json[r'name'] = null;
    }
    if (this.isActive != null) {
      json[r'is_active'] = this.isActive;
    } else {
      json[r'is_active'] = null;
    }
    if (this.createdAt != null) {
      json[r'created_at'] = this.createdAt!.toUtc().toIso8601String();
    } else {
      json[r'created_at'] = null;
    }
    if (this.semester != null) {
      json[r'semester'] = this.semester;
    } else {
      json[r'semester'] = null;
    }
    return json;
  }

  /// Returns a new [ExamSeason] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ExamSeason? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "ExamSeason[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "ExamSeason[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return ExamSeason(
        publicId: mapValueOfType<String>(json, r'public_id'),
        name: mapValueOfType<String>(json, r'name'),
        isActive: mapValueOfType<bool>(json, r'is_active'),
        createdAt: mapDateTime(json, r'created_at', r''),
        semester: Department.fromJson(json[r'semester']),
      );
    }
    return null;
  }

  static List<ExamSeason> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ExamSeason>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ExamSeason.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ExamSeason> mapFromJson(dynamic json) {
    final map = <String, ExamSeason>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ExamSeason.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ExamSeason-objects as value to a dart map
  static Map<String, List<ExamSeason>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ExamSeason>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = ExamSeason.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}

