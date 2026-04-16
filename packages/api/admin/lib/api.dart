//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

library admin_api;

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

part 'api/academics_api.dart';
part 'api/dashboard_api.dart';
part 'api/exams_api.dart';
part 'api/finance_api.dart';
part 'api/lecturers_api.dart';
part 'api/results_api.dart';
part 'api/students_api.dart';
part 'api/timetables_api.dart';

part 'model/course.dart';
part 'model/course_result.dart';
part 'model/courses_get200_response.dart';
part 'model/courses_post_request.dart';
part 'model/dashboard_finance.dart';
part 'model/dashboard_finance_get200_response.dart';
part 'model/dashboard_metrics.dart';
part 'model/dashboard_metrics_get200_response.dart';
part 'model/department.dart';
part 'model/departments_get200_response.dart';
part 'model/departments_post_request.dart';
part 'model/exam_paper.dart';
part 'model/exam_paper_request.dart';
part 'model/exam_schedules_list200_response.dart';
part 'model/exam_season.dart';
part 'model/exam_seasons_end200_response.dart';
part 'model/exam_seasons_list200_response.dart';
part 'model/exam_seasons_post201_response.dart';
part 'model/exam_seasons_post_request.dart';
part 'model/finance_fee.dart';
part 'model/finance_fees_get200_response.dart';
part 'model/finance_fees_post_request.dart';
part 'model/finance_transaction.dart';
part 'model/finance_transactions_get200_response.dart';
part 'model/finance_transactions_post_request.dart';
part 'model/lecturer.dart';
part 'model/lecturers_get200_response.dart';
part 'model/lecturers_post_request.dart';
part 'model/logistics_timetable_get200_response.dart';
part 'model/logistics_timetable_post201_response.dart';
part 'model/logistics_timetable_post_request.dart';
part 'model/pagination_meta.dart';
part 'model/program.dart';
part 'model/program_course.dart';
part 'model/program_course_pivot.dart';
part 'model/program_course_pivot_lecturer.dart';
part 'model/program_results_response.dart';
part 'model/programs_courses_get200_response.dart';
part 'model/programs_courses_post_request.dart';
part 'model/programs_get200_response.dart';
part 'model/programs_post_request.dart';
part 'model/qualification.dart';
part 'model/qualifications_get200_response.dart';
part 'model/results_publish_post200_response.dart';
part 'model/results_publish_post_request.dart';
part 'model/semester.dart';
part 'model/semester_response.dart';
part 'model/semesters_get200_response.dart';
part 'model/semesters_post_request.dart';
part 'model/student.dart';
part 'model/student_result_summary.dart';
part 'model/student_transcript.dart';
part 'model/students_get200_response.dart';
part 'model/students_post_request.dart';
part 'model/students_promote_post_request.dart';
part 'model/students_promotion_preview200_response.dart';
part 'model/timetable_entry.dart';


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
