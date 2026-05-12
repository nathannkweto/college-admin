//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class StudentsUpdateRequest {
  /// Returns a new [StudentsUpdateRequest] instance.
  StudentsUpdateRequest({
    this.firstName,
    this.lastName,
    this.email,
    this.programCode,
    this.gender,
    this.enrollmentDate,
    this.nrcNumber,
    this.dateOfBirth,
    this.address,
    this.phoneNumber,
    this.status,
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
  String? programCode;

  StudentsUpdateRequestGenderEnum? gender;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  DateTime? enrollmentDate;

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

  StudentsUpdateRequestStatusEnum? status;

  @override
  bool operator ==(Object other) => identical(this, other) || other is StudentsUpdateRequest &&
    other.firstName == firstName &&
    other.lastName == lastName &&
    other.email == email &&
    other.programCode == programCode &&
    other.gender == gender &&
    other.enrollmentDate == enrollmentDate &&
    other.nrcNumber == nrcNumber &&
    other.dateOfBirth == dateOfBirth &&
    other.address == address &&
    other.phoneNumber == phoneNumber &&
    other.status == status;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (firstName == null ? 0 : firstName!.hashCode) +
    (lastName == null ? 0 : lastName!.hashCode) +
    (email == null ? 0 : email!.hashCode) +
    (programCode == null ? 0 : programCode!.hashCode) +
    (gender == null ? 0 : gender!.hashCode) +
    (enrollmentDate == null ? 0 : enrollmentDate!.hashCode) +
    (nrcNumber == null ? 0 : nrcNumber!.hashCode) +
    (dateOfBirth == null ? 0 : dateOfBirth!.hashCode) +
    (address == null ? 0 : address!.hashCode) +
    (phoneNumber == null ? 0 : phoneNumber!.hashCode) +
    (status == null ? 0 : status!.hashCode);

  @override
  String toString() => 'StudentsUpdateRequest[firstName=$firstName, lastName=$lastName, email=$email, programCode=$programCode, gender=$gender, enrollmentDate=$enrollmentDate, nrcNumber=$nrcNumber, dateOfBirth=$dateOfBirth, address=$address, phoneNumber=$phoneNumber, status=$status]';

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
    if (this.programCode != null) {
      json[r'program_code'] = this.programCode;
    } else {
      json[r'program_code'] = null;
    }
    if (this.gender != null) {
      json[r'gender'] = this.gender;
    } else {
      json[r'gender'] = null;
    }
    if (this.enrollmentDate != null) {
      json[r'enrollment_date'] = _dateFormatter.format(this.enrollmentDate!.toUtc());
    } else {
      json[r'enrollment_date'] = null;
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
    if (this.status != null) {
      json[r'status'] = this.status;
    } else {
      json[r'status'] = null;
    }
    return json;
  }

  /// Returns a new [StudentsUpdateRequest] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static StudentsUpdateRequest? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "StudentsUpdateRequest[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "StudentsUpdateRequest[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return StudentsUpdateRequest(
        firstName: mapValueOfType<String>(json, r'first_name'),
        lastName: mapValueOfType<String>(json, r'last_name'),
        email: mapValueOfType<String>(json, r'email'),
        programCode: mapValueOfType<String>(json, r'program_code'),
        gender: StudentsUpdateRequestGenderEnum.fromJson(json[r'gender']),
        enrollmentDate: mapDateTime(json, r'enrollment_date', r''),
        nrcNumber: mapValueOfType<String>(json, r'nrc_number'),
        dateOfBirth: mapDateTime(json, r'date_of_birth', r''),
        address: mapValueOfType<String>(json, r'address'),
        phoneNumber: mapValueOfType<String>(json, r'phone_number'),
        status: StudentsUpdateRequestStatusEnum.fromJson(json[r'status']),
      );
    }
    return null;
  }

  static List<StudentsUpdateRequest> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <StudentsUpdateRequest>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = StudentsUpdateRequest.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, StudentsUpdateRequest> mapFromJson(dynamic json) {
    final map = <String, StudentsUpdateRequest>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = StudentsUpdateRequest.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of StudentsUpdateRequest-objects as value to a dart map
  static Map<String, List<StudentsUpdateRequest>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<StudentsUpdateRequest>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = StudentsUpdateRequest.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}


