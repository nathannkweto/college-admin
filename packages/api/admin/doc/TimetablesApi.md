# admin_api.api.TimetablesApi

## Load the API package
```dart
import 'package:admin_api/api.dart';
```

All URIs are relative to *https://api.college.edu/api/v1/admin*

Method | HTTP request | Description
------------- | ------------- | -------------
[**logisticsTimetableGet**](TimetablesApi.md#logisticstimetableget) | **GET** /logistics/timetable | List timetable entries
[**logisticsTimetablePost**](TimetablesApi.md#logisticstimetablepost) | **POST** /logistics/timetable | Create a new timetable entry
[**semesterEndPost**](TimetablesApi.md#semesterendpost) | **POST** /semesters/{public_id}/end | 
[**semestersActiveGet**](TimetablesApi.md#semestersactiveget) | **GET** /semesters/active | 
[**semestersGet**](TimetablesApi.md#semestersget) | **GET** /semesters | 
[**semestersPost**](TimetablesApi.md#semesterspost) | **POST** /semesters | 


# **logisticsTimetableGet**
> LogisticsTimetableGet200Response logisticsTimetableGet(semesterPublicId, programPublicId)

List timetable entries

### Example
```dart
import 'package:admin_api/api.dart';
// TODO Configure HTTP Bearer authorization: bearerAuth
// Case 1. Use String Token
//defaultApiClient.getAuthentication<HttpBearerAuth>('bearerAuth').setAccessToken('YOUR_ACCESS_TOKEN');
// Case 2. Use Function which generate token.
// String yourTokenGeneratorFunction() { ... }
//defaultApiClient.getAuthentication<HttpBearerAuth>('bearerAuth').setAccessToken(yourTokenGeneratorFunction);

final api_instance = TimetablesApi();
final semesterPublicId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final programPublicId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | Filter by program

try {
    final result = api_instance.logisticsTimetableGet(semesterPublicId, programPublicId);
    print(result);
} catch (e) {
    print('Exception when calling TimetablesApi->logisticsTimetableGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **semesterPublicId** | **String**|  | 
 **programPublicId** | **String**| Filter by program | [optional] 

### Return type

[**LogisticsTimetableGet200Response**](LogisticsTimetableGet200Response.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **logisticsTimetablePost**
> LogisticsTimetablePost201Response logisticsTimetablePost(logisticsTimetablePostRequest)

Create a new timetable entry

### Example
```dart
import 'package:admin_api/api.dart';
// TODO Configure HTTP Bearer authorization: bearerAuth
// Case 1. Use String Token
//defaultApiClient.getAuthentication<HttpBearerAuth>('bearerAuth').setAccessToken('YOUR_ACCESS_TOKEN');
// Case 2. Use Function which generate token.
// String yourTokenGeneratorFunction() { ... }
//defaultApiClient.getAuthentication<HttpBearerAuth>('bearerAuth').setAccessToken(yourTokenGeneratorFunction);

final api_instance = TimetablesApi();
final logisticsTimetablePostRequest = LogisticsTimetablePostRequest(); // LogisticsTimetablePostRequest | 

try {
    final result = api_instance.logisticsTimetablePost(logisticsTimetablePostRequest);
    print(result);
} catch (e) {
    print('Exception when calling TimetablesApi->logisticsTimetablePost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **logisticsTimetablePostRequest** | [**LogisticsTimetablePostRequest**](LogisticsTimetablePostRequest.md)|  | 

### Return type

[**LogisticsTimetablePost201Response**](LogisticsTimetablePost201Response.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **semesterEndPost**
> semesterEndPost(publicId)



### Example
```dart
import 'package:admin_api/api.dart';
// TODO Configure HTTP Bearer authorization: bearerAuth
// Case 1. Use String Token
//defaultApiClient.getAuthentication<HttpBearerAuth>('bearerAuth').setAccessToken('YOUR_ACCESS_TOKEN');
// Case 2. Use Function which generate token.
// String yourTokenGeneratorFunction() { ... }
//defaultApiClient.getAuthentication<HttpBearerAuth>('bearerAuth').setAccessToken(yourTokenGeneratorFunction);

final api_instance = TimetablesApi();
final publicId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    api_instance.semesterEndPost(publicId);
} catch (e) {
    print('Exception when calling TimetablesApi->semesterEndPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **publicId** | **String**|  | 

### Return type

void (empty response body)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **semestersActiveGet**
> SemesterResponse semestersActiveGet()



### Example
```dart
import 'package:admin_api/api.dart';
// TODO Configure HTTP Bearer authorization: bearerAuth
// Case 1. Use String Token
//defaultApiClient.getAuthentication<HttpBearerAuth>('bearerAuth').setAccessToken('YOUR_ACCESS_TOKEN');
// Case 2. Use Function which generate token.
// String yourTokenGeneratorFunction() { ... }
//defaultApiClient.getAuthentication<HttpBearerAuth>('bearerAuth').setAccessToken(yourTokenGeneratorFunction);

final api_instance = TimetablesApi();

try {
    final result = api_instance.semestersActiveGet();
    print(result);
} catch (e) {
    print('Exception when calling TimetablesApi->semestersActiveGet: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**SemesterResponse**](SemesterResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **semestersGet**
> SemestersGet200Response semestersGet()



### Example
```dart
import 'package:admin_api/api.dart';
// TODO Configure HTTP Bearer authorization: bearerAuth
// Case 1. Use String Token
//defaultApiClient.getAuthentication<HttpBearerAuth>('bearerAuth').setAccessToken('YOUR_ACCESS_TOKEN');
// Case 2. Use Function which generate token.
// String yourTokenGeneratorFunction() { ... }
//defaultApiClient.getAuthentication<HttpBearerAuth>('bearerAuth').setAccessToken(yourTokenGeneratorFunction);

final api_instance = TimetablesApi();

try {
    final result = api_instance.semestersGet();
    print(result);
} catch (e) {
    print('Exception when calling TimetablesApi->semestersGet: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**SemestersGet200Response**](SemestersGet200Response.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **semestersPost**
> semestersPost(semestersPostRequest)



### Example
```dart
import 'package:admin_api/api.dart';
// TODO Configure HTTP Bearer authorization: bearerAuth
// Case 1. Use String Token
//defaultApiClient.getAuthentication<HttpBearerAuth>('bearerAuth').setAccessToken('YOUR_ACCESS_TOKEN');
// Case 2. Use Function which generate token.
// String yourTokenGeneratorFunction() { ... }
//defaultApiClient.getAuthentication<HttpBearerAuth>('bearerAuth').setAccessToken(yourTokenGeneratorFunction);

final api_instance = TimetablesApi();
final semestersPostRequest = SemestersPostRequest(); // SemestersPostRequest | 

try {
    api_instance.semestersPost(semestersPostRequest);
} catch (e) {
    print('Exception when calling TimetablesApi->semestersPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **semestersPostRequest** | [**SemestersPostRequest**](SemestersPostRequest.md)|  | 

### Return type

void (empty response body)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

