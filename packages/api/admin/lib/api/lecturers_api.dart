//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of admin_api;


class LecturersApi {
  LecturersApi([ApiClient? apiClient]) : apiClient = apiClient ?? defaultApiClient;

  final ApiClient apiClient;

  /// Upload CSV
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [MultipartFile] file (required):
  Future<Response> lecturersBatchUploadPostWithHttpInfo(MultipartFile file,) async {
    // ignore: prefer_const_declarations
    final path = r'/lecturers/batch-upload';

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
  Future<void> lecturersBatchUploadPost(MultipartFile file,) async {
    final response = await lecturersBatchUploadPostWithHttpInfo(file,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Performs an HTTP 'GET /lecturers' operation and returns the [Response].
  Future<Response> lecturersGetWithHttpInfo() async {
    // ignore: prefer_const_declarations
    final path = r'/lecturers';

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

  Future<LecturersGet200Response?> lecturersGet() async {
    final response = await lecturersGetWithHttpInfo();
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'LecturersGet200Response',) as LecturersGet200Response;
    
    }
    return null;
  }

  /// Performs an HTTP 'POST /lecturers' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [LecturersPostRequest] lecturersPostRequest (required):
  Future<Response> lecturersPostWithHttpInfo(LecturersPostRequest lecturersPostRequest,) async {
    // ignore: prefer_const_declarations
    final path = r'/lecturers';

    // ignore: prefer_final_locals
    Object? postBody = lecturersPostRequest;

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
  /// * [LecturersPostRequest] lecturersPostRequest (required):
  Future<void> lecturersPost(LecturersPostRequest lecturersPostRequest,) async {
    final response = await lecturersPostWithHttpInfo(lecturersPostRequest,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }
}
