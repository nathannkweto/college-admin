//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of student_api;


class DefaultApi {
  DefaultApi([ApiClient? apiClient]) : apiClient = apiClient ?? defaultApiClient;

  final ApiClient apiClient;

  /// Performs an HTTP 'GET /courses/current' operation and returns the [Response].
  Future<Response> studentCurrentCoursesGetWithHttpInfo() async {
    // ignore: prefer_const_declarations
    final path = r'/courses/current';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>[];


    return apiClient.invokeAPI(
      path,
      'GET',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  Future<StudentCurrentCoursesGet200Response?> studentCurrentCoursesGet() async {
    final response = await studentCurrentCoursesGetWithHttpInfo();
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'StudentCurrentCoursesGet200Response',) as StudentCurrentCoursesGet200Response;
    
    }
    return null;
  }

  /// Performs an HTTP 'GET /curriculum' operation and returns the [Response].
  Future<Response> studentCurriculumGetWithHttpInfo() async {
    // ignore: prefer_const_declarations
    final path = r'/curriculum';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>[];


    return apiClient.invokeAPI(
      path,
      'GET',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  Future<StudentCurriculumGet200Response?> studentCurriculumGet() async {
    final response = await studentCurriculumGetWithHttpInfo();
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'StudentCurriculumGet200Response',) as StudentCurriculumGet200Response;
    
    }
    return null;
  }

  /// Performs an HTTP 'GET /exams/upcoming' operation and returns the [Response].
  Future<Response> studentExamsGetWithHttpInfo() async {
    // ignore: prefer_const_declarations
    final path = r'/exams/upcoming';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>[];


    return apiClient.invokeAPI(
      path,
      'GET',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  Future<StudentExamsGet200Response?> studentExamsGet() async {
    final response = await studentExamsGetWithHttpInfo();
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'StudentExamsGet200Response',) as StudentExamsGet200Response;
    
    }
    return null;
  }

  /// Performs an HTTP 'GET /finance' operation and returns the [Response].
  Future<Response> studentFinanceGetWithHttpInfo() async {
    // ignore: prefer_const_declarations
    final path = r'/finance';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>[];


    return apiClient.invokeAPI(
      path,
      'GET',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  Future<StudentFinanceGet200Response?> studentFinanceGet() async {
    final response = await studentFinanceGetWithHttpInfo();
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'StudentFinanceGet200Response',) as StudentFinanceGet200Response;
    
    }
    return null;
  }

  /// Performs an HTTP 'GET /profile' operation and returns the [Response].
  Future<Response> studentProfileGetWithHttpInfo() async {
    // ignore: prefer_const_declarations
    final path = r'/profile';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>[];


    return apiClient.invokeAPI(
      path,
      'GET',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  Future<StudentProfileGet200Response?> studentProfileGet() async {
    final response = await studentProfileGetWithHttpInfo();
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'StudentProfileGet200Response',) as StudentProfileGet200Response;
    
    }
    return null;
  }

  /// Get Student Academic History
  ///
  /// Returns a list of all enrolled courses grouped by semester sequence (e.g., Year 1 - Semester 1). Scores are masked if results are not yet published.
  ///
  /// Note: This method returns the HTTP [Response].
  Future<Response> studentResultsGetWithHttpInfo() async {
    // ignore: prefer_const_declarations
    final path = r'/results';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>[];


    return apiClient.invokeAPI(
      path,
      'GET',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Get Student Academic History
  ///
  /// Returns a list of all enrolled courses grouped by semester sequence (e.g., Year 1 - Semester 1). Scores are masked if results are not yet published.
  Future<StudentResultsGet200Response?> studentResultsGet() async {
    final response = await studentResultsGetWithHttpInfo();
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'StudentResultsGet200Response',) as StudentResultsGet200Response;
    
    }
    return null;
  }

  /// Get Student Weekly Timetable
  ///
  /// Returns the full weekly schedule grouped by day for the student's current program and semester.
  ///
  /// Note: This method returns the HTTP [Response].
  Future<Response> studentScheduleGetWithHttpInfo() async {
    // ignore: prefer_const_declarations
    final path = r'/schedule';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>[];


    return apiClient.invokeAPI(
      path,
      'GET',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Get Student Weekly Timetable
  ///
  /// Returns the full weekly schedule grouped by day for the student's current program and semester.
  Future<StudentScheduleGet200Response?> studentScheduleGet() async {
    final response = await studentScheduleGetWithHttpInfo();
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'StudentScheduleGet200Response',) as StudentScheduleGet200Response;
    
    }
    return null;
  }
}
