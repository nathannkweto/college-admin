//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of admin_api;

class Student {
  /// Returns a new [Student] instance.
  Student({
    this.publicId,
    this.studentId,
    this.firstName,
    this.lastName,
    this.email,
    this.enrollmentDate,
    this.nationalId,
    this.gender,
    this.program,
    this.currentSemesterSequence,
    this.status,
    this.dob,
    this.address,
    this.phone,
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
  String? studentId;

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
  DateTime? enrollmentDate;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? nationalId;

  StudentGenderEnum? gender;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  Program? program;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? currentSemesterSequence;

  StudentStatusEnum? status;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  DateTime? dob;

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
  String? phone;

  @override
  bool operator ==(Object other) => identical(this, other) || other is Student &&
    other.publicId == publicId &&
    other.studentId == studentId &&
    other.firstName == firstName &&
    other.lastName == lastName &&
    other.email == email &&
    other.enrollmentDate == enrollmentDate &&
    other.nationalId == nationalId &&
    other.gender == gender &&
    other.program == program &&
    other.currentSemesterSequence == currentSemesterSequence &&
    other.status == status &&
    other.dob == dob &&
    other.address == address &&
    other.phone == phone;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (publicId == null ? 0 : publicId!.hashCode) +
    (studentId == null ? 0 : studentId!.hashCode) +
    (firstName == null ? 0 : firstName!.hashCode) +
    (lastName == null ? 0 : lastName!.hashCode) +
    (email == null ? 0 : email!.hashCode) +
    (enrollmentDate == null ? 0 : enrollmentDate!.hashCode) +
    (nationalId == null ? 0 : nationalId!.hashCode) +
    (gender == null ? 0 : gender!.hashCode) +
    (program == null ? 0 : program!.hashCode) +
    (currentSemesterSequence == null ? 0 : currentSemesterSequence!.hashCode) +
    (status == null ? 0 : status!.hashCode) +
    (dob == null ? 0 : dob!.hashCode) +
    (address == null ? 0 : address!.hashCode) +
    (phone == null ? 0 : phone!.hashCode);

  @override
  String toString() => 'Student[publicId=$publicId, studentId=$studentId, firstName=$firstName, lastName=$lastName, email=$email, enrollmentDate=$enrollmentDate, nationalId=$nationalId, gender=$gender, program=$program, currentSemesterSequence=$currentSemesterSequence, status=$status, dob=$dob, address=$address, phone=$phone]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.publicId != null) {
      json[r'public_id'] = this.publicId;
    } else {
      json[r'public_id'] = null;
    }
    if (this.studentId != null) {
      json[r'student_id'] = this.studentId;
    } else {
      json[r'student_id'] = null;
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
    if (this.enrollmentDate != null) {
      json[r'enrollment_date'] = _dateFormatter.format(this.enrollmentDate!.toUtc());
    } else {
      json[r'enrollment_date'] = null;
    }
    if (this.nationalId != null) {
      json[r'national_id'] = this.nationalId;
    } else {
      json[r'national_id'] = null;
    }
    if (this.gender != null) {
      json[r'gender'] = this.gender;
    } else {
      json[r'gender'] = null;
    }
    if (this.program != null) {
      json[r'program'] = this.program;
    } else {
      json[r'program'] = null;
    }
    if (this.currentSemesterSequence != null) {
      json[r'current_semester_sequence'] = this.currentSemesterSequence;
    } else {
      json[r'current_semester_sequence'] = null;
    }
    if (this.status != null) {
      json[r'status'] = this.status;
    } else {
      json[r'status'] = null;
    }
    if (this.dob != null) {
      json[r'dob'] = _dateFormatter.format(this.dob!.toUtc());
    } else {
      json[r'dob'] = null;
    }
    if (this.address != null) {
      json[r'address'] = this.address;
    } else {
      json[r'address'] = null;
    }
    if (this.phone != null) {
      json[r'phone'] = this.phone;
    } else {
      json[r'phone'] = null;
    }
    return json;
  }

  /// Returns a new [Student] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static Student? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "Student[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "Student[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return Student(
        publicId: mapValueOfType<String>(json, r'public_id'),
        studentId: mapValueOfType<String>(json, r'student_id'),
        firstName: mapValueOfType<String>(json, r'first_name'),
        lastName: mapValueOfType<String>(json, r'last_name'),
        email: mapValueOfType<String>(json, r'email'),
        enrollmentDate: mapDateTime(json, r'enrollment_date', r''),
        nationalId: mapValueOfType<String>(json, r'national_id'),
        gender: StudentGenderEnum.fromJson(json[r'gender']),
        program: Program.fromJson(json[r'program']),
        currentSemesterSequence: mapValueOfType<int>(json, r'current_semester_sequence'),
        status: StudentStatusEnum.fromJson(json[r'status']),
        dob: mapDateTime(json, r'dob', r''),
        address: mapValueOfType<String>(json, r'address'),
        phone: mapValueOfType<String>(json, r'phone'),
      );
    }
    return null;
  }

  static List<Student> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <Student>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = Student.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, Student> mapFromJson(dynamic json) {
    final map = <String, Student>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = Student.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of Student-objects as value to a dart map
  static Map<String, List<Student>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<Student>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = Student.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}


