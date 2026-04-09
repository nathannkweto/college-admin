//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of admin_api;

class PaginationMeta {
  /// Returns a new [PaginationMeta] instance.
  PaginationMeta({
    this.currentPage,
    this.lastPage,
    this.total,
    this.perPage,
  });

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? currentPage;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? lastPage;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? total;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? perPage;

  @override
  bool operator ==(Object other) => identical(this, other) || other is PaginationMeta &&
    other.currentPage == currentPage &&
    other.lastPage == lastPage &&
    other.total == total &&
    other.perPage == perPage;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (currentPage == null ? 0 : currentPage!.hashCode) +
    (lastPage == null ? 0 : lastPage!.hashCode) +
    (total == null ? 0 : total!.hashCode) +
    (perPage == null ? 0 : perPage!.hashCode);

  @override
  String toString() => 'PaginationMeta[currentPage=$currentPage, lastPage=$lastPage, total=$total, perPage=$perPage]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.currentPage != null) {
      json[r'current_page'] = this.currentPage;
    } else {
      json[r'current_page'] = null;
    }
    if (this.lastPage != null) {
      json[r'last_page'] = this.lastPage;
    } else {
      json[r'last_page'] = null;
    }
    if (this.total != null) {
      json[r'total'] = this.total;
    } else {
      json[r'total'] = null;
    }
    if (this.perPage != null) {
      json[r'per_page'] = this.perPage;
    } else {
      json[r'per_page'] = null;
    }
    return json;
  }

  /// Returns a new [PaginationMeta] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static PaginationMeta? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "PaginationMeta[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "PaginationMeta[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return PaginationMeta(
        currentPage: mapValueOfType<int>(json, r'current_page'),
        lastPage: mapValueOfType<int>(json, r'last_page'),
        total: mapValueOfType<int>(json, r'total'),
        perPage: mapValueOfType<int>(json, r'per_page'),
      );
    }
    return null;
  }

  static List<PaginationMeta> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <PaginationMeta>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = PaginationMeta.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, PaginationMeta> mapFromJson(dynamic json) {
    final map = <String, PaginationMeta>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = PaginationMeta.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of PaginationMeta-objects as value to a dart map
  static Map<String, List<PaginationMeta>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<PaginationMeta>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = PaginationMeta.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}

