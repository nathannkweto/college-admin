//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of admin_api;

class LecturersPostRequest {
  /// Returns a new [LecturersPostRequest] instance.
  LecturersPostRequest({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.departmentCode,
    required this.title,
    required this.gender,
    this.nrcNumber,
    this.dateOfBirth,
    this.address,
    this.phoneNumber,
  });

  String firstName;

  String lastName;

  String email;

  String departmentCode;

  LecturersPostRequestTitleEnum title;

  LecturersPostRequestGenderEnum gender;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? nrcNumber;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  DateTime? dateOfBirth;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? address;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? phoneNumber;

  @override
  bool operator ==(Object other) => identical(this, other) || other is LecturersPostRequest &&
    other.firstName == firstName &&
    other.lastName == lastName &&
    other.email == email &&
    other.departmentCode == departmentCode &&
    other.title == title &&
    other.gender == gender &&
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
    (departmentCode.hashCode) +
    (title.hashCode) +
    (gender.hashCode) +
    (nrcNumber == null ? 0 : nrcNumber!.hashCode) +
    (dateOfBirth == null ? 0 : dateOfBirth!.hashCode) +
    (address == null ? 0 : address!.hashCode) +
    (phoneNumber == null ? 0 : phoneNumber!.hashCode);

  @override
  String toString() => 'LecturersPostRequest[firstName=$firstName, lastName=$lastName, email=$email, departmentCode=$departmentCode, title=$title, gender=$gender, nrcNumber=$nrcNumber, dateOfBirth=$dateOfBirth, address=$address, phoneNumber=$phoneNumber]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'first_name'] = this.firstName;
      json[r'last_name'] = this.lastName;
      json[r'email'] = this.email;
      json[r'department_code'] = this.departmentCode;
      json[r'title'] = this.title;
      json[r'gender'] = this.gender;
    if (this.nrcNumber != null) {
      json[r'nrc_number'] = this.nrcNumber;
    } else {
      json[r'nrc_number'] = null;
    }
    if (this.dateOfBirth != null) {
      json[r'date_of_birth'] = _dateFormatter.format(this.dateOfBirth!.toUtc());
    } else {
      json[r'date_of_birth'] = null;
    }
    if (this.address != null) {
      json[r'address'] = this.address;
    } else {
      json[r'address'] = null;
    }
    if (this.phoneNumber != null) {
      json[r'phone_number'] = this.phoneNumber;
    } else {
      json[r'phone_number'] = null;
    }
    return json;
  }

  /// Returns a new [LecturersPostRequest] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static LecturersPostRequest? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "LecturersPostRequest[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "LecturersPostRequest[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return LecturersPostRequest(
        firstName: mapValueOfType<String>(json, r'first_name')!,
        lastName: mapValueOfType<String>(json, r'last_name')!,
        email: mapValueOfType<String>(json, r'email')!,
        departmentCode: mapValueOfType<String>(json, r'department_code')!,
        title: LecturersPostRequestTitleEnum.fromJson(json[r'title'])!,
        gender: LecturersPostRequestGenderEnum.fromJson(json[r'gender'])!,
        nrcNumber: mapValueOfType<String>(json, r'nrc_number'),
        dateOfBirth: mapDateTime(json, r'date_of_birth', r''),
        address: mapValueOfType<String>(json, r'address'),
        phoneNumber: mapValueOfType<String>(json, r'phone_number'),
      );
    }
    return null;
  }

  static List<LecturersPostRequest> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <LecturersPostRequest>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = LecturersPostRequest.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, LecturersPostRequest> mapFromJson(dynamic json) {
    final map = <String, LecturersPostRequest>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = LecturersPostRequest.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of LecturersPostRequest-objects as value to a dart map
  static Map<String, List<LecturersPostRequest>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<LecturersPostRequest>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = LecturersPostRequest.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'first_name',
    'last_name',
    'email',
    'department_code',
    'title',
    'gender',
  };
}


class LecturersPostRequestTitleEnum {
  /// Instantiate a new enum with the provided [value].
  const LecturersPostRequestTitleEnum._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const mr = LecturersPostRequestTitleEnum._(r'Mr');
  static const ms = LecturersPostRequestTitleEnum._(r'Ms');
  static const mrs = LecturersPostRequestTitleEnum._(r'Mrs');
  static const dr = LecturersPostRequestTitleEnum._(r'Dr');
  static const prof = LecturersPostRequestTitleEnum._(r'Prof');

  /// List of all possible values in this [enum][LecturersPostRequestTitleEnum].
  static const values = <LecturersPostRequestTitleEnum>[
    mr,
    ms,
    mrs,
    dr,
    prof,
  ];

  static LecturersPostRequestTitleEnum? fromJson(dynamic value) => LecturersPostRequestTitleEnumTypeTransformer().decode(value);

  static List<LecturersPostRequestTitleEnum> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <LecturersPostRequestTitleEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = LecturersPostRequestTitleEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [LecturersPostRequestTitleEnum] to String,
/// and [decode] dynamic data back to [LecturersPostRequestTitleEnum].
class LecturersPostRequestTitleEnumTypeTransformer {
  factory LecturersPostRequestTitleEnumTypeTransformer() => _instance ??= const LecturersPostRequestTitleEnumTypeTransformer._();

  const LecturersPostRequestTitleEnumTypeTransformer._();

  String encode(LecturersPostRequestTitleEnum data) => data.value;

  /// Decodes a [dynamic value][data] to a LecturersPostRequestTitleEnum.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  LecturersPostRequestTitleEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'Mr': return LecturersPostRequestTitleEnum.mr;
        case r'Ms': return LecturersPostRequestTitleEnum.ms;
        case r'Mrs': return LecturersPostRequestTitleEnum.mrs;
        case r'Dr': return LecturersPostRequestTitleEnum.dr;
        case r'Prof': return LecturersPostRequestTitleEnum.prof;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [LecturersPostRequestTitleEnumTypeTransformer] instance.
  static LecturersPostRequestTitleEnumTypeTransformer? _instance;
}



class LecturersPostRequestGenderEnum {
  /// Instantiate a new enum with the provided [value].
  const LecturersPostRequestGenderEnum._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const M = LecturersPostRequestGenderEnum._(r'M');
  static const F = LecturersPostRequestGenderEnum._(r'F');

  /// List of all possible values in this [enum][LecturersPostRequestGenderEnum].
  static const values = <LecturersPostRequestGenderEnum>[
    M,
    F,
  ];

  static LecturersPostRequestGenderEnum? fromJson(dynamic value) => LecturersPostRequestGenderEnumTypeTransformer().decode(value);

  static List<LecturersPostRequestGenderEnum> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <LecturersPostRequestGenderEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = LecturersPostRequestGenderEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [LecturersPostRequestGenderEnum] to String,
/// and [decode] dynamic data back to [LecturersPostRequestGenderEnum].
class LecturersPostRequestGenderEnumTypeTransformer {
  factory LecturersPostRequestGenderEnumTypeTransformer() => _instance ??= const LecturersPostRequestGenderEnumTypeTransformer._();

  const LecturersPostRequestGenderEnumTypeTransformer._();

  String encode(LecturersPostRequestGenderEnum data) => data.value;

  /// Decodes a [dynamic value][data] to a LecturersPostRequestGenderEnum.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  LecturersPostRequestGenderEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'M': return LecturersPostRequestGenderEnum.M;
        case r'F': return LecturersPostRequestGenderEnum.F;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [LecturersPostRequestGenderEnumTypeTransformer] instance.
  static LecturersPostRequestGenderEnumTypeTransformer? _instance;
}


