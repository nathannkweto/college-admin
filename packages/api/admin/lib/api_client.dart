//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of admin_api;

class ApiClient {
  ApiClient({this.basePath = 'https://api.college.edu/api/v1/admin', this.authentication,});

  final String basePath;
  final Authentication? authentication;

  var _client = Client();
  final _defaultHeaderMap = <String, String>{};

  /// Returns the current HTTP [Client] instance to use in this class.
  ///
  /// The return value is guaranteed to never be null.
  Client get client => _client;

  /// Requests to use a new HTTP [Client] in this class.
  set client(Client newClient) {
    _client = newClient;
  }

  Map<String, String> get defaultHeaderMap => _defaultHeaderMap;

  void addDefaultHeader(String key, String value) {
     _defaultHeaderMap[key] = value;
  }

  // We don't use a Map<String, String> for queryParams.
  // If collectionFormat is 'multi', a key might appear multiple times.
  Future<Response> invokeAPI(
    String path,
    String method,
    List<QueryParam> queryParams,
    Object? body,
    Map<String, String> headerParams,
    Map<String, String> formParams,
    String? contentType,
  ) async {
    await authentication?.applyToParams(queryParams, headerParams);

    headerParams.addAll(_defaultHeaderMap);
    if (contentType != null) {
      headerParams['Content-Type'] = contentType;
    }

    final urlEncodedQueryParams = queryParams.map((param) => '$param');
    final queryString = urlEncodedQueryParams.isNotEmpty ? '?${urlEncodedQueryParams.join('&')}' : '';
    final uri = Uri.parse('$basePath$path$queryString');

    try {
      // Special case for uploading a single file which isn't a 'multipart/form-data'.
      if (
        body is MultipartFile && (contentType == null ||
        !contentType.toLowerCase().startsWith('multipart/form-data'))
      ) {
        final request = StreamedRequest(method, uri);
        request.headers.addAll(headerParams);
        request.contentLength = body.length;
        body.finalize().listen(
          request.sink.add,
          onDone: request.sink.close,
          // ignore: avoid_types_on_closure_parameters
          onError: (Object error, StackTrace trace) => request.sink.close(),
          cancelOnError: true,
        );
        final response = await _client.send(request);
        return Response.fromStream(response);
      }

      if (body is MultipartRequest) {
        final request = MultipartRequest(method, uri);
        request.fields.addAll(body.fields);
        request.files.addAll(body.files);
        request.headers.addAll(body.headers);
        request.headers.addAll(headerParams);
        final response = await _client.send(request);
        return Response.fromStream(response);
      }

      final msgBody = contentType == 'application/x-www-form-urlencoded'
        ? formParams
        : await serializeAsync(body);
      final nullableHeaderParams = headerParams.isEmpty ? null : headerParams;

      switch(method) {
        case 'POST': return await _client.post(uri, headers: nullableHeaderParams, body: msgBody,);
        case 'PUT': return await _client.put(uri, headers: nullableHeaderParams, body: msgBody,);
        case 'DELETE': return await _client.delete(uri, headers: nullableHeaderParams, body: msgBody,);
        case 'PATCH': return await _client.patch(uri, headers: nullableHeaderParams, body: msgBody,);
        case 'HEAD': return await _client.head(uri, headers: nullableHeaderParams,);
        case 'GET': return await _client.get(uri, headers: nullableHeaderParams,);
      }
    } on SocketException catch (error, trace) {
      throw ApiException.withInner(
        HttpStatus.badRequest,
        'Socket operation failed: $method $path',
        error,
        trace,
      );
    } on TlsException catch (error, trace) {
      throw ApiException.withInner(
        HttpStatus.badRequest,
        'TLS/SSL communication failed: $method $path',
        error,
        trace,
      );
    } on IOException catch (error, trace) {
      throw ApiException.withInner(
        HttpStatus.badRequest,
        'I/O operation failed: $method $path',
        error,
        trace,
      );
    } on ClientException catch (error, trace) {
      throw ApiException.withInner(
        HttpStatus.badRequest,
        'HTTP connection failed: $method $path',
        error,
        trace,
      );
    } on Exception catch (error, trace) {
      throw ApiException.withInner(
        HttpStatus.badRequest,
        'Exception occurred: $method $path',
        error,
        trace,
      );
    }

    throw ApiException(
      HttpStatus.badRequest,
      'Invalid HTTP operation: $method $path',
    );
  }

