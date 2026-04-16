//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of admin_api;

class FinanceTransaction {
  /// Returns a new [FinanceTransaction] instance.
  FinanceTransaction({
    this.publicId,
    this.transactionId,
    this.type,
    this.title,
    this.amount,
    this.date,
    this.feePublicId,
    this.note,
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
  String? transactionId;

  FinanceTransactionTypeEnum? type;

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
  double? amount;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  DateTime? date;

  String? feePublicId;

  String? note;

  @override
  bool operator ==(Object other) => identical(this, other) || other is FinanceTransaction &&
    other.publicId == publicId &&
    other.transactionId == transactionId &&
    other.type == type &&
    other.title == title &&
    other.amount == amount &&
    other.date == date &&
    other.feePublicId == feePublicId &&
    other.note == note;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (publicId == null ? 0 : publicId!.hashCode) +
    (transactionId == null ? 0 : transactionId!.hashCode) +
    (type == null ? 0 : type!.hashCode) +
    (title == null ? 0 : title!.hashCode) +
    (amount == null ? 0 : amount!.hashCode) +
    (date == null ? 0 : date!.hashCode) +
    (feePublicId == null ? 0 : feePublicId!.hashCode) +
    (note == null ? 0 : note!.hashCode);

  @override
  String toString() => 'FinanceTransaction[publicId=$publicId, transactionId=$transactionId, type=$type, title=$title, amount=$amount, date=$date, feePublicId=$feePublicId, note=$note]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.publicId != null) {
      json[r'public_id'] = this.publicId;
    } else {
      json[r'public_id'] = null;
    }
    if (this.transactionId != null) {
      json[r'transaction_id'] = this.transactionId;
    } else {
      json[r'transaction_id'] = null;
    }
    if (this.type != null) {
      json[r'type'] = this.type;
    } else {
      json[r'type'] = null;
    }
    if (this.title != null) {
      json[r'title'] = this.title;
    } else {
      json[r'title'] = null;
    }
    if (this.amount != null) {
      json[r'amount'] = this.amount;
    } else {
      json[r'amount'] = null;
    }
    if (this.date != null) {
      json[r'date'] = _dateFormatter.format(this.date!.toUtc());
    } else {
      json[r'date'] = null;
    }
    if (this.feePublicId != null) {
      json[r'fee_public_id'] = this.feePublicId;
    } else {
      json[r'fee_public_id'] = null;
    }
    if (this.note != null) {
      json[r'note'] = this.note;
    } else {
      json[r'note'] = null;
    }
    return json;
  }

  /// Returns a new [FinanceTransaction] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static FinanceTransaction? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "FinanceTransaction[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "FinanceTransaction[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return FinanceTransaction(
        publicId: mapValueOfType<String>(json, r'public_id'),
        transactionId: mapValueOfType<String>(json, r'transaction_id'),
        type: FinanceTransactionTypeEnum.fromJson(json[r'type']),
        title: mapValueOfType<String>(json, r'title'),
        amount: mapValueOfType<double>(json, r'amount'),
        date: mapDateTime(json, r'date', r''),
        feePublicId: mapValueOfType<String>(json, r'fee_public_id'),
        note: mapValueOfType<String>(json, r'note'),
      );
    }
    return null;
  }

  static List<FinanceTransaction> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <FinanceTransaction>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = FinanceTransaction.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, FinanceTransaction> mapFromJson(dynamic json) {
    final map = <String, FinanceTransaction>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = FinanceTransaction.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of FinanceTransaction-objects as value to a dart map
  static Map<String, List<FinanceTransaction>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<FinanceTransaction>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = FinanceTransaction.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}


class FinanceTransactionTypeEnum {
  /// Instantiate a new enum with the provided [value].
  const FinanceTransactionTypeEnum._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const income = FinanceTransactionTypeEnum._(r'income');
  static const expense = FinanceTransactionTypeEnum._(r'expense');

  /// List of all possible values in this [enum][FinanceTransactionTypeEnum].
  static const values = <FinanceTransactionTypeEnum>[
    income,
    expense,
  ];

  static FinanceTransactionTypeEnum? fromJson(dynamic value) => FinanceTransactionTypeEnumTypeTransformer().decode(value);

  static List<FinanceTransactionTypeEnum> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <FinanceTransactionTypeEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = FinanceTransactionTypeEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [FinanceTransactionTypeEnum] to String,
/// and [decode] dynamic data back to [FinanceTransactionTypeEnum].
class FinanceTransactionTypeEnumTypeTransformer {
  factory FinanceTransactionTypeEnumTypeTransformer() => _instance ??= const FinanceTransactionTypeEnumTypeTransformer._();

  const FinanceTransactionTypeEnumTypeTransformer._();

  String encode(FinanceTransactionTypeEnum data) => data.value;

  /// Decodes a [dynamic value][data] to a FinanceTransactionTypeEnum.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  FinanceTransactionTypeEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'income': return FinanceTransactionTypeEnum.income;
        case r'expense': return FinanceTransactionTypeEnum.expense;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [FinanceTransactionTypeEnumTypeTransformer] instance.
  static FinanceTransactionTypeEnumTypeTransformer? _instance;
}


