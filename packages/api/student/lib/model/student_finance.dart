//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of student_api;

class StudentFinance {
  /// Returns a new [StudentFinance] instance.
  StudentFinance({
    this.balance,
    this.currency,
    this.transactions = const [],
  });

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  num? balance;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? currency;

  List<FinanceTransaction> transactions;

  @override
  bool operator ==(Object other) => identical(this, other) || other is StudentFinance &&
    other.balance == balance &&
    other.currency == currency &&
    _deepEquality.equals(other.transactions, transactions);

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (balance == null ? 0 : balance!.hashCode) +
    (currency == null ? 0 : currency!.hashCode) +
    (transactions.hashCode);

  @override
  String toString() => 'StudentFinance[balance=$balance, currency=$currency, transactions=$transactions]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.balance != null) {
      json[r'balance'] = this.balance;
    } else {
      json[r'balance'] = null;
    }
    if (this.currency != null) {
      json[r'currency'] = this.currency;
    } else {
      json[r'currency'] = null;
    }
      json[r'transactions'] = this.transactions;
    return json;
  }

  /// Returns a new [StudentFinance] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static StudentFinance? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "StudentFinance[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "StudentFinance[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return StudentFinance(
        balance: num.parse('${json[r'balance']}'),
        currency: mapValueOfType<String>(json, r'currency'),
        transactions: FinanceTransaction.listFromJson(json[r'transactions']),
      );
    }
    return null;
  }

  static List<StudentFinance> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <StudentFinance>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = StudentFinance.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, StudentFinance> mapFromJson(dynamic json) {
    final map = <String, StudentFinance>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = StudentFinance.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of StudentFinance-objects as value to a dart map
  static Map<String, List<StudentFinance>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<StudentFinance>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = StudentFinance.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}

