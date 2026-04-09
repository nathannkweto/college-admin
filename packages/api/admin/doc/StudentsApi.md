# admin_api.api.StudentsApi

## Load the API package
```dart
import 'package:admin_api/api.dart';
```

All URIs are relative to *https://api.college.edu/api/v1/admin*

Method | HTTP request | Description
------------- | ------------- | -------------
[**studentsBatchUploadPost**](StudentsApi.md#studentsbatchuploadpost) | **POST** /students/batch-upload | Upload CSV
[**studentsGet**](StudentsApi.md#studentsget) | **GET** /students | 
[**studentsPost**](StudentsApi.md#studentspost) | **POST** /students | 
[**studentsPromotePost**](StudentsApi.md#studentspromotepost) | **POST** /students/promote | 
[**studentsPromotionPreview**](StudentsApi.md#studentspromotionpreview) | **POST** /students/promotion-preview | 


# **studentsBatchUploadPost**
> studentsBatchUploadPost(file)

Upload CSV

### Example
```dart
import 'package:admin_api/api.dart';
// TODO Configure HTTP Bearer authorization: bearerAuth
// Case 1. Use String Token
//defaultApiClient.getAuthentication<HttpBearerAuth>('bearerAuth').setAccessToken('YOUR_ACCESS_TOKEN');
// Case 2. Use Function which generate token.
// String yourTokenGeneratorFunction() { ... }
//defaultApiClient.getAuthentication<HttpBearerAuth>('bearerAuth').setAccessToken(yourTokenGeneratorFunction);

final api_instance = StudentsApi();
final file = BINARY_DATA_HERE; // MultipartFile | 

try {
    api_instance.studentsBatchUploadPost(file);
} catch (e) {
    print('Exception when calling StudentsApi->studentsBatchUploadPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **file** | **MultipartFile**|  | 

### Return type

void (empty response body)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: multipart/form-data
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **studentsGet**
> StudentsGet200Response studentsGet(programPublicId, search)



### Example
```dart
import 'package:admin_api/api.dart';
// TODO Configure HTTP Bearer authorization: bearerAuth
// Case 1. Use String Token
//defaultApiClient.getAuthentication<HttpBearerAuth>('bearerAuth').setAccessToken('YOUR_ACCESS_TOKEN');
// Case 2. Use Function which generate token.
// String yourTokenGeneratorFunction() { ... }
//defaultApiClient.getAuthentication<HttpBearerAuth>('bearerAuth').setAccessToken(yourTokenGeneratorFunction);

final api_instance = StudentsApi();
final programPublicId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final search = search_example; // String | 

try {
    final result = api_instance.studentsGet(programPublicId, search);
    print(result);
} catch (e) {
    print('Exception when calling StudentsApi->studentsGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **programPublicId** | **String**|  | [optional] 
 **search** | **String**|  | [optional] 

### Return type

[**StudentsGet200Response**](StudentsGet200Response.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **studentsPost**
> studentsPost(studentsPostRequest)



### Example
```dart
import 'package:admin_api/api.dart';
// TODO Configure HTTP Bearer authorization: bearerAuth
// Case 1. Use String Token
//defaultApiClient.getAuthentication<HttpBearerAuth>('bearerAuth').setAccessToken('YOUR_ACCESS_TOKEN');
// Case 2. Use Function which generate token.
// String yourTokenGeneratorFunction() { ... }
//defaultApiClient.getAuthentication<HttpBearerAuth>('bearerAuth').setAccessToken(yourTokenGeneratorFunction);

final api_instance = StudentsApi();
final studentsPostRequest = StudentsPostRequest(); // StudentsPostRequest | 

try {
    api_instance.studentsPost(studentsPostRequest);
} catch (e) {
    print('Exception when calling StudentsApi->studentsPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **studentsPostRequest** | [**StudentsPostRequest**](StudentsPostRequest.md)|  | 

### Return type

void (empty response body)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **studentsPromotePost**
> studentsPromotePost(studentsPromotePostRequest)



### Example
```dart
import 'package:admin_api/api.dart';
// TODO Configure HTTP Bearer authorization: bearerAuth
// Case 1. Use String Token
//defaultApiClient.getAuthentication<HttpBearerAuth>('bearerAuth').setAccessToken('YOUR_ACCESS_TOKEN');
// Case 2. Use Function which generate token.
// String yourTokenGeneratorFunction() { ... }
//defaultApiClient.getAuthentication<HttpBearerAuth>('bearerAuth').setAccessToken(yourTokenGeneratorFunction);

final api_instance = StudentsApi();
final studentsPromotePostRequest = StudentsPromotePostRequest(); // StudentsPromotePostRequest | 

try {
    api_instance.studentsPromotePost(studentsPromotePostRequest);
} catch (e) {
    print('Exception when calling StudentsApi->studentsPromotePost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **studentsPromotePostRequest** | [**StudentsPromotePostRequest**](StudentsPromotePostRequest.md)|  | 

### Return type

void (empty response body)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **studentsPromotionPreview**
> StudentsPromotionPreview200Response studentsPromotionPreview()



### Example
```dart
import 'package:admin_api/api.dart';
// TODO Configure HTTP Bearer authorization: bearerAuth
// Case 1. Use String Token
//defaultApiClient.getAuthentication<HttpBearerAuth>('bearerAuth').setAccessToken('YOUR_ACCESS_TOKEN');
// Case 2. Use Function which generate token.
// String yourTokenGeneratorFunction() { ... }
//defaultApiClient.getAuthentication<HttpBearerAuth>('bearerAuth').setAccessToken(yourTokenGeneratorFunction);

final api_instance = StudentsApi();

try {
    final result = api_instance.studentsPromotionPreview();
    print(result);
} catch (e) {
    print('Exception when calling StudentsApi->studentsPromotionPreview: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**StudentsPromotionPreview200Response**](StudentsPromotionPreview200Response.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

