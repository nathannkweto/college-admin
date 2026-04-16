//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of admin_api;


class StudentsApi {
  StudentsApi([ApiClient? apiClient]) : apiClient = apiClient ?? defaultApiClient;

  final ApiClient apiClient;

  /// Upload CSV
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [MultipartFile] file (required):
  Future<Response> studentsBatchUploadPostWithHttpInfo(MultipartFile file,) async {
    // ignore: prefer_const_declarations
    final path = r'/students/batch-upload';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['multipart/form-data'];

    bool hasFields = false;
    final mp = MultipartRequest('POST', Uri.parse(path));
    if (file != null) {
      hasFields = true;
      mp.fields[r'file'] = file.field;
      mp.files.add(file);
    }
    if (hasFields) {
      postBody = mp;
    }

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

  /// Upload CSV
  ///
  /// Parameters:
  ///
  /// * [MultipartFile] file (required):
  Future<void> studentsBatchUploadPost(MultipartFile file,) async {
    final response = await studentsBatchUploadPostWithHttpInfo(file,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Performs an HTTP 'GET /students' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [String] programPublicId:
  ///
  /// * [String] search:
  Future<Response> studentsGetWithHttpInfo({ String? programPublicId, String? search, }) async {
    // ignore: prefer_const_declarations
    final path = r'/students';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    if (programPublicId != null) {
      queryParams.addAll(_queryParams('', 'program_public_id', programPublicId));
    }
    if (search != null) {
      queryParams.addAll(_queryParams('', 'search', search));
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

  /// Parameters:
  ///
  /// * [String] programPublicId:
  ///
  /// * [String] search:
  Future<StudentsGet200Response?> studentsGet({ String? programPublicId, String? search, }) async {
    final response = await studentsGetWithHttpInfo( programPublicId: programPublicId, search: search, );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'StudentsGet200Response',) as StudentsGet200Response;
    
    }
    return null;
  }

  /// Performs an HTTP 'POST /students' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [StudentsPostRequest] studentsPostRequest (required):
  Future<Response> studentsPostWithHttpInfo(StudentsPostRequest studentsPostRequest,) async {
    // ignore: prefer_const_declarations
    final path = r'/students';

    // ignore: prefer_final_locals
    Object? postBody = studentsPostRequest;

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
  /// * [StudentsPostRequest] studentsPostRequest (required):
  Future<void> studentsPost(StudentsPostRequest studentsPostRequest,) async {
    final response = await studentsPostWithHttpInfo(studentsPostRequest,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Performs an HTTP 'POST /students/promote' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [StudentsPromotePostRequest] studentsPromotePostRequest (required):
  Future<Response> studentsPromotePostWithHttpInfo(StudentsPromotePostRequest studentsPromotePostRequest,) async {
    // ignore: prefer_const_declarations
    final path = r'/students/promote';

    // ignore: prefer_final_locals
    Object? postBody = studentsPromotePostRequest;

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
  /// * [StudentsPromotePostRequest] studentsPromotePostRequest (required):
  Future<void> studentsPromotePost(StudentsPromotePostRequest studentsPromotePostRequest,) async {
    final response = await studentsPromotePostWithHttpInfo(studentsPromotePostRequest,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Performs an HTTP 'POST /students/promotion-preview' operation and returns the [Response].
  Future<Response> studentsPromotionPreviewWithHttpInfo() async {
    // ignore: prefer_const_declarations
    final path = r'/students/promotion-preview';

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

  Future<StudentsPromotionPreview200Response?> studentsPromotionPreview() async {
    final response = await studentsPromotionPreviewWithHttpInfo();
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'StudentsPromotionPreview200Response',) as StudentsPromotionPreview200Response;
    
    }
    return null;
  }
}
