//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of admin_api;

class FinanceTransactionsGet200Response {
  /// Returns a new [FinanceTransactionsGet200Response] instance.
  FinanceTransactionsGet200Response({
    this.data = const [],
  });

  List<FinanceTransaction> data;

  @override
  bool operator ==(Object other) => identical(this, other) || other is FinanceTransactionsGet200Response &&
    _deepEquality.equals(other.data, data);

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (data.hashCode);

  @override
  String toString() => 'FinanceTransactionsGet200Response[data=$data]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'data'] = this.data;
    return json;
  }

  /// Returns a new [FinanceTransactionsGet200Response] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static FinanceTransactionsGet200Response? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "FinanceTransactionsGet200Response[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "FinanceTransactionsGet200Response[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return FinanceTransactionsGet200Response(
        data: FinanceTransaction.listFromJson(json[r'data']),
      );
    }
    return null;
  }

  static List<FinanceTransactionsGet200Response> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <FinanceTransactionsGet200Response>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = FinanceTransactionsGet200Response.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, FinanceTransactionsGet200Response> mapFromJson(dynamic json) {
    final map = <String, FinanceTransactionsGet200Response>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = FinanceTransactionsGet200Response.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of FinanceTransactionsGet200Response-objects as value to a dart map
  static Map<String, List<FinanceTransactionsGet200Response>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<FinanceTransactionsGet200Response>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = FinanceTransactionsGet200Response.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}

