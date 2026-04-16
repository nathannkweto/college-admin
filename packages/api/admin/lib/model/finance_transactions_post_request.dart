//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of admin_api;

class FinanceTransactionsPostRequest {
  /// Returns a new [FinanceTransactionsPostRequest] instance.
  FinanceTransactionsPostRequest({
    required this.title,
    required this.amount,
    required this.type,
    required this.date,
    required this.transactionId,
    this.feePublicId,
    this.note,
  });

  String title;

  num amount;

  FinanceTransactionsPostRequestTypeEnum type;

  DateTime date;

  String transactionId;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? feePublicId;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? note;

  @override
  bool operator ==(Object other) => identical(this, other) || other is FinanceTransactionsPostRequest &&
    other.title == title &&
    other.amount == amount &&
    other.type == type &&
    other.date == date &&
    other.transactionId == transactionId &&
    other.feePublicId == feePublicId &&
    other.note == note;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (title.hashCode) +
    (amount.hashCode) +
    (type.hashCode) +
    (date.hashCode) +
    (transactionId.hashCode) +
    (feePublicId == null ? 0 : feePublicId!.hashCode) +
    (note == null ? 0 : note!.hashCode);

  @override
  String toString() => 'FinanceTransactionsPostRequest[title=$title, amount=$amount, type=$type, date=$date, transactionId=$transactionId, feePublicId=$feePublicId, note=$note]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'title'] = this.title;
      json[r'amount'] = this.amount;
      json[r'type'] = this.type;
      json[r'date'] = _dateFormatter.format(this.date.toUtc());
      json[r'transaction_id'] = this.transactionId;
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

  /// Returns a new [FinanceTransactionsPostRequest] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static FinanceTransactionsPostRequest? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "FinanceTransactionsPostRequest[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "FinanceTransactionsPostRequest[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return FinanceTransactionsPostRequest(
        title: mapValueOfType<String>(json, r'title')!,
        amount: num.parse('${json[r'amount']}'),
        type: FinanceTransactionsPostRequestTypeEnum.fromJson(json[r'type'])!,
        date: mapDateTime(json, r'date', r'')!,
        transactionId: mapValueOfType<String>(json, r'transaction_id')!,
        feePublicId: mapValueOfType<String>(json, r'fee_public_id'),
        note: mapValueOfType<String>(json, r'note'),
      );
    }
    return null;
  }

  static List<FinanceTransactionsPostRequest> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <FinanceTransactionsPostRequest>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = FinanceTransactionsPostRequest.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, FinanceTransactionsPostRequest> mapFromJson(dynamic json) {
    final map = <String, FinanceTransactionsPostRequest>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = FinanceTransactionsPostRequest.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of FinanceTransactionsPostRequest-objects as value to a dart map
  static Map<String, List<FinanceTransactionsPostRequest>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<FinanceTransactionsPostRequest>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = FinanceTransactionsPostRequest.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'title',
    'amount',
    'type',
    'date',
    'transaction_id',
  };
}


class FinanceTransactionsPostRequestTypeEnum {
  /// Instantiate a new enum with the provided [value].
  const FinanceTransactionsPostRequestTypeEnum._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const income = FinanceTransactionsPostRequestTypeEnum._(r'income');
  static const expense = FinanceTransactionsPostRequestTypeEnum._(r'expense');

  /// List of all possible values in this [enum][FinanceTransactionsPostRequestTypeEnum].
  static const values = <FinanceTransactionsPostRequestTypeEnum>[
    income,
    expense,
  ];

  static FinanceTransactionsPostRequestTypeEnum? fromJson(dynamic value) => FinanceTransactionsPostRequestTypeEnumTypeTransformer().decode(value);

  static List<FinanceTransactionsPostRequestTypeEnum> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <FinanceTransactionsPostRequestTypeEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = FinanceTransactionsPostRequestTypeEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [FinanceTransactionsPostRequestTypeEnum] to String,
/// and [decode] dynamic data back to [FinanceTransactionsPostRequestTypeEnum].
class FinanceTransactionsPostRequestTypeEnumTypeTransformer {
  factory FinanceTransactionsPostRequestTypeEnumTypeTransformer() => _instance ??= const FinanceTransactionsPostRequestTypeEnumTypeTransformer._();

  const FinanceTransactionsPostRequestTypeEnumTypeTransformer._();

  String encode(FinanceTransactionsPostRequestTypeEnum data) => data.value;

  /// Decodes a [dynamic value][data] to a FinanceTransactionsPostRequestTypeEnum.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  FinanceTransactionsPostRequestTypeEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'income': return FinanceTransactionsPostRequestTypeEnum.income;
        case r'expense': return FinanceTransactionsPostRequestTypeEnum.expense;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [FinanceTransactionsPostRequestTypeEnumTypeTransformer] instance.
  static FinanceTransactionsPostRequestTypeEnumTypeTransformer? _instance;
}


