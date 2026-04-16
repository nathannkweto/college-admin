//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of admin_api;

class ResultsPublishPostRequest {
  /// Returns a new [ResultsPublishPostRequest] instance.
  ResultsPublishPostRequest({
    required this.programPublicId,
    required this.semesterPublicId,
    required this.action,
  });

  String programPublicId;

  String semesterPublicId;

  ResultsPublishPostRequestActionEnum action;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ResultsPublishPostRequest &&
    other.programPublicId == programPublicId &&
    other.semesterPublicId == semesterPublicId &&
    other.action == action;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (programPublicId.hashCode) +
    (semesterPublicId.hashCode) +
    (action.hashCode);

  @override
  String toString() => 'ResultsPublishPostRequest[programPublicId=$programPublicId, semesterPublicId=$semesterPublicId, action=$action]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'program_public_id'] = this.programPublicId;
      json[r'semester_public_id'] = this.semesterPublicId;
      json[r'action'] = this.action;
    return json;
  }

  /// Returns a new [ResultsPublishPostRequest] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ResultsPublishPostRequest? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "ResultsPublishPostRequest[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "ResultsPublishPostRequest[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return ResultsPublishPostRequest(
        programPublicId: mapValueOfType<String>(json, r'program_public_id')!,
        semesterPublicId: mapValueOfType<String>(json, r'semester_public_id')!,
        action: ResultsPublishPostRequestActionEnum.fromJson(json[r'action'])!,
      );
    }
    return null;
  }

  static List<ResultsPublishPostRequest> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ResultsPublishPostRequest>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ResultsPublishPostRequest.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ResultsPublishPostRequest> mapFromJson(dynamic json) {
    final map = <String, ResultsPublishPostRequest>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ResultsPublishPostRequest.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ResultsPublishPostRequest-objects as value to a dart map
  static Map<String, List<ResultsPublishPostRequest>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ResultsPublishPostRequest>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = ResultsPublishPostRequest.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'program_public_id',
    'semester_public_id',
    'action',
  };
}


class ResultsPublishPostRequestActionEnum {
  /// Instantiate a new enum with the provided [value].
  const ResultsPublishPostRequestActionEnum._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const PUBLISH = ResultsPublishPostRequestActionEnum._(r'PUBLISH');
  static const UNPUBLISH = ResultsPublishPostRequestActionEnum._(r'UNPUBLISH');

  /// List of all possible values in this [enum][ResultsPublishPostRequestActionEnum].
  static const values = <ResultsPublishPostRequestActionEnum>[
    PUBLISH,
    UNPUBLISH,
  ];

  static ResultsPublishPostRequestActionEnum? fromJson(dynamic value) => ResultsPublishPostRequestActionEnumTypeTransformer().decode(value);

  static List<ResultsPublishPostRequestActionEnum> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ResultsPublishPostRequestActionEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ResultsPublishPostRequestActionEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [ResultsPublishPostRequestActionEnum] to String,
/// and [decode] dynamic data back to [ResultsPublishPostRequestActionEnum].
class ResultsPublishPostRequestActionEnumTypeTransformer {
  factory ResultsPublishPostRequestActionEnumTypeTransformer() => _instance ??= const ResultsPublishPostRequestActionEnumTypeTransformer._();

  const ResultsPublishPostRequestActionEnumTypeTransformer._();

  String encode(ResultsPublishPostRequestActionEnum data) => data.value;

  /// Decodes a [dynamic value][data] to a ResultsPublishPostRequestActionEnum.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  ResultsPublishPostRequestActionEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'PUBLISH': return ResultsPublishPostRequestActionEnum.PUBLISH;
        case r'UNPUBLISH': return ResultsPublishPostRequestActionEnum.UNPUBLISH;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [ResultsPublishPostRequestActionEnumTypeTransformer] instance.
  static ResultsPublishPostRequestActionEnumTypeTransformer? _instance;
}


