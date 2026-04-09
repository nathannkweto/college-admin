//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

library student_api;

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:collection/collection.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

part 'api_client.dart';
part 'api_helper.dart';
part 'api_exception.dart';
part 'auth/authentication.dart';
part 'auth/api_key_auth.dart';
part 'auth/oauth.dart';
part 'auth/http_basic_auth.dart';
part 'auth/http_bearer_auth.dart';

part 'api/default_api.dart';

part 'model/class_session.dart';
part 'model/course_compact.dart';
part 'model/course_result.dart';
part 'model/curriculum_progress.dart';
part 'model/curriculum_semester.dart';
part 'model/curriculum_semester_courses_inner.dart';
part 'model/daily_schedule.dart';
part 'model/exam_event.dart';
part 'model/finance_transaction.dart';
part 'model/semester_group.dart';
part 'model/student_current_courses_get200_response.dart';
part 'model/student_curriculum_get200_response.dart';
part 'model/student_exams_get200_response.dart';
part 'model/student_finance.dart';
part 'model/student_finance_get200_response.dart';
part 'model/student_profile.dart';
part 'model/student_profile_get200_response.dart';
part 'model/student_results_get200_response.dart';
part 'model/student_schedule_get200_response.dart';
part 'model/transcript.dart';


/// An [ApiClient] instance that uses the default values obtained from
/// the OpenAPI specification file.
var defaultApiClient = ApiClient();

const _delimiters = {'csv': ',', 'ssv': ' ', 'tsv': '\t', 'pipes': '|'};
const _dateEpochMarker = 'epoch';
const _deepEquality = DeepCollectionEquality();
final _dateFormatter = DateFormat('yyyy-MM-dd');
final _regList = RegExp(r'^List<(.*)>$');
final _regSet = RegExp(r'^Set<(.*)>$');
final _regMap = RegExp(r'^Map<String,(.*)>$');

bool _isEpochMarker(String? pattern) => pattern == _dateEpochMarker || pattern == '/$_dateEpochMarker/';
