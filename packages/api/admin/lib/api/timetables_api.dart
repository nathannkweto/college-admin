//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of admin_api;


class TimetablesApi {
  TimetablesApi([ApiClient? apiClient]) : apiClient = apiClient ?? defaultApiClient;

  final ApiClient apiClient;

  /// List timetable entries
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] semesterPublicId (required):
  ///
  /// * [String] programPublicId:
  ///   Filter by program
  Future<Response> logisticsTimetableGetWithHttpInfo(String semesterPublicId, { String? programPublicId, }) async {
    // ignore: prefer_const_declarations
    final path = r'/logistics/timetable';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

      queryParams.addAll(_queryParams('', 'semester_public_id', semesterPublicId));
    if (programPublicId != null) {
      queryParams.addAll(_queryParams('', 'program_public_id', programPublicId));
    }

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

  /// List timetable entries
  ///
  /// Parameters:
  ///
  /// * [String] semesterPublicId (required):
  ///
  /// * [String] programPublicId:
  ///   Filter by program
  Future<LogisticsTimetableGet200Response?> logisticsTimetableGet(String semesterPublicId, { String? programPublicId, }) async {
    final response = await logisticsTimetableGetWithHttpInfo(semesterPublicId,  programPublicId: programPublicId, );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'LogisticsTimetableGet200Response',) as LogisticsTimetableGet200Response;
    
    }
    return null;
  }

  /// Create a new timetable entry
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [LogisticsTimetablePostRequest] logisticsTimetablePostRequest (required):
  Future<Response> logisticsTimetablePostWithHttpInfo(LogisticsTimetablePostRequest logisticsTimetablePostRequest,) async {
    // ignore: prefer_const_declarations
    final path = r'/logistics/timetable';

    // ignore: prefer_final_locals
    Object? postBody = logisticsTimetablePostRequest;

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

  /// Create a new timetable entry
  ///
  /// Parameters:
  ///
  /// * [LogisticsTimetablePostRequest] logisticsTimetablePostRequest (required):
  Future<LogisticsTimetablePost201Response?> logisticsTimetablePost(LogisticsTimetablePostRequest logisticsTimetablePostRequest,) async {
    final response = await logisticsTimetablePostWithHttpInfo(logisticsTimetablePostRequest,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'LogisticsTimetablePost201Response',) as LogisticsTimetablePost201Response;
    
    }
    return null;
  }

  /// Performs an HTTP 'POST /semesters/{public_id}/end' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [String] publicId (required):
  Future<Response> semesterEndPostWithHttpInfo(String publicId,) async {
    // ignore: prefer_const_declarations
    final path = r'/semesters/{public_id}/end'
      .replaceAll('{public_id}', publicId);

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>[];


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

  /// Parameters:
  ///
  /// * [String] publicId (required):
  Future<void> semesterEndPost(String publicId,) async {
    final response = await semesterEndPostWithHttpInfo(publicId,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Performs an HTTP 'GET /semesters/active' operation and returns the [Response].
  Future<Response> semestersActiveGetWithHttpInfo() async {
    // ignore: prefer_const_declarations
    final path = r'/semesters/active';

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

  Future<SemesterResponse?> semestersActiveGet() async {
    final response = await semestersActiveGetWithHttpInfo();
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'SemesterResponse',) as SemesterResponse;
    
    }
    return null;
  }

  /// Performs an HTTP 'GET /semesters' operation and returns the [Response].
  Future<Response> semestersGetWithHttpInfo() async {
    // ignore: prefer_const_declarations
    final path = r'/semesters';

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

  Future<SemestersGet200Response?> semestersGet() async {
    final response = await semestersGetWithHttpInfo();
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'SemestersGet200Response',) as SemestersGet200Response;
    
    }
    return null;
  }

  /// Performs an HTTP 'POST /semesters' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [SemestersPostRequest] semestersPostRequest (required):
  Future<Response> semestersPostWithHttpInfo(SemestersPostRequest semestersPostRequest,) async {
    // ignore: prefer_const_declarations
    final path = r'/semesters';

    // ignore: prefer_final_locals
    Object? postBody = semestersPostRequest;

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

  /// Parameters:
  ///
  /// * [SemestersPostRequest] semestersPostRequest (required):
  Future<void> semestersPost(SemestersPostRequest semestersPostRequest,) async {
    final response = await semestersPostWithHttpInfo(semestersPostRequest,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }
}
