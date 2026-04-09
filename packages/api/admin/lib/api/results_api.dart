//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of admin_api;


class ResultsApi {
  ResultsApi([ApiClient? apiClient]) : apiClient = apiClient ?? defaultApiClient;

  final ApiClient apiClient;

  /// Get list of students in a program with result summaries
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] programPublicId (required):
  ///
  /// * [String] semesterPublicId (required):
  Future<Response> resultsProgramSummaryGetWithHttpInfo(String programPublicId, String semesterPublicId,) async {
    // ignore: prefer_const_declarations
    final path = r'/results/program-summary';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

      queryParams.addAll(_queryParams('', 'program_public_id', programPublicId));
      queryParams.addAll(_queryParams('', 'semester_public_id', semesterPublicId));

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

  /// Get list of students in a program with result summaries
  ///
  /// Parameters:
  ///
  /// * [String] programPublicId (required):
  ///
  /// * [String] semesterPublicId (required):
  Future<ProgramResultsResponse?> resultsProgramSummaryGet(String programPublicId, String semesterPublicId,) async {
    final response = await resultsProgramSummaryGetWithHttpInfo(programPublicId, semesterPublicId,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'ProgramResultsResponse',) as ProgramResultsResponse;
    
    }
    return null;
  }

  /// Publish results for a specific program and semester
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [ResultsPublishPostRequest] resultsPublishPostRequest (required):
  Future<Response> resultsPublishPostWithHttpInfo(ResultsPublishPostRequest resultsPublishPostRequest,) async {
    // ignore: prefer_const_declarations
    final path = r'/results/publish';

    // ignore: prefer_final_locals
    Object? postBody = resultsPublishPostRequest;

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

  /// Publish results for a specific program and semester
  ///
  /// Parameters:
  ///
  /// * [ResultsPublishPostRequest] resultsPublishPostRequest (required):
  Future<ResultsPublishPost200Response?> resultsPublishPost(ResultsPublishPostRequest resultsPublishPostRequest,) async {
    final response = await resultsPublishPostWithHttpInfo(resultsPublishPostRequest,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'ResultsPublishPost200Response',) as ResultsPublishPost200Response;
    
    }
    return null;
  }

  /// Get detailed course breakdown for a specific student
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] studentPublicId (required):
  ///
  /// * [String] semesterPublicId (required):
  Future<Response> resultsStudentTranscriptGetWithHttpInfo(String studentPublicId, String semesterPublicId,) async {
    // ignore: prefer_const_declarations
    final path = r'/results/student-transcript';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

      queryParams.addAll(_queryParams('', 'student_public_id', studentPublicId));
      queryParams.addAll(_queryParams('', 'semester_public_id', semesterPublicId));

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

  /// Get detailed course breakdown for a specific student
  ///
  /// Parameters:
  ///
  /// * [String] studentPublicId (required):
  ///
  /// * [String] semesterPublicId (required):
  Future<StudentTranscript?> resultsStudentTranscriptGet(String studentPublicId, String semesterPublicId,) async {
    final response = await resultsStudentTranscriptGetWithHttpInfo(studentPublicId, semesterPublicId,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'StudentTranscript',) as StudentTranscript;
    
    }
    return null;
  }
}