class StudentGenderEnum {
  /// Instantiate a new enum with the provided [value].
  const StudentGenderEnum._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const M = StudentGenderEnum._(r'M');
  static const F = StudentGenderEnum._(r'F');

  /// List of all possible values in this [enum][StudentGenderEnum].
  static const values = <StudentGenderEnum>[
    M,
    F,
  ];

  static StudentGenderEnum? fromJson(dynamic value) => StudentGenderEnumTypeTransformer().decode(value);

  static List<StudentGenderEnum> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <StudentGenderEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = StudentGenderEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [StudentGenderEnum] to String,
/// and [decode] dynamic data back to [StudentGenderEnum].
class StudentGenderEnumTypeTransformer {
  factory StudentGenderEnumTypeTransformer() => _instance ??= const StudentGenderEnumTypeTransformer._();

  const StudentGenderEnumTypeTransformer._();

  String encode(StudentGenderEnum data) => data.value;

  /// Decodes a [dynamic value][data] to a StudentGenderEnum.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  StudentGenderEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'M': return StudentGenderEnum.M;
        case r'F': return StudentGenderEnum.F;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [StudentGenderEnumTypeTransformer] instance.
  static StudentGenderEnumTypeTransformer? _instance;
}



class StudentStatusEnum {
  /// Instantiate a new enum with the provided [value].
  const StudentStatusEnum._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const active = StudentStatusEnum._(r'active');
  static const inactive = StudentStatusEnum._(r'inactive');
  static const graduated = StudentStatusEnum._(r'graduated');
  static const suspended = StudentStatusEnum._(r'suspended');

  /// List of all possible values in this [enum][StudentStatusEnum].
  static const values = <StudentStatusEnum>[
    active,
    inactive,
    graduated,
    suspended,
  ];

  static StudentStatusEnum? fromJson(dynamic value) => StudentStatusEnumTypeTransformer().decode(value);

  static List<StudentStatusEnum> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <StudentStatusEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = StudentStatusEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [StudentStatusEnum] to String,
/// and [decode] dynamic data back to [StudentStatusEnum].
class StudentStatusEnumTypeTransformer {
  factory StudentStatusEnumTypeTransformer() => _instance ??= const StudentStatusEnumTypeTransformer._();

  const StudentStatusEnumTypeTransformer._();

  String encode(StudentStatusEnum data) => data.value;

  /// Decodes a [dynamic value][data] to a StudentStatusEnum.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  StudentStatusEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'active': return StudentStatusEnum.active;
        case r'inactive': return StudentStatusEnum.inactive;
        case r'graduated': return StudentStatusEnum.graduated;
        case r'suspended': return StudentStatusEnum.suspended;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [StudentStatusEnumTypeTransformer] instance.
  static StudentStatusEnumTypeTransformer? _instance;
}


