//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of admin_api;


class FinanceApi {
  FinanceApi([ApiClient? apiClient]) : apiClient = apiClient ?? defaultApiClient;

  final ApiClient apiClient;

  /// Performs an HTTP 'GET /finance/fees' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [String] studentPublicId:
  ///
  /// * [String] status:
  Future<Response> financeFeesGetWithHttpInfo({ String? studentPublicId, String? status, }) async {
    // ignore: prefer_const_declarations
    final path = r'/finance/fees';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    if (studentPublicId != null) {
      queryParams.addAll(_queryParams('', 'student_public_id', studentPublicId));
    }
    if (status != null) {
      queryParams.addAll(_queryParams('', 'status', status));
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
  /// * [String] studentPublicId:
  ///
  /// * [String] status:
  Future<FinanceFeesGet200Response?> financeFeesGet({ String? studentPublicId, String? status, }) async {
    final response = await financeFeesGetWithHttpInfo( studentPublicId: studentPublicId, status: status, );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'FinanceFeesGet200Response',) as FinanceFeesGet200Response;
    
    }
    return null;
  }

  /// Performs an HTTP 'POST /finance/fees' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [FinanceFeesPostRequest] financeFeesPostRequest (required):
  Future<Response> financeFeesPostWithHttpInfo(FinanceFeesPostRequest financeFeesPostRequest,) async {
    // ignore: prefer_const_declarations
    final path = r'/finance/fees';

    // ignore: prefer_final_locals
    Object? postBody = financeFeesPostRequest;

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
  /// * [FinanceFeesPostRequest] financeFeesPostRequest (required):
  Future<void> financeFeesPost(FinanceFeesPostRequest financeFeesPostRequest,) async {
    final response = await financeFeesPostWithHttpInfo(financeFeesPostRequest,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Performs an HTTP 'GET /finance/students/{student_id}/fees' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [String] studentId (required):
  Future<Response> financeStudentFeesGetWithHttpInfo(String studentId,) async {
    // ignore: prefer_const_declarations
    final path = r'/finance/students/{student_id}/fees'
      .replaceAll('{student_id}', studentId);

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
  /// * [String] studentId (required):
  Future<FinanceFeesGet200Response?> financeStudentFeesGet(String studentId,) async {
    final response = await financeStudentFeesGetWithHttpInfo(studentId,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'FinanceFeesGet200Response',) as FinanceFeesGet200Response;
    
    }
    return null;
  }

  /// Performs an HTTP 'GET /finance/transactions' operation and returns the [Response].
  Future<Response> financeTransactionsGetWithHttpInfo() async {
    // ignore: prefer_const_declarations
    final path = r'/finance/transactions';

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

  Future<FinanceTransactionsGet200Response?> financeTransactionsGet() async {
    final response = await financeTransactionsGetWithHttpInfo();
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'FinanceTransactionsGet200Response',) as FinanceTransactionsGet200Response;
    
    }
    return null;
  }

  /// Performs an HTTP 'POST /finance/transactions' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [FinanceTransactionsPostRequest] financeTransactionsPostRequest (required):
  Future<Response> financeTransactionsPostWithHttpInfo(FinanceTransactionsPostRequest financeTransactionsPostRequest,) async {
    // ignore: prefer_const_declarations
    final path = r'/finance/transactions';

    // ignore: prefer_final_locals
    Object? postBody = financeTransactionsPostRequest;

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
  /// * [FinanceTransactionsPostRequest] financeTransactionsPostRequest (required):
  Future<void> financeTransactionsPost(FinanceTransactionsPostRequest financeTransactionsPostRequest,) async {
    final response = await financeTransactionsPostWithHttpInfo(financeTransactionsPostRequest,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }
}
