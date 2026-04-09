//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of admin_api;


class ExamsApi {
  ExamsApi([ApiClient? apiClient]) : apiClient = apiClient ?? defaultApiClient;

  final ApiClient apiClient;

  /// Get exam schedules for a specific program and season
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] programPublicId (required):
  ///
  /// * [String] seasonPublicId (required):
  Future<Response> examSchedulesListWithHttpInfo(String programPublicId, String seasonPublicId,) async {
    // ignore: prefer_const_declarations
    final path = r'/exams/schedules';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

      queryParams.addAll(_queryParams('', 'program_public_id', programPublicId));
      queryParams.addAll(_queryParams('', 'season_public_id', seasonPublicId));

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

  /// Get exam schedules for a specific program and season
  ///
  /// Parameters:
  ///
  /// * [String] programPublicId (required):
  ///
  /// * [String] seasonPublicId (required):
  Future<ExamSchedulesList200Response?> examSchedulesList(String programPublicId, String seasonPublicId,) async {
    final response = await examSchedulesListWithHttpInfo(programPublicId, seasonPublicId,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'ExamSchedulesList200Response',) as ExamSchedulesList200Response;
    
    }
    return null;
  }

  /// Schedule an exam paper
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [ExamPaperRequest] examPaperRequest (required):
  Future<Response> examSchedulesPostWithHttpInfo(ExamPaperRequest examPaperRequest,) async {
    // ignore: prefer_const_declarations
    final path = r'/exams/schedules';

    // ignore: prefer_final_locals
    Object? postBody = examPaperRequest;

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

  /// Schedule an exam paper
  ///
  /// Parameters:
  ///
  /// * [ExamPaperRequest] examPaperRequest (required):
  Future<void> examSchedulesPost(ExamPaperRequest examPaperRequest,) async {
    final response = await examSchedulesPostWithHttpInfo(examPaperRequest,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Get the currently active exam season
  ///
  /// Note: This method returns the HTTP [Response].
  Future<Response> examSeasonsActiveWithHttpInfo() async {
    // ignore: prefer_const_declarations
    final path = r'/exams/seasons/active';

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

  /// Get the currently active exam season
  Future<ExamSeasonsPost201Response?> examSeasonsActive() async {
    final response = await examSeasonsActiveWithHttpInfo();
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'ExamSeasonsPost201Response',) as ExamSeasonsPost201Response;
    
    }
    return null;
  }

  /// End a specific exam season (set is_active to false)
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] publicId (required):
  Future<Response> examSeasonsEndWithHttpInfo(String publicId,) async {
    // ignore: prefer_const_declarations
    final path = r'/exams/seasons/{public_id}/end'
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

  /// End a specific exam season (set is_active to false)
  ///
  /// Parameters:
  ///
  /// * [String] publicId (required):
  Future<ExamSeasonsEnd200Response?> examSeasonsEnd(String publicId,) async {
    final response = await examSeasonsEndWithHttpInfo(publicId,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'ExamSeasonsEnd200Response',) as ExamSeasonsEnd200Response;
    
    }
    return null;
  }

  /// List all exam seasons
  ///
  /// Note: This method returns the HTTP [Response].
  Future<Response> examSeasonsListWithHttpInfo() async {
    // ignore: prefer_const_declarations
    final path = r'/exams/seasons';

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

  /// List all exam seasons
  Future<ExamSeasonsList200Response?> examSeasonsList() async {
    final response = await examSeasonsListWithHttpInfo();
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'ExamSeasonsList200Response',) as ExamSeasonsList200Response;
    
    }
    return null;
  }

  /// Create a new exam season
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [ExamSeasonsPostRequest] examSeasonsPostRequest (required):
  Future<Response> examSeasonsPostWithHttpInfo(ExamSeasonsPostRequest examSeasonsPostRequest,) async {
    // ignore: prefer_const_declarations
    final path = r'/exams/seasons';

    // ignore: prefer_final_locals
    Object? postBody = examSeasonsPostRequest;

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

  /// Create a new exam season
  ///
  /// Parameters:
  ///
  /// * [ExamSeasonsPostRequest] examSeasonsPostRequest (required):
  Future<ExamSeasonsPost201Response?> examSeasonsPost(ExamSeasonsPostRequest examSeasonsPostRequest,) async {
    final response = await examSeasonsPostWithHttpInfo(examSeasonsPostRequest,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'ExamSeasonsPost201Response',) as ExamSeasonsPost201Response;
    
    }
    return null;
  }
}