  Future<dynamic> deserializeAsync(String value, String targetType, {bool growable = false,}) async =>
    // ignore: deprecated_member_use_from_same_package
    deserialize(value, targetType, growable: growable);

  @Deprecated('Scheduled for removal in OpenAPI Generator 6.x. Use deserializeAsync() instead.')
  dynamic deserialize(String value, String targetType, {bool growable = false,}) {
    // Remove all spaces. Necessary for regular expressions as well.
    targetType = targetType.replaceAll(' ', ''); // ignore: parameter_assignments

    // If the expected target type is String, nothing to do...
    return targetType == 'String'
      ? value
      : fromJson(json.decode(value), targetType, growable: growable);
  }

  // ignore: deprecated_member_use_from_same_package
  Future<String> serializeAsync(Object? value) async => serialize(value);

  @Deprecated('Scheduled for removal in OpenAPI Generator 6.x. Use serializeAsync() instead.')
  String serialize(Object? value) => value == null ? '' : json.encode(value);

  /// Returns a native instance of an OpenAPI class matching the [specified type][targetType].
  static dynamic fromJson(dynamic value, String targetType, {bool growable = false,}) {
    try {
      switch (targetType) {
        case 'String':
          return value is String ? value : value.toString();
        case 'int':
          return value is int ? value : int.parse('$value');
        case 'double':
          return value is double ? value : double.parse('$value');
        case 'bool':
          if (value is bool) {
            return value;
          }
          final valueString = '$value'.toLowerCase();
          return valueString == 'true' || valueString == '1';
        case 'DateTime':
          return value is DateTime ? value : DateTime.tryParse(value);
        case 'Course':
          return Course.fromJson(value);
        case 'CourseResult':
          return CourseResult.fromJson(value);
        case 'CoursesGet200Response':
          return CoursesGet200Response.fromJson(value);
        case 'CoursesPostRequest':
          return CoursesPostRequest.fromJson(value);
        case 'DashboardFinance':
          return DashboardFinance.fromJson(value);
        case 'DashboardFinanceGet200Response':
          return DashboardFinanceGet200Response.fromJson(value);
        case 'DashboardMetrics':
          return DashboardMetrics.fromJson(value);
        case 'DashboardMetricsGet200Response':
          return DashboardMetricsGet200Response.fromJson(value);
        case 'Department':
          return Department.fromJson(value);
        case 'DepartmentsGet200Response':
          return DepartmentsGet200Response.fromJson(value);
        case 'DepartmentsPostRequest':
          return DepartmentsPostRequest.fromJson(value);
        case 'ExamPaper':
          return ExamPaper.fromJson(value);
        case 'ExamPaperRequest':
          return ExamPaperRequest.fromJson(value);
        case 'ExamSchedulesList200Response':
          return ExamSchedulesList200Response.fromJson(value);
        case 'ExamSeason':
          return ExamSeason.fromJson(value);
        case 'ExamSeasonsEnd200Response':
          return ExamSeasonsEnd200Response.fromJson(value);
        case 'ExamSeasonsList200Response':
          return ExamSeasonsList200Response.fromJson(value);
        case 'ExamSeasonsPost201Response':
          return ExamSeasonsPost201Response.fromJson(value);
        case 'ExamSeasonsPostRequest':
          return ExamSeasonsPostRequest.fromJson(value);
        case 'FinanceFee':
          return FinanceFee.fromJson(value);
        case 'FinanceFeesGet200Response':
          return FinanceFeesGet200Response.fromJson(value);
        case 'FinanceFeesPostRequest':
          return FinanceFeesPostRequest.fromJson(value);
        case 'FinanceTransaction':
          return FinanceTransaction.fromJson(value);
        case 'FinanceTransactionsGet200Response':
          return FinanceTransactionsGet200Response.fromJson(value);
        case 'FinanceTransactionsPostRequest':
          return FinanceTransactionsPostRequest.fromJson(value);
        case 'Lecturer':
          return Lecturer.fromJson(value);
        case 'LecturersGet200Response':
          return LecturersGet200Response.fromJson(value);
        case 'LecturersPostRequest':
          return LecturersPostRequest.fromJson(value);
        case 'LogisticsTimetableGet200Response':
          return LogisticsTimetableGet200Response.fromJson(value);
        case 'LogisticsTimetablePost201Response':
          return LogisticsTimetablePost201Response.fromJson(value);
        case 'LogisticsTimetablePostRequest':
          return LogisticsTimetablePostRequest.fromJson(value);
        case 'PaginationMeta':
          return PaginationMeta.fromJson(value);
        case 'Program':
          return Program.fromJson(value);
        case 'ProgramCourse':
          return ProgramCourse.fromJson(value);
        case 'ProgramCoursePivot':
          return ProgramCoursePivot.fromJson(value);
        case 'ProgramCoursePivotLecturer':
          return ProgramCoursePivotLecturer.fromJson(value);
        case 'ProgramResultsResponse':
          return ProgramResultsResponse.fromJson(value);
        case 'ProgramsCoursesGet200Response':
          return ProgramsCoursesGet200Response.fromJson(value);
        case 'ProgramsCoursesPostRequest':
          return ProgramsCoursesPostRequest.fromJson(value);
        case 'ProgramsGet200Response':
          return ProgramsGet200Response.fromJson(value);
        case 'ProgramsPostRequest':
          return ProgramsPostRequest.fromJson(value);
        case 'Qualification':
          return Qualification.fromJson(value);
        case 'QualificationsGet200Response':
          return QualificationsGet200Response.fromJson(value);
        case 'ResultsPublishPost200Response':
          return ResultsPublishPost200Response.fromJson(value);
        case 'ResultsPublishPostRequest':
          return ResultsPublishPostRequest.fromJson(value);
        case 'Semester':
          return Semester.fromJson(value);
        case 'SemesterResponse':
          return SemesterResponse.fromJson(value);
        case 'SemestersGet200Response':
          return SemestersGet200Response.fromJson(value);
        case 'SemestersPostRequest':
          return SemestersPostRequest.fromJson(value);
        case 'Student':
          return Student.fromJson(value);
        case 'StudentResultSummary':
          return StudentResultSummary.fromJson(value);
        case 'StudentTranscript':
          return StudentTranscript.fromJson(value);
        case 'StudentsGet200Response':
          return StudentsGet200Response.fromJson(value);
        case 'StudentsPostRequest':
          return StudentsPostRequest.fromJson(value);
        case 'StudentsPromotePostRequest':
          return StudentsPromotePostRequest.fromJson(value);
        case 'StudentsPromotionPreview200Response':
          return StudentsPromotionPreview200Response.fromJson(value);
        case 'TimetableEntry':
          return TimetableEntry.fromJson(value);
        default:
          dynamic match;
          if (value is List && (match = _regList.firstMatch(targetType)?.group(1)) != null) {
            return value
              .map<dynamic>((dynamic v) => fromJson(v, match, growable: growable,))
              .toList(growable: growable);
          }
          if (value is Set && (match = _regSet.firstMatch(targetType)?.group(1)) != null) {
            return value
              .map<dynamic>((dynamic v) => fromJson(v, match, growable: growable,))
              .toSet();
          }
          if (value is Map && (match = _regMap.firstMatch(targetType)?.group(1)) != null) {
            return Map<String, dynamic>.fromIterables(
              value.keys.cast<String>(),
              value.values.map<dynamic>((dynamic v) => fromJson(v, match, growable: growable,)),
            );
          }
      }
    } on Exception catch (error, trace) {
      throw ApiException.withInner(HttpStatus.internalServerError, 'Exception during deserialization.', error, trace,);
    }
    throw ApiException(HttpStatus.internalServerError, 'Could not find a suitable class for deserialization',);
  }
}

