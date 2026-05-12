# admin_api.api.LecturersApi

## Load the API package
```dart
import 'package:admin_api/api.dart';
```

All URIs are relative to *https://college-app-316955810695.us-east1.run.app/api/v1/admin*

Method | HTTP request | Description
------------- | ------------- | -------------
[**lecturersBatchUploadPost**](LecturersApi.md#lecturersbatchuploadpost) | **POST** /lecturers/batch-upload | Upload CSV
[**lecturersDelete**](LecturersApi.md#lecturersdelete) | **DELETE** /lecturers/{public_id} | Delete a lecturer
[**lecturersGet**](LecturersApi.md#lecturersget) | **GET** /lecturers | 
[**lecturersPost**](LecturersApi.md#lecturerspost) | **POST** /lecturers | 
[**lecturersShow**](LecturersApi.md#lecturersshow) | **GET** /lecturers/{public_id} | Get a lecturer by ID
[**lecturersUpdate**](LecturersApi.md#lecturersupdate) | **PUT** /lecturers/{public_id} | Update a lecturer


# **lecturersBatchUploadPost**
> lecturersBatchUploadPost(file)

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

final api_instance = LecturersApi();
final file = BINARY_DATA_HERE; // MultipartFile | 

try {
    api_instance.lecturersBatchUploadPost(file);
} catch (e) {
    print('Exception when calling LecturersApi->lecturersBatchUploadPost: $e\n');
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

# **lecturersDelete**
> lecturersDelete(publicId)

Delete a lecturer

### Example
```dart
import 'package:admin_api/api.dart';
// TODO Configure HTTP Bearer authorization: bearerAuth
// Case 1. Use String Token
//defaultApiClient.getAuthentication<HttpBearerAuth>('bearerAuth').setAccessToken('YOUR_ACCESS_TOKEN');
// Case 2. Use Function which generate token.
// String yourTokenGeneratorFunction() { ... }
//defaultApiClient.getAuthentication<HttpBearerAuth>('bearerAuth').setAccessToken(yourTokenGeneratorFunction);

final api_instance = LecturersApi();
final publicId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    api_instance.lecturersDelete(publicId);
} catch (e) {
    print('Exception when calling LecturersApi->lecturersDelete: $e\n');
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

# **lecturersGet**
> LecturersGet200Response lecturersGet()



### Example
```dart
import 'package:admin_api/api.dart';
// TODO Configure HTTP Bearer authorization: bearerAuth
// Case 1. Use String Token
//defaultApiClient.getAuthentication<HttpBearerAuth>('bearerAuth').setAccessToken('YOUR_ACCESS_TOKEN');
// Case 2. Use Function which generate token.
// String yourTokenGeneratorFunction() { ... }
//defaultApiClient.getAuthentication<HttpBearerAuth>('bearerAuth').setAccessToken(yourTokenGeneratorFunction);

final api_instance = LecturersApi();

try {
    final result = api_instance.lecturersGet();
    print(result);
} catch (e) {
    print('Exception when calling LecturersApi->lecturersGet: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**LecturersGet200Response**](LecturersGet200Response.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **lecturersPost**
> lecturersPost(lecturersPostRequest)



### Example
```dart
import 'package:admin_api/api.dart';
// TODO Configure HTTP Bearer authorization: bearerAuth
// Case 1. Use String Token
//defaultApiClient.getAuthentication<HttpBearerAuth>('bearerAuth').setAccessToken('YOUR_ACCESS_TOKEN');
// Case 2. Use Function which generate token.
// String yourTokenGeneratorFunction() { ... }
//defaultApiClient.getAuthentication<HttpBearerAuth>('bearerAuth').setAccessToken(yourTokenGeneratorFunction);

final api_instance = LecturersApi();
final lecturersPostRequest = LecturersPostRequest(); // LecturersPostRequest | 

try {
    api_instance.lecturersPost(lecturersPostRequest);
} catch (e) {
    print('Exception when calling LecturersApi->lecturersPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **lecturersPostRequest** | [**LecturersPostRequest**](LecturersPostRequest.md)|  | 

### Return type

void (empty response body)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **lecturersShow**
> LecturersShow200Response lecturersShow(publicId)

Get a lecturer by ID

### Example
```dart
import 'package:admin_api/api.dart';
// TODO Configure HTTP Bearer authorization: bearerAuth
// Case 1. Use String Token
//defaultApiClient.getAuthentication<HttpBearerAuth>('bearerAuth').setAccessToken('YOUR_ACCESS_TOKEN');
// Case 2. Use Function which generate token.
// String yourTokenGeneratorFunction() { ... }
//defaultApiClient.getAuthentication<HttpBearerAuth>('bearerAuth').setAccessToken(yourTokenGeneratorFunction);

final api_instance = LecturersApi();
final publicId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final result = api_instance.lecturersShow(publicId);
    print(result);
} catch (e) {
    print('Exception when calling LecturersApi->lecturersShow: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **publicId** | **String**|  | 

### Return type

[**LecturersShow200Response**](LecturersShow200Response.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **lecturersUpdate**
> LecturersUpdate200Response lecturersUpdate(publicId, lecturersUpdateRequest)

Update a lecturer

### Example
```dart
import 'package:admin_api/api.dart';
// TODO Configure HTTP Bearer authorization: bearerAuth
// Case 1. Use String Token
//defaultApiClient.getAuthentication<HttpBearerAuth>('bearerAuth').setAccessToken('YOUR_ACCESS_TOKEN');
// Case 2. Use Function which generate token.
// String yourTokenGeneratorFunction() { ... }
//defaultApiClient.getAuthentication<HttpBearerAuth>('bearerAuth').setAccessToken(yourTokenGeneratorFunction);

final api_instance = LecturersApi();
final publicId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final lecturersUpdateRequest = LecturersUpdateRequest(); // LecturersUpdateRequest | 

try {
    final result = api_instance.lecturersUpdate(publicId, lecturersUpdateRequest);
    print(result);
} catch (e) {
    print('Exception when calling LecturersApi->lecturersUpdate: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **publicId** | **String**|  | 
 **lecturersUpdateRequest** | [**LecturersUpdateRequest**](LecturersUpdateRequest.md)|  | 

### Return type

[**LecturersUpdate200Response**](LecturersUpdate200Response.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

