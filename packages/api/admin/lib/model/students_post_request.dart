//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of admin_api;

class StudentsPostRequest {
  /// Returns a new [StudentsPostRequest] instance.
  StudentsPostRequest({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.programCode,
    required this.gender,
    required this.enrollmentDate,
    required this.nrcNumber,
    required this.dateOfBirth,
    required this.address,
    required this.phoneNumber,
  });

  String firstName;

  String lastName;

  String email;

  String programCode;

  StudentsPostRequestGenderEnum gender;

  DateTime enrollmentDate;

  String nrcNumber;

  DateTime dateOfBirth;

  String address;

  String phoneNumber;

  @override
  bool operator ==(Object other) => identical(this, other) || other is StudentsPostRequest &&
    other.firstName == firstName &&
    other.lastName == lastName &&
    other.email == email &&
    other.programCode == programCode &&
    other.gender == gender &&
    other.enrollmentDate == enrollmentDate &&
    other.nrcNumber == nrcNumber &&
    other.dateOfBirth == dateOfBirth &&
    other.address == address &&
    other.phoneNumber == phoneNumber;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (firstName.hashCode) +
    (lastName.hashCode) +
    (email.hashCode) +
    (programCode.hashCode) +
    (gender.hashCode) +
    (enrollmentDate.hashCode) +
    (nrcNumber.hashCode) +
    (dateOfBirth.hashCode) +
    (address.hashCode) +
    (phoneNumber.hashCode);

  @override
  String toString() => 'StudentsPostRequest[firstName=$firstName, lastName=$lastName, email=$email, programCode=$programCode, gender=$gender, enrollmentDate=$enrollmentDate, nrcNumber=$nrcNumber, dateOfBirth=$dateOfBirth, address=$address, phoneNumber=$phoneNumber]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'first_name'] = this.firstName;
      json[r'last_name'] = this.lastName;
      json[r'email'] = this.email;
      json[r'program_code'] = this.programCode;
      json[r'gender'] = this.gender;
      json[r'enrollment_date'] = _dateFormatter.format(this.enrollmentDate.toUtc());
      json[r'nrc_number'] = this.nrcNumber;
      json[r'date_of_birth'] = _dateFormatter.format(this.dateOfBirth.toUtc());
      json[r'address'] = this.address;
      json[r'phone_number'] = this.phoneNumber;
    return json;
  }

  /// Returns a new [StudentsPostRequest] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static StudentsPostRequest? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "StudentsPostRequest[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "StudentsPostRequest[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return StudentsPostRequest(
        firstName: mapValueOfType<String>(json, r'first_name')!,
        lastName: mapValueOfType<String>(json, r'last_name')!,
        email: mapValueOfType<String>(json, r'email')!,
        programCode: mapValueOfType<String>(json, r'program_code')!,
        gender: StudentsPostRequestGenderEnum.fromJson(json[r'gender'])!,
        enrollmentDate: mapDateTime(json, r'enrollment_date', r'')!,
        nrcNumber: mapValueOfType<String>(json, r'nrc_number')!,
        dateOfBirth: mapDateTime(json, r'date_of_birth', r'')!,
        address: mapValueOfType<String>(json, r'address')!,
        phoneNumber: mapValueOfType<String>(json, r'phone_number')!,
      );
    }
    return null;
  }

  static List<StudentsPostRequest> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <StudentsPostRequest>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = StudentsPostRequest.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, StudentsPostRequest> mapFromJson(dynamic json) {
    final map = <String, StudentsPostRequest>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = StudentsPostRequest.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of StudentsPostRequest-objects as value to a dart map
  static Map<String, List<StudentsPostRequest>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<StudentsPostRequest>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = StudentsPostRequest.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'first_name',
    'last_name',
    'email',
    'program_code',
    'gender',
    'enrollment_date',
    'nrc_number',
    'date_of_birth',
    'address',
    'phone_number',
  };
}


class StudentsPostRequestGenderEnum {
  /// Instantiate a new enum with the provided [value].
  const StudentsPostRequestGenderEnum._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const M = StudentsPostRequestGenderEnum._(r'M');
  static const F = StudentsPostRequestGenderEnum._(r'F');

  /// List of all possible values in this [enum][StudentsPostRequestGenderEnum].
  static const values = <StudentsPostRequestGenderEnum>[
    M,
    F,
  ];

  static StudentsPostRequestGenderEnum? fromJson(dynamic value) => StudentsPostRequestGenderEnumTypeTransformer().decode(value);

  static List<StudentsPostRequestGenderEnum> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <StudentsPostRequestGenderEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = StudentsPostRequestGenderEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [StudentsPostRequestGenderEnum] to String,
/// and [decode] dynamic data back to [StudentsPostRequestGenderEnum].
class StudentsPostRequestGenderEnumTypeTransformer {
  factory StudentsPostRequestGenderEnumTypeTransformer() => _instance ??= const StudentsPostRequestGenderEnumTypeTransformer._();

  const StudentsPostRequestGenderEnumTypeTransformer._();

  String encode(StudentsPostRequestGenderEnum data) => data.value;

  /// Decodes a [dynamic value][data] to a StudentsPostRequestGenderEnum.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  StudentsPostRequestGenderEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'M': return StudentsPostRequestGenderEnum.M;
        case r'F': return StudentsPostRequestGenderEnum.F;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [StudentsPostRequestGenderEnumTypeTransformer] instance.
  static StudentsPostRequestGenderEnumTypeTransformer? _instance;
}