/// Primarily intended for use in an isolate.
class DeserializationMessage {
  const DeserializationMessage({
    required this.json,
    required this.targetType,
    this.growable = false,
  });

  /// The JSON value to deserialize.
  final String json;

  /// Target type to deserialize to.
  final String targetType;

  /// Whether to make deserialized lists or maps growable.
  final bool growable;
}

/// Primarily intended for use in an isolate.
Future<dynamic> decodeAsync(DeserializationMessage message) async {
  // Remove all spaces. Necessary for regular expressions as well.
  final targetType = message.targetType.replaceAll(' ', '');

  // If the expected target type is String, nothing to do...
  return targetType == 'String'
    ? message.json
    : json.decode(message.json);
}

/// Primarily intended for use in an isolate.
Future<dynamic> deserializeAsync(DeserializationMessage message) async {
  // Remove all spaces. Necessary for regular expressions as well.
  final targetType = message.targetType.replaceAll(' ', '');

  // If the expected target type is String, nothing to do...
  return targetType == 'String'
    ? message.json
    : ApiClient.fromJson(
        json.decode(message.json),
        targetType,
        growable: message.growable,
      );
}

/// Primarily intended for use in an isolate.
Future<String> serializeAsync(Object? value) async => value == null ? '' : json.encode(value);
