# admin_api.api.ResultsApi

## Load the API package
```dart
import 'package:admin_api/api.dart';
```

All URIs are relative to *https://api.college.edu/api/v1/admin*

Method | HTTP request | Description
------------- | ------------- | -------------
[**resultsProgramSummaryGet**](ResultsApi.md#resultsprogramsummaryget) | **GET** /results/program-summary | Get list of students in a program with result summaries
[**resultsPublishPost**](ResultsApi.md#resultspublishpost) | **POST** /results/publish | Publish results for a specific program and semester
[**resultsStudentTranscriptGet**](ResultsApi.md#resultsstudenttranscriptget) | **GET** /results/student-transcript | Get detailed course breakdown for a specific student


# **resultsProgramSummaryGet**
> ProgramResultsResponse resultsProgramSummaryGet(programPublicId, semesterPublicId)

Get list of students in a program with result summaries

### Example
```dart
import 'package:admin_api/api.dart';
// TODO Configure HTTP Bearer authorization: bearerAuth
// Case 1. Use String Token
//defaultApiClient.getAuthentication<HttpBearerAuth>('bearerAuth').setAccessToken('YOUR_ACCESS_TOKEN');
// Case 2. Use Function which generate token.
// String yourTokenGeneratorFunction() { ... }
//defaultApiClient.getAuthentication<HttpBearerAuth>('bearerAuth').setAccessToken(yourTokenGeneratorFunction);

final api_instance = ResultsApi();
final programPublicId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final semesterPublicId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final result = api_instance.resultsProgramSummaryGet(programPublicId, semesterPublicId);
    print(result);
} catch (e) {
    print('Exception when calling ResultsApi->resultsProgramSummaryGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **programPublicId** | **String**|  | 
 **semesterPublicId** | **String**|  | 

### Return type

[**ProgramResultsResponse**](ProgramResultsResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **resultsPublishPost**
> ResultsPublishPost200Response resultsPublishPost(resultsPublishPostRequest)

Publish results for a specific program and semester

### Example
```dart
import 'package:admin_api/api.dart';
// TODO Configure HTTP Bearer authorization: bearerAuth
// Case 1. Use String Token
//defaultApiClient.getAuthentication<HttpBearerAuth>('bearerAuth').setAccessToken('YOUR_ACCESS_TOKEN');
// Case 2. Use Function which generate token.
// String yourTokenGeneratorFunction() { ... }
//defaultApiClient.getAuthentication<HttpBearerAuth>('bearerAuth').setAccessToken(yourTokenGeneratorFunction);

final api_instance = ResultsApi();
final resultsPublishPostRequest = ResultsPublishPostRequest(); // ResultsPublishPostRequest | 

try {
    final result = api_instance.resultsPublishPost(resultsPublishPostRequest);
    print(result);
} catch (e) {
    print('Exception when calling ResultsApi->resultsPublishPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **resultsPublishPostRequest** | [**ResultsPublishPostRequest**](ResultsPublishPostRequest.md)|  | 

### Return type

[**ResultsPublishPost200Response**](ResultsPublishPost200Response.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **resultsStudentTranscriptGet**
> StudentTranscript resultsStudentTranscriptGet(studentPublicId, semesterPublicId)

Get detailed course breakdown for a specific student

### Example
```dart
import 'package:admin_api/api.dart';
// TODO Configure HTTP Bearer authorization: bearerAuth
// Case 1. Use String Token
//defaultApiClient.getAuthentication<HttpBearerAuth>('bearerAuth').setAccessToken('YOUR_ACCESS_TOKEN');
// Case 2. Use Function which generate token.
// String yourTokenGeneratorFunction() { ... }
//defaultApiClient.getAuthentication<HttpBearerAuth>('bearerAuth').setAccessToken(yourTokenGeneratorFunction);

final api_instance = ResultsApi();
final studentPublicId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final semesterPublicId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final result = api_instance.resultsStudentTranscriptGet(studentPublicId, semesterPublicId);
    print(result);
} catch (e) {
    print('Exception when calling ResultsApi->resultsStudentTranscriptGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **studentPublicId** | **String**|  | 
 **semesterPublicId** | **String**|  | 

### Return type

[**StudentTranscript**](StudentTranscript.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

