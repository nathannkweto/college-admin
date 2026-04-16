//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of admin_api;

class FinanceFeesPostRequest {
  /// Returns a new [FinanceFeesPostRequest] instance.
  FinanceFeesPostRequest({
    required this.title,
    required this.amount,
    required this.targetType,
    this.targetPublicId,
    this.dueDate,
  });

  String title;

  num amount;

  FinanceFeesPostRequestTargetTypeEnum targetType;

  String? targetPublicId;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  DateTime? dueDate;

  @override
  bool operator ==(Object other) => identical(this, other) || other is FinanceFeesPostRequest &&
    other.title == title &&
    other.amount == amount &&
    other.targetType == targetType &&
    other.targetPublicId == targetPublicId &&
    other.dueDate == dueDate;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (title.hashCode) +
    (amount.hashCode) +
    (targetType.hashCode) +
    (targetPublicId == null ? 0 : targetPublicId!.hashCode) +
    (dueDate == null ? 0 : dueDate!.hashCode);

  @override
  String toString() => 'FinanceFeesPostRequest[title=$title, amount=$amount, targetType=$targetType, targetPublicId=$targetPublicId, dueDate=$dueDate]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'title'] = this.title;
      json[r'amount'] = this.amount;
      json[r'target_type'] = this.targetType;
    if (this.targetPublicId != null) {
      json[r'target_public_id'] = this.targetPublicId;
    } else {
      json[r'target_public_id'] = null;
    }
    if (this.dueDate != null) {
      json[r'due_date'] = _dateFormatter.format(this.dueDate!.toUtc());
    } else {
      json[r'due_date'] = null;
    }
    return json;
  }

  /// Returns a new [FinanceFeesPostRequest] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static FinanceFeesPostRequest? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "FinanceFeesPostRequest[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "FinanceFeesPostRequest[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return FinanceFeesPostRequest(
        title: mapValueOfType<String>(json, r'title')!,
        amount: num.parse('${json[r'amount']}'),
        targetType: FinanceFeesPostRequestTargetTypeEnum.fromJson(json[r'target_type'])!,
        targetPublicId: mapValueOfType<String>(json, r'target_public_id'),
        dueDate: mapDateTime(json, r'due_date', r''),
      );
    }
    return null;
  }

  static List<FinanceFeesPostRequest> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <FinanceFeesPostRequest>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = FinanceFeesPostRequest.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, FinanceFeesPostRequest> mapFromJson(dynamic json) {
    final map = <String, FinanceFeesPostRequest>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = FinanceFeesPostRequest.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of FinanceFeesPostRequest-objects as value to a dart map
  static Map<String, List<FinanceFeesPostRequest>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<FinanceFeesPostRequest>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = FinanceFeesPostRequest.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'title',
    'amount',
    'target_type',
  };
}


class FinanceFeesPostRequestTargetTypeEnum {
  /// Instantiate a new enum with the provided [value].
  const FinanceFeesPostRequestTargetTypeEnum._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const ALL = FinanceFeesPostRequestTargetTypeEnum._(r'ALL');
  static const PROGRAM = FinanceFeesPostRequestTargetTypeEnum._(r'PROGRAM');
  static const STUDENT = FinanceFeesPostRequestTargetTypeEnum._(r'STUDENT');

  /// List of all possible values in this [enum][FinanceFeesPostRequestTargetTypeEnum].
  static const values = <FinanceFeesPostRequestTargetTypeEnum>[
    ALL,
    PROGRAM,
    STUDENT,
  ];

  static FinanceFeesPostRequestTargetTypeEnum? fromJson(dynamic value) => FinanceFeesPostRequestTargetTypeEnumTypeTransformer().decode(value);

  static List<FinanceFeesPostRequestTargetTypeEnum> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <FinanceFeesPostRequestTargetTypeEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = FinanceFeesPostRequestTargetTypeEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [FinanceFeesPostRequestTargetTypeEnum] to String,
/// and [decode] dynamic data back to [FinanceFeesPostRequestTargetTypeEnum].
class FinanceFeesPostRequestTargetTypeEnumTypeTransformer {
  factory FinanceFeesPostRequestTargetTypeEnumTypeTransformer() => _instance ??= const FinanceFeesPostRequestTargetTypeEnumTypeTransformer._();

  const FinanceFeesPostRequestTargetTypeEnumTypeTransformer._();

  String encode(FinanceFeesPostRequestTargetTypeEnum data) => data.value;

  /// Decodes a [dynamic value][data] to a FinanceFeesPostRequestTargetTypeEnum.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  FinanceFeesPostRequestTargetTypeEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'ALL': return FinanceFeesPostRequestTargetTypeEnum.ALL;
        case r'PROGRAM': return FinanceFeesPostRequestTargetTypeEnum.PROGRAM;
        case r'STUDENT': return FinanceFeesPostRequestTargetTypeEnum.STUDENT;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [FinanceFeesPostRequestTargetTypeEnumTypeTransformer] instance.
  static FinanceFeesPostRequestTargetTypeEnumTypeTransformer? _instance;
}


