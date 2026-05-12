//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class LecturersUpdateRequest {
  /// Returns a new [LecturersUpdateRequest] instance.
  LecturersUpdateRequest({
    this.firstName,
    this.lastName,
    this.email,
    this.departmentCode,
    this.title,
    this.gender,
    this.nrcNumber,
    this.dateOfBirth,
    this.address,
    this.phoneNumber,
  });

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? firstName;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? lastName;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? email;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? departmentCode;

  LecturersUpdateRequestTitleEnum? title;

  LecturersUpdateRequestGenderEnum? gender;

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
  bool operator ==(Object other) => identical(this, other) || other is LecturersUpdateRequest &&
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
    (firstName == null ? 0 : firstName!.hashCode) +
    (lastName == null ? 0 : lastName!.hashCode) +
    (email == null ? 0 : email!.hashCode) +
    (departmentCode == null ? 0 : departmentCode!.hashCode) +
    (title == null ? 0 : title!.hashCode) +
    (gender == null ? 0 : gender!.hashCode) +
    (nrcNumber == null ? 0 : nrcNumber!.hashCode) +
    (dateOfBirth == null ? 0 : dateOfBirth!.hashCode) +
    (address == null ? 0 : address!.hashCode) +
    (phoneNumber == null ? 0 : phoneNumber!.hashCode);

  @override
  String toString() => 'LecturersUpdateRequest[firstName=$firstName, lastName=$lastName, email=$email, departmentCode=$departmentCode, title=$title, gender=$gender, nrcNumber=$nrcNumber, dateOfBirth=$dateOfBirth, address=$address, phoneNumber=$phoneNumber]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.firstName != null) {
      json[r'first_name'] = this.firstName;
    } else {
      json[r'first_name'] = null;
    }
    if (this.lastName != null) {
      json[r'last_name'] = this.lastName;
    } else {
      json[r'last_name'] = null;
    }
    if (this.email != null) {
      json[r'email'] = this.email;
    } else {
      json[r'email'] = null;
    }
    if (this.departmentCode != null) {
      json[r'department_code'] = this.departmentCode;
    } else {
      json[r'department_code'] = null;
    }
    if (this.title != null) {
      json[r'title'] = this.title;
    } else {
      json[r'title'] = null;
    }
    if (this.gender != null) {
      json[r'gender'] = this.gender;
    } else {
      json[r'gender'] = null;
    }
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

  /// Returns a new [LecturersUpdateRequest] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static LecturersUpdateRequest? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "LecturersUpdateRequest[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "LecturersUpdateRequest[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return LecturersUpdateRequest(
        firstName: mapValueOfType<String>(json, r'first_name'),
        lastName: mapValueOfType<String>(json, r'last_name'),
        email: mapValueOfType<String>(json, r'email'),
        departmentCode: mapValueOfType<String>(json, r'department_code'),
        title: LecturersUpdateRequestTitleEnum.fromJson(json[r'title']),
        gender: LecturersUpdateRequestGenderEnum.fromJson(json[r'gender']),
        nrcNumber: mapValueOfType<String>(json, r'nrc_number'),
        dateOfBirth: mapDateTime(json, r'date_of_birth', r''),
        address: mapValueOfType<String>(json, r'address'),
        phoneNumber: mapValueOfType<String>(json, r'phone_number'),
      );
    }
    return null;
  }

  static List<LecturersUpdateRequest> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <LecturersUpdateRequest>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = LecturersUpdateRequest.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, LecturersUpdateRequest> mapFromJson(dynamic json) {
    final map = <String, LecturersUpdateRequest>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = LecturersUpdateRequest.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of LecturersUpdateRequest-objects as value to a dart map
  static Map<String, List<LecturersUpdateRequest>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<LecturersUpdateRequest>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = LecturersUpdateRequest.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}


