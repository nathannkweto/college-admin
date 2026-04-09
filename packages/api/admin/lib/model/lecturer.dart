//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of admin_api;

class Lecturer {
  /// Returns a new [Lecturer] instance.
  Lecturer({
    this.publicId,
    this.lecturerId,
    this.firstName,
    this.lastName,
    this.email,
    this.title,
    this.gender,
    this.department,
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
  String? publicId;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? lecturerId;

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

  LecturerTitleEnum? title;

  LecturerGenderEnum? gender;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  Department? department;

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
  bool operator ==(Object other) => identical(this, other) || other is Lecturer &&
    other.publicId == publicId &&
    other.lecturerId == lecturerId &&
    other.firstName == firstName &&
    other.lastName == lastName &&
    other.email == email &&
    other.title == title &&
    other.gender == gender &&
    other.department == department &&
    other.nrcNumber == nrcNumber &&
    other.dateOfBirth == dateOfBirth &&
    other.address == address &&
    other.phoneNumber == phoneNumber;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (publicId == null ? 0 : publicId!.hashCode) +
    (lecturerId == null ? 0 : lecturerId!.hashCode) +
    (firstName == null ? 0 : firstName!.hashCode) +
    (lastName == null ? 0 : lastName!.hashCode) +
    (email == null ? 0 : email!.hashCode) +
    (title == null ? 0 : title!.hashCode) +
    (gender == null ? 0 : gender!.hashCode) +
    (department == null ? 0 : department!.hashCode) +
    (nrcNumber == null ? 0 : nrcNumber!.hashCode) +
    (dateOfBirth == null ? 0 : dateOfBirth!.hashCode) +
    (address == null ? 0 : address!.hashCode) +
    (phoneNumber == null ? 0 : phoneNumber!.hashCode);

  @override
  String toString() => 'Lecturer[publicId=$publicId, lecturerId=$lecturerId, firstName=$firstName, lastName=$lastName, email=$email, title=$title, gender=$gender, department=$department, nrcNumber=$nrcNumber, dateOfBirth=$dateOfBirth, address=$address, phoneNumber=$phoneNumber]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.publicId != null) {
      json[r'public_id'] = this.publicId;
    } else {
      json[r'public_id'] = null;
    }
    if (this.lecturerId != null) {
      json[r'lecturer_id'] = this.lecturerId;
    } else {
      json[r'lecturer_id'] = null;
    }
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
    if (this.department != null) {
      json[r'department'] = this.department;
    } else {
      json[r'department'] = null;
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

  /// Returns a new [Lecturer] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static Lecturer? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "Lecturer[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "Lecturer[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return Lecturer(
        publicId: mapValueOfType<String>(json, r'public_id'),
        lecturerId: mapValueOfType<String>(json, r'lecturer_id'),
        firstName: mapValueOfType<String>(json, r'first_name'),
        lastName: mapValueOfType<String>(json, r'last_name'),
        email: mapValueOfType<String>(json, r'email'),
        title: LecturerTitleEnum.fromJson(json[r'title']),
        gender: LecturerGenderEnum.fromJson(json[r'gender']),
        department: Department.fromJson(json[r'department']),
        nrcNumber: mapValueOfType<String>(json, r'nrc_number'),
        dateOfBirth: mapDateTime(json, r'date_of_birth', r''),
        address: mapValueOfType<String>(json, r'address'),
        phoneNumber: mapValueOfType<String>(json, r'phone_number'),
      );
    }
    return null;
  }

  static List<Lecturer> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <Lecturer>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = Lecturer.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, Lecturer> mapFromJson(dynamic json) {
    final map = <String, Lecturer>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = Lecturer.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of Lecturer-objects as value to a dart map
  static Map<String, List<Lecturer>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<Lecturer>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = Lecturer.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}


class LecturerTitleEnum {
  /// Instantiate a new enum with the provided [value].
  const LecturerTitleEnum._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const mr = LecturerTitleEnum._(r'Mr');
  static const ms = LecturerTitleEnum._(r'Ms');
  static const mrs = LecturerTitleEnum._(r'Mrs');
  static const dr = LecturerTitleEnum._(r'Dr');
  static const prof = LecturerTitleEnum._(r'Prof');

  /// List of all possible values in this [enum][LecturerTitleEnum].
  static const values = <LecturerTitleEnum>[
    mr,
    ms,
    mrs,
    dr,
    prof,
  ];

  static LecturerTitleEnum? fromJson(dynamic value) => LecturerTitleEnumTypeTransformer().decode(value);

  static List<LecturerTitleEnum> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <LecturerTitleEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = LecturerTitleEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [LecturerTitleEnum] to String,
/// and [decode] dynamic data back to [LecturerTitleEnum].
class LecturerTitleEnumTypeTransformer {
  factory LecturerTitleEnumTypeTransformer() => _instance ??= const LecturerTitleEnumTypeTransformer._();

  const LecturerTitleEnumTypeTransformer._();

  String encode(LecturerTitleEnum data) => data.value;

  /// Decodes a [dynamic value][data] to a LecturerTitleEnum.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  LecturerTitleEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'Mr': return LecturerTitleEnum.mr;
        case r'Ms': return LecturerTitleEnum.ms;
        case r'Mrs': return LecturerTitleEnum.mrs;
        case r'Dr': return LecturerTitleEnum.dr;
        case r'Prof': return LecturerTitleEnum.prof;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [LecturerTitleEnumTypeTransformer] instance.
  static LecturerTitleEnumTypeTransformer? _instance;
}



class LecturerGenderEnum {
  /// Instantiate a new enum with the provided [value].
  const LecturerGenderEnum._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const M = LecturerGenderEnum._(r'M');
  static const F = LecturerGenderEnum._(r'F');

  /// List of all possible values in this [enum][LecturerGenderEnum].
  static const values = <LecturerGenderEnum>[
    M,
    F,
  ];

  static LecturerGenderEnum? fromJson(dynamic value) => LecturerGenderEnumTypeTransformer().decode(value);

  static List<LecturerGenderEnum> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <LecturerGenderEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = LecturerGenderEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [LecturerGenderEnum] to String,
/// and [decode] dynamic data back to [LecturerGenderEnum].
class LecturerGenderEnumTypeTransformer {
  factory LecturerGenderEnumTypeTransformer() => _instance ??= const LecturerGenderEnumTypeTransformer._();

  const LecturerGenderEnumTypeTransformer._();

  String encode(LecturerGenderEnum data) => data.value;

  /// Decodes a [dynamic value][data] to a LecturerGenderEnum.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  LecturerGenderEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'M': return LecturerGenderEnum.M;
        case r'F': return LecturerGenderEnum.F;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [LecturerGenderEnumTypeTransformer] instance.
  static LecturerGenderEnumTypeTransformer? _instance;
}


