//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of admin_api;

class FinanceFee {
  /// Returns a new [FinanceFee] instance.
  FinanceFee({
    this.publicId,
    this.student,
    this.title,
    this.totalAmount,
    this.balance,
    this.status,
    this.dueDate,
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
  Student? student;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? title;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  double? totalAmount;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  double? balance;

  FinanceFeeStatusEnum? status;

  DateTime? dueDate;

  @override
  bool operator ==(Object other) => identical(this, other) || other is FinanceFee &&
    other.publicId == publicId &&
    other.student == student &&
    other.title == title &&
    other.totalAmount == totalAmount &&
    other.balance == balance &&
    other.status == status &&
    other.dueDate == dueDate;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (publicId == null ? 0 : publicId!.hashCode) +
    (student == null ? 0 : student!.hashCode) +
    (title == null ? 0 : title!.hashCode) +
    (totalAmount == null ? 0 : totalAmount!.hashCode) +
    (balance == null ? 0 : balance!.hashCode) +
    (status == null ? 0 : status!.hashCode) +
    (dueDate == null ? 0 : dueDate!.hashCode);

  @override
  String toString() => 'FinanceFee[publicId=$publicId, student=$student, title=$title, totalAmount=$totalAmount, balance=$balance, status=$status, dueDate=$dueDate]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.publicId != null) {
      json[r'public_id'] = this.publicId;
    } else {
      json[r'public_id'] = null;
    }
    if (this.student != null) {
      json[r'student'] = this.student;
    } else {
      json[r'student'] = null;
    }
    if (this.title != null) {
      json[r'title'] = this.title;
    } else {
      json[r'title'] = null;
    }
    if (this.totalAmount != null) {
      json[r'total_amount'] = this.totalAmount;
    } else {
      json[r'total_amount'] = null;
    }
    if (this.balance != null) {
      json[r'balance'] = this.balance;
    } else {
      json[r'balance'] = null;
    }
    if (this.status != null) {
      json[r'status'] = this.status;
    } else {
      json[r'status'] = null;
    }
    if (this.dueDate != null) {
      json[r'due_date'] = _dateFormatter.format(this.dueDate!.toUtc());
    } else {
      json[r'due_date'] = null;
    }
    return json;
  }

  /// Returns a new [FinanceFee] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static FinanceFee? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "FinanceFee[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "FinanceFee[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return FinanceFee(
        publicId: mapValueOfType<String>(json, r'public_id'),
        student: Student.fromJson(json[r'student']),
        title: mapValueOfType<String>(json, r'title'),
        totalAmount: mapValueOfType<double>(json, r'total_amount'),
        balance: mapValueOfType<double>(json, r'balance'),
        status: FinanceFeeStatusEnum.fromJson(json[r'status']),
        dueDate: mapDateTime(json, r'due_date', r''),
      );
    }
    return null;
  }

  static List<FinanceFee> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <FinanceFee>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = FinanceFee.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, FinanceFee> mapFromJson(dynamic json) {
    final map = <String, FinanceFee>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = FinanceFee.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of FinanceFee-objects as value to a dart map
  static Map<String, List<FinanceFee>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<FinanceFee>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = FinanceFee.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}


class FinanceFeeStatusEnum {
  /// Instantiate a new enum with the provided [value].
  const FinanceFeeStatusEnum._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const pending = FinanceFeeStatusEnum._(r'pending');
  static const partial = FinanceFeeStatusEnum._(r'partial');
  static const cleared = FinanceFeeStatusEnum._(r'cleared');

  /// List of all possible values in this [enum][FinanceFeeStatusEnum].
  static const values = <FinanceFeeStatusEnum>[
    pending,
    partial,
    cleared,
  ];

  static FinanceFeeStatusEnum? fromJson(dynamic value) => FinanceFeeStatusEnumTypeTransformer().decode(value);

  static List<FinanceFeeStatusEnum> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <FinanceFeeStatusEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = FinanceFeeStatusEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [FinanceFeeStatusEnum] to String,
/// and [decode] dynamic data back to [FinanceFeeStatusEnum].
class FinanceFeeStatusEnumTypeTransformer {
  factory FinanceFeeStatusEnumTypeTransformer() => _instance ??= const FinanceFeeStatusEnumTypeTransformer._();

  const FinanceFeeStatusEnumTypeTransformer._();

  String encode(FinanceFeeStatusEnum data) => data.value;

  /// Decodes a [dynamic value][data] to a FinanceFeeStatusEnum.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  FinanceFeeStatusEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'pending': return FinanceFeeStatusEnum.pending;
        case r'partial': return FinanceFeeStatusEnum.partial;
        case r'cleared': return FinanceFeeStatusEnum.cleared;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [FinanceFeeStatusEnumTypeTransformer] instance.
  static FinanceFeeStatusEnumTypeTransformer? _instance;
}