class StudentsUpdateRequestGenderEnum {
  /// Instantiate a new enum with the provided [value].
  const StudentsUpdateRequestGenderEnum._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const M = StudentsUpdateRequestGenderEnum._(r'M');
  static const F = StudentsUpdateRequestGenderEnum._(r'F');

  /// List of all possible values in this [enum][StudentsUpdateRequestGenderEnum].
  static const values = <StudentsUpdateRequestGenderEnum>[
    M,
    F,
  ];

  static StudentsUpdateRequestGenderEnum? fromJson(dynamic value) => StudentsUpdateRequestGenderEnumTypeTransformer().decode(value);

  static List<StudentsUpdateRequestGenderEnum> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <StudentsUpdateRequestGenderEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = StudentsUpdateRequestGenderEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [StudentsUpdateRequestGenderEnum] to String,
/// and [decode] dynamic data back to [StudentsUpdateRequestGenderEnum].
class StudentsUpdateRequestGenderEnumTypeTransformer {
  factory StudentsUpdateRequestGenderEnumTypeTransformer() => _instance ??= const StudentsUpdateRequestGenderEnumTypeTransformer._();

  const StudentsUpdateRequestGenderEnumTypeTransformer._();

  String encode(StudentsUpdateRequestGenderEnum data) => data.value;

  /// Decodes a [dynamic value][data] to a StudentsUpdateRequestGenderEnum.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  StudentsUpdateRequestGenderEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'M': return StudentsUpdateRequestGenderEnum.M;
        case r'F': return StudentsUpdateRequestGenderEnum.F;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [StudentsUpdateRequestGenderEnumTypeTransformer] instance.
  static StudentsUpdateRequestGenderEnumTypeTransformer? _instance;
}



class StudentsUpdateRequestStatusEnum {
  /// Instantiate a new enum with the provided [value].
  const StudentsUpdateRequestStatusEnum._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const active = StudentsUpdateRequestStatusEnum._(r'active');
  static const inactive = StudentsUpdateRequestStatusEnum._(r'inactive');
  static const graduated = StudentsUpdateRequestStatusEnum._(r'graduated');
  static const suspended = StudentsUpdateRequestStatusEnum._(r'suspended');

  /// List of all possible values in this [enum][StudentsUpdateRequestStatusEnum].
  static const values = <StudentsUpdateRequestStatusEnum>[
    active,
    inactive,
    graduated,
    suspended,
  ];

  static StudentsUpdateRequestStatusEnum? fromJson(dynamic value) => StudentsUpdateRequestStatusEnumTypeTransformer().decode(value);

  static List<StudentsUpdateRequestStatusEnum> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <StudentsUpdateRequestStatusEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = StudentsUpdateRequestStatusEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [StudentsUpdateRequestStatusEnum] to String,
/// and [decode] dynamic data back to [StudentsUpdateRequestStatusEnum].
class StudentsUpdateRequestStatusEnumTypeTransformer {
  factory StudentsUpdateRequestStatusEnumTypeTransformer() => _instance ??= const StudentsUpdateRequestStatusEnumTypeTransformer._();

  const StudentsUpdateRequestStatusEnumTypeTransformer._();

  String encode(StudentsUpdateRequestStatusEnum data) => data.value;

  /// Decodes a [dynamic value][data] to a StudentsUpdateRequestStatusEnum.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  StudentsUpdateRequestStatusEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'active': return StudentsUpdateRequestStatusEnum.active;
        case r'inactive': return StudentsUpdateRequestStatusEnum.inactive;
        case r'graduated': return StudentsUpdateRequestStatusEnum.graduated;
        case r'suspended': return StudentsUpdateRequestStatusEnum.suspended;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [StudentsUpdateRequestStatusEnumTypeTransformer] instance.
  static StudentsUpdateRequestStatusEnumTypeTransformer? _instance;
}


