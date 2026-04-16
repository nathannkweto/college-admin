//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of admin_api;

class AcademicsApi {
  AcademicsApi([ApiClient? apiClient]) : apiClient = apiClient ?? defaultApiClient;

  final ApiClient apiClient;

  /// Performs an HTTP 'GET /courses' operation and returns the [Response].
  Future<Response> coursesGetWithHttpInfo() async {
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

  Future<CoursesGet200Response?> coursesGet() async {
    final response = await coursesGetWithHttpInfo();
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'CoursesGet200Response',) as CoursesGet200Response;
    
    }
    return null;
  }

  /// Performs an HTTP 'POST /courses' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [CoursesPostRequest] coursesPostRequest (required):
  Future<Response> coursesPostWithHttpInfo(CoursesPostRequest coursesPostRequest,) async {
    // ignore: prefer_const_declarations
    final path = r'/courses';

    // ignore: prefer_final_locals
    Object? postBody = coursesPostRequest;

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
  /// * [CoursesPostRequest] coursesPostRequest (required):
  Future<void> coursesPost(CoursesPostRequest coursesPostRequest,) async {
    final response = await coursesPostWithHttpInfo(coursesPostRequest,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Performs an HTTP 'GET /departments' operation and returns the [Response].
  Future<Response> departmentsGetWithHttpInfo() async {
    // ignore: prefer_const_declarations
    final path = r'/departments';

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

  Future<DepartmentsGet200Response?> departmentsGet() async {
    final response = await departmentsGetWithHttpInfo();
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'DepartmentsGet200Response',) as DepartmentsGet200Response;
    
    }
    return null;
  }

  /// Performs an HTTP 'POST /departments' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [DepartmentsPostRequest] departmentsPostRequest (required):
  Future<Response> departmentsPostWithHttpInfo(DepartmentsPostRequest departmentsPostRequest,) async {
    // ignore: prefer_const_declarations
    final path = r'/departments';

    // ignore: prefer_final_locals
    Object? postBody = departmentsPostRequest;

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
  /// * [DepartmentsPostRequest] departmentsPostRequest (required):
  Future<void> departmentsPost(DepartmentsPostRequest departmentsPostRequest,) async {
    final response = await departmentsPostWithHttpInfo(departmentsPostRequest,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Performs an HTTP 'DELETE /programs/{public_id}/courses/{course_public_id}' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [String] publicId (required):
  ///
  /// * [String] coursePublicId (required):
  Future<Response> programsCoursesDeleteWithHttpInfo(String publicId, String coursePublicId,) async {
    // ignore: prefer_const_declarations
    final path = r'/programs/{public_id}/courses/{course_public_id}'
      .replaceAll('{public_id}', publicId)
      .replaceAll('{course_public_id}', coursePublicId);

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>[];


    return apiClient.invokeAPI(
      path,
      'DELETE',
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
  ///
  /// * [String] coursePublicId (required):
  Future<void> programsCoursesDelete(String publicId, String coursePublicId,) async {
    final response = await programsCoursesDeleteWithHttpInfo(publicId, coursePublicId,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Performs an HTTP 'GET /programs/{public_id}/courses' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [String] publicId (required):
  Future<Response> programsCoursesGetWithHttpInfo(String publicId,) async {
    // ignore: prefer_const_declarations
    final path = r'/programs/{public_id}/courses'
      .replaceAll('{public_id}', publicId);

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

  /// Parameters:
  ///
  /// * [String] publicId (required):
  Future<ProgramsCoursesGet200Response?> programsCoursesGet(String publicId,) async {
    final response = await programsCoursesGetWithHttpInfo(publicId,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'ProgramsCoursesGet200Response',) as ProgramsCoursesGet200Response;
    
    }
    return null;
  }

  /// Performs an HTTP 'POST /programs/{public_id}/courses' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [String] publicId (required):
  ///
  /// * [ProgramsCoursesPostRequest] programsCoursesPostRequest (required):
  Future<Response> programsCoursesPostWithHttpInfo(String publicId, ProgramsCoursesPostRequest programsCoursesPostRequest,) async {
    // ignore: prefer_const_declarations
    final path = r'/programs/{public_id}/courses'
      .replaceAll('{public_id}', publicId);

    // ignore: prefer_final_locals
    Object? postBody = programsCoursesPostRequest;

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
  /// * [String] publicId (required):
  ///
  /// * [ProgramsCoursesPostRequest] programsCoursesPostRequest (required):
  Future<void> programsCoursesPost(String publicId, ProgramsCoursesPostRequest programsCoursesPostRequest,) async {
    final response = await programsCoursesPostWithHttpInfo(publicId, programsCoursesPostRequest,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Performs an HTTP 'GET /programs' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [String] qualificationPublicId:
  ///
  /// * [String] departmentPublicId:
  Future<Response> programsGetWithHttpInfo({ String? qualificationPublicId, String? departmentPublicId, }) async {
    // ignore: prefer_const_declarations
    final path = r'/programs';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    if (qualificationPublicId != null) {
      queryParams.addAll(_queryParams('', 'qualification_public_id', qualificationPublicId));
    }
    if (departmentPublicId != null) {
      queryParams.addAll(_queryParams('', 'department_public_id', departmentPublicId));
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
  /// * [String] qualificationPublicId:
  ///
  /// * [String] departmentPublicId:
  Future<ProgramsGet200Response?> programsGet({ String? qualificationPublicId, String? departmentPublicId, }) async {
    final response = await programsGetWithHttpInfo( qualificationPublicId: qualificationPublicId, departmentPublicId: departmentPublicId, );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'ProgramsGet200Response',) as ProgramsGet200Response;
    
    }
    return null;
  }

  /// Performs an HTTP 'POST /programs' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [ProgramsPostRequest] programsPostRequest (required):
  Future<Response> programsPostWithHttpInfo(ProgramsPostRequest programsPostRequest,) async {
    // ignore: prefer_const_declarations
    final path = r'/programs';

    // ignore: prefer_final_locals
    Object? postBody = programsPostRequest;

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
  /// * [ProgramsPostRequest] programsPostRequest (required):
  Future<void> programsPost(ProgramsPostRequest programsPostRequest,) async {
    final response = await programsPostWithHttpInfo(programsPostRequest,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Performs an HTTP 'GET /qualifications' operation and returns the [Response].
  Future<Response> qualificationsGetWithHttpInfo() async {
    // ignore: prefer_const_declarations
    final path = r'/qualifications';

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

  Future<QualificationsGet200Response?> qualificationsGet() async {
    final response = await qualificationsGetWithHttpInfo();
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'QualificationsGet200Response',) as QualificationsGet200Response;
    
    }
    return null;
  }

  /// Performs an HTTP 'POST /qualifications' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [DepartmentsPostRequest] departmentsPostRequest (required):
  Future<Response> qualificationsPostWithHttpInfo(DepartmentsPostRequest departmentsPostRequest,) async {
    // ignore: prefer_const_declarations
    final path = r'/qualifications';

    // ignore: prefer_final_locals
    Object? postBody = departmentsPostRequest;

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
  /// * [DepartmentsPostRequest] departmentsPostRequest (required):
  Future<void> qualificationsPost(DepartmentsPostRequest departmentsPostRequest,) async {
    final response = await qualificationsPostWithHttpInfo(departmentsPostRequest,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }
}
