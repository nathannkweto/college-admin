# admin_api.api.ExamsApi

## Load the API package
```dart
import 'package:admin_api/api.dart';
```

All URIs are relative to *https://api.college.edu/api/v1/admin*

Method | HTTP request | Description
------------- | ------------- | -------------
[**examSchedulesList**](ExamsApi.md#examscheduleslist) | **GET** /exams/schedules | Get exam schedules for a specific program and season
[**examSchedulesPost**](ExamsApi.md#examschedulespost) | **POST** /exams/schedules | Schedule an exam paper
[**examSeasonsActive**](ExamsApi.md#examseasonsactive) | **GET** /exams/seasons/active | Get the currently active exam season
[**examSeasonsEnd**](ExamsApi.md#examseasonsend) | **POST** /exams/seasons/{public_id}/end | End a specific exam season (set is_active to false)
[**examSeasonsList**](ExamsApi.md#examseasonslist) | **GET** /exams/seasons | List all exam seasons
[**examSeasonsPost**](ExamsApi.md#examseasonspost) | **POST** /exams/seasons | Create a new exam season


# **examSchedulesList**
> ExamSchedulesList200Response examSchedulesList(programPublicId, seasonPublicId)

Get exam schedules for a specific program and season

### Example
```dart
import 'package:admin_api/api.dart';
// TODO Configure HTTP Bearer authorization: bearerAuth
// Case 1. Use String Token
//defaultApiClient.getAuthentication<HttpBearerAuth>('bearerAuth').setAccessToken('YOUR_ACCESS_TOKEN');
// Case 2. Use Function which generate token.
// String yourTokenGeneratorFunction() { ... }
//defaultApiClient.getAuthentication<HttpBearerAuth>('bearerAuth').setAccessToken(yourTokenGeneratorFunction);

final api_instance = ExamsApi();
final programPublicId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final seasonPublicId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final result = api_instance.examSchedulesList(programPublicId, seasonPublicId);
    print(result);
} catch (e) {
    print('Exception when calling ExamsApi->examSchedulesList: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **programPublicId** | **String**|  | 
 **seasonPublicId** | **String**|  | 

### Return type

[**ExamSchedulesList200Response**](ExamSchedulesList200Response.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **examSchedulesPost**
> examSchedulesPost(examPaperRequest)

Schedule an exam paper

### Example
```dart
import 'package:admin_api/api.dart';
// TODO Configure HTTP Bearer authorization: bearerAuth
// Case 1. Use String Token
//defaultApiClient.getAuthentication<HttpBearerAuth>('bearerAuth').setAccessToken('YOUR_ACCESS_TOKEN');
// Case 2. Use Function which generate token.
// String yourTokenGeneratorFunction() { ... }
//defaultApiClient.getAuthentication<HttpBearerAuth>('bearerAuth').setAccessToken(yourTokenGeneratorFunction);

final api_instance = ExamsApi();
final examPaperRequest = ExamPaperRequest(); // ExamPaperRequest | 

try {
    api_instance.examSchedulesPost(examPaperRequest);
} catch (e) {
    print('Exception when calling ExamsApi->examSchedulesPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **examPaperRequest** | [**ExamPaperRequest**](ExamPaperRequest.md)|  | 

### Return type

void (empty response body)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **examSeasonsActive**
> ExamSeasonsPost201Response examSeasonsActive()

Get the currently active exam season

### Example
```dart
import 'package:admin_api/api.dart';
// TODO Configure HTTP Bearer authorization: bearerAuth
// Case 1. Use String Token
//defaultApiClient.getAuthentication<HttpBearerAuth>('bearerAuth').setAccessToken('YOUR_ACCESS_TOKEN');
// Case 2. Use Function which generate token.
// String yourTokenGeneratorFunction() { ... }
//defaultApiClient.getAuthentication<HttpBearerAuth>('bearerAuth').setAccessToken(yourTokenGeneratorFunction);

final api_instance = ExamsApi();

try {
    final result = api_instance.examSeasonsActive();
    print(result);
} catch (e) {
    print('Exception when calling ExamsApi->examSeasonsActive: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**ExamSeasonsPost201Response**](ExamSeasonsPost201Response.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **examSeasonsEnd**
> ExamSeasonsEnd200Response examSeasonsEnd(publicId)

End a specific exam season (set is_active to false)

### Example
```dart
import 'package:admin_api/api.dart';
// TODO Configure HTTP Bearer authorization: bearerAuth
// Case 1. Use String Token
//defaultApiClient.getAuthentication<HttpBearerAuth>('bearerAuth').setAccessToken('YOUR_ACCESS_TOKEN');
// Case 2. Use Function which generate token.
// String yourTokenGeneratorFunction() { ... }
//defaultApiClient.getAuthentication<HttpBearerAuth>('bearerAuth').setAccessToken(yourTokenGeneratorFunction);

final api_instance = ExamsApi();
final publicId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final result = api_instance.examSeasonsEnd(publicId);
    print(result);
} catch (e) {
    print('Exception when calling ExamsApi->examSeasonsEnd: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **publicId** | **String**|  | 

### Return type

[**ExamSeasonsEnd200Response**](ExamSeasonsEnd200Response.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **examSeasonsList**
> ExamSeasonsList200Response examSeasonsList()

List all exam seasons

### Example
```dart
import 'package:admin_api/api.dart';
// TODO Configure HTTP Bearer authorization: bearerAuth
// Case 1. Use String Token
//defaultApiClient.getAuthentication<HttpBearerAuth>('bearerAuth').setAccessToken('YOUR_ACCESS_TOKEN');
// Case 2. Use Function which generate token.
// String yourTokenGeneratorFunction() { ... }
//defaultApiClient.getAuthentication<HttpBearerAuth>('bearerAuth').setAccessToken(yourTokenGeneratorFunction);

final api_instance = ExamsApi();

try {
    final result = api_instance.examSeasonsList();
    print(result);
} catch (e) {
    print('Exception when calling ExamsApi->examSeasonsList: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**ExamSeasonsList200Response**](ExamSeasonsList200Response.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **examSeasonsPost**
> ExamSeasonsPost201Response examSeasonsPost(examSeasonsPostRequest)

Create a new exam season

### Example
```dart
import 'package:admin_api/api.dart';
// TODO Configure HTTP Bearer authorization: bearerAuth
// Case 1. Use String Token
//defaultApiClient.getAuthentication<HttpBearerAuth>('bearerAuth').setAccessToken('YOUR_ACCESS_TOKEN');
// Case 2. Use Function which generate token.
// String yourTokenGeneratorFunction() { ... }
//defaultApiClient.getAuthentication<HttpBearerAuth>('bearerAuth').setAccessToken(yourTokenGeneratorFunction);

final api_instance = ExamsApi();
final examSeasonsPostRequest = ExamSeasonsPostRequest(); // ExamSeasonsPostRequest | 

try {
    final result = api_instance.examSeasonsPost(examSeasonsPostRequest);
    print(result);
} catch (e) {
    print('Exception when calling ExamsApi->examSeasonsPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **examSeasonsPostRequest** | [**ExamSeasonsPostRequest**](ExamSeasonsPostRequest.md)|  | 

### Return type

[**ExamSeasonsPost201Response**](ExamSeasonsPost201Response.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