class LecturersUpdateRequestTitleEnum {
  /// Instantiate a new enum with the provided [value].
  const LecturersUpdateRequestTitleEnum._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const mr = LecturersUpdateRequestTitleEnum._(r'Mr');
  static const ms = LecturersUpdateRequestTitleEnum._(r'Ms');
  static const mrs = LecturersUpdateRequestTitleEnum._(r'Mrs');
  static const dr = LecturersUpdateRequestTitleEnum._(r'Dr');
  static const prof = LecturersUpdateRequestTitleEnum._(r'Prof');

  /// List of all possible values in this [enum][LecturersUpdateRequestTitleEnum].
  static const values = <LecturersUpdateRequestTitleEnum>[
    mr,
    ms,
    mrs,
    dr,
    prof,
  ];

  static LecturersUpdateRequestTitleEnum? fromJson(dynamic value) => LecturersUpdateRequestTitleEnumTypeTransformer().decode(value);

  static List<LecturersUpdateRequestTitleEnum> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <LecturersUpdateRequestTitleEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = LecturersUpdateRequestTitleEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [LecturersUpdateRequestTitleEnum] to String,
/// and [decode] dynamic data back to [LecturersUpdateRequestTitleEnum].
class LecturersUpdateRequestTitleEnumTypeTransformer {
  factory LecturersUpdateRequestTitleEnumTypeTransformer() => _instance ??= const LecturersUpdateRequestTitleEnumTypeTransformer._();

  const LecturersUpdateRequestTitleEnumTypeTransformer._();

  String encode(LecturersUpdateRequestTitleEnum data) => data.value;

  /// Decodes a [dynamic value][data] to a LecturersUpdateRequestTitleEnum.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  LecturersUpdateRequestTitleEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'Mr': return LecturersUpdateRequestTitleEnum.mr;
        case r'Ms': return LecturersUpdateRequestTitleEnum.ms;
        case r'Mrs': return LecturersUpdateRequestTitleEnum.mrs;
        case r'Dr': return LecturersUpdateRequestTitleEnum.dr;
        case r'Prof': return LecturersUpdateRequestTitleEnum.prof;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [LecturersUpdateRequestTitleEnumTypeTransformer] instance.
  static LecturersUpdateRequestTitleEnumTypeTransformer? _instance;
}



class LecturersUpdateRequestGenderEnum {
  /// Instantiate a new enum with the provided [value].
  const LecturersUpdateRequestGenderEnum._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const M = LecturersUpdateRequestGenderEnum._(r'M');
  static const F = LecturersUpdateRequestGenderEnum._(r'F');

  /// List of all possible values in this [enum][LecturersUpdateRequestGenderEnum].
  static const values = <LecturersUpdateRequestGenderEnum>[
    M,
    F,
  ];

  static LecturersUpdateRequestGenderEnum? fromJson(dynamic value) => LecturersUpdateRequestGenderEnumTypeTransformer().decode(value);

  static List<LecturersUpdateRequestGenderEnum> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <LecturersUpdateRequestGenderEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = LecturersUpdateRequestGenderEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [LecturersUpdateRequestGenderEnum] to String,
/// and [decode] dynamic data back to [LecturersUpdateRequestGenderEnum].
class LecturersUpdateRequestGenderEnumTypeTransformer {
  factory LecturersUpdateRequestGenderEnumTypeTransformer() => _instance ??= const LecturersUpdateRequestGenderEnumTypeTransformer._();

  const LecturersUpdateRequestGenderEnumTypeTransformer._();

  String encode(LecturersUpdateRequestGenderEnum data) => data.value;

  /// Decodes a [dynamic value][data] to a LecturersUpdateRequestGenderEnum.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  LecturersUpdateRequestGenderEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'M': return LecturersUpdateRequestGenderEnum.M;
        case r'F': return LecturersUpdateRequestGenderEnum.F;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [LecturersUpdateRequestGenderEnumTypeTransformer] instance.
  static LecturersUpdateRequestGenderEnumTypeTransformer? _instance;
}


