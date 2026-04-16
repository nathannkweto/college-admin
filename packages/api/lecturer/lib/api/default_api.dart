//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of lecturer_api;


class DefaultApi {
  DefaultApi([ApiClient? apiClient]) : apiClient = apiClient ?? defaultApiClient;

  final ApiClient apiClient;

  /// Get Course Details & Student List
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] coursePublicId (required):
  Future<Response> lecturerCourseDetailsGetWithHttpInfo(String coursePublicId,) async {
    // ignore: prefer_const_declarations
    final path = r'/courses/{course_public_id}'
      .replaceAll('{course_public_id}', coursePublicId);

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

  /// Get Course Details & Student List
  ///
  /// Parameters:
  ///
  /// * [String] coursePublicId (required):
  Future<CourseCohortDetails?> lecturerCourseDetailsGet(String coursePublicId,) async {
    final response = await lecturerCourseDetailsGetWithHttpInfo(coursePublicId,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'CourseCohortDetails',) as CourseCohortDetails;
    
    }
    return null;
  }

  /// Get All Assigned Courses (Current Semester)
  ///
  /// Returns a list of courses assigned to the lecturer for the active semester (Odd/Even logic applied).
  ///
  /// Note: This method returns the HTTP [Response].
  Future<Response> lecturerCoursesGetWithHttpInfo() async {
    // ignore: prefer_const_declarations
    final path = r'/courses';

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

  /// Get All Assigned Courses (Current Semester)
  ///
  /// Returns a list of courses assigned to the lecturer for the active semester (Odd/Even logic applied).
  Future<LecturerCoursesGet200Response?> lecturerCoursesGet() async {
    final response = await lecturerCoursesGetWithHttpInfo();
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'LecturerCoursesGet200Response',) as LecturerCoursesGet200Response;
    
    }
    return null;
  }

  /// Submit or Update Grades
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] coursePublicId (required):
  ///
  /// * [GradeSubmissionBatch] gradeSubmissionBatch (required):
  Future<Response> lecturerGradesPostWithHttpInfo(String coursePublicId, GradeSubmissionBatch gradeSubmissionBatch,) async {
    // ignore: prefer_const_declarations
    final path = r'/courses/{course_public_id}/grades'
      .replaceAll('{course_public_id}', coursePublicId);

    // ignore: prefer_final_locals
    Object? postBody = gradeSubmissionBatch;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['application/json'];


    return apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Submit or Update Grades
  ///
  /// Parameters:
  ///
  /// * [String] coursePublicId (required):
  ///
  /// * [GradeSubmissionBatch] gradeSubmissionBatch (required):
  Future<void> lecturerGradesPost(String coursePublicId, GradeSubmissionBatch gradeSubmissionBatch,) async {
    final response = await lecturerGradesPostWithHttpInfo(coursePublicId, gradeSubmissionBatch,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Get Lecturer Profile
  ///
  /// Note: This method returns the HTTP [Response].
  Future<Response> lecturerProfileGetWithHttpInfo() async {
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

  /// Get Lecturer Profile
  Future<LecturerProfileGet200Response?> lecturerProfileGet() async {
    final response = await lecturerProfileGetWithHttpInfo();
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'LecturerProfileGet200Response',) as LecturerProfileGet200Response;
    
    }
    return null;
  }

  /// Get Weekly Schedule
  ///
  /// Returns the lecturer's timetable for the currently active semester, grouped by day.
  ///
  /// Note: This method returns the HTTP [Response].
  Future<Response> lecturerScheduleGetWithHttpInfo() async {
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

  /// Get Weekly Schedule
  ///
  /// Returns the lecturer's timetable for the currently active semester, grouped by day.
  Future<LecturerScheduleGet200Response?> lecturerScheduleGet() async {
    final response = await lecturerScheduleGetWithHttpInfo();
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'LecturerScheduleGet200Response',) as LecturerScheduleGet200Response;
    
    }
    return null;
  }
}
