# admin_api.api.AcademicsApi

## Load the API package
```dart
import 'package:admin_api/api.dart';
```

All URIs are relative to *https://college-app-316955810695.us-east1.run.app/api/v1/admin*

Method | HTTP request | Description
------------- | ------------- | -------------
[**coursesDelete**](AcademicsApi.md#coursesdelete) | **DELETE** /courses/{public_id} | Delete a course
[**coursesGet**](AcademicsApi.md#coursesget) | **GET** /courses | 
[**coursesPost**](AcademicsApi.md#coursespost) | **POST** /courses | 
[**coursesUpdate**](AcademicsApi.md#coursesupdate) | **PUT** /courses/{public_id} | Update an existing course
[**departmentsDelete**](AcademicsApi.md#departmentsdelete) | **DELETE** /departments/{public_id} | Delete a department
[**departmentsGet**](AcademicsApi.md#departmentsget) | **GET** /departments | 
[**departmentsPost**](AcademicsApi.md#departmentspost) | **POST** /departments | 
[**departmentsUpdate**](AcademicsApi.md#departmentsupdate) | **PUT** /departments/{public_id} | Update a department
[**programsCoursesDelete**](AcademicsApi.md#programscoursesdelete) | **DELETE** /programs/{public_id}/courses/{course_public_id} | 
[**programsCoursesGet**](AcademicsApi.md#programscoursesget) | **GET** /programs/{public_id}/courses | 
[**programsCoursesPost**](AcademicsApi.md#programscoursespost) | **POST** /programs/{public_id}/courses | 
[**programsGet**](AcademicsApi.md#programsget) | **GET** /programs | 
[**programsPost**](AcademicsApi.md#programspost) | **POST** /programs | 
[**qualificationsGet**](AcademicsApi.md#qualificationsget) | **GET** /qualifications | 
[**qualificationsPost**](AcademicsApi.md#qualificationspost) | **POST** /qualifications | 


# **coursesDelete**
> CoursesDelete200Response coursesDelete(publicId)

Delete a course

### Example
```dart
import 'package:admin_api/api.dart';
// TODO Configure HTTP Bearer authorization: bearerAuth
// Case 1. Use String Token
//defaultApiClient.getAuthentication<HttpBearerAuth>('bearerAuth').setAccessToken('YOUR_ACCESS_TOKEN');
// Case 2. Use Function which generate token.
// String yourTokenGeneratorFunction() { ... }
//defaultApiClient.getAuthentication<HttpBearerAuth>('bearerAuth').setAccessToken(yourTokenGeneratorFunction);

final api_instance = AcademicsApi();
final publicId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final result = api_instance.coursesDelete(publicId);
    print(result);
} catch (e) {
    print('Exception when calling AcademicsApi->coursesDelete: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **publicId** | **String**|  | 

### Return type

[**CoursesDelete200Response**](CoursesDelete200Response.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **coursesGet**
> CoursesGet200Response coursesGet()



### Example
```dart
import 'package:admin_api/api.dart';
// TODO Configure HTTP Bearer authorization: bearerAuth
// Case 1. Use String Token
//defaultApiClient.getAuthentication<HttpBearerAuth>('bearerAuth').setAccessToken('YOUR_ACCESS_TOKEN');
// Case 2. Use Function which generate token.
// String yourTokenGeneratorFunction() { ... }
//defaultApiClient.getAuthentication<HttpBearerAuth>('bearerAuth').setAccessToken(yourTokenGeneratorFunction);

final api_instance = AcademicsApi();

try {
    final result = api_instance.coursesGet();
    print(result);
} catch (e) {
    print('Exception when calling AcademicsApi->coursesGet: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**CoursesGet200Response**](CoursesGet200Response.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **coursesPost**
> coursesPost(coursesPostRequest)



### Example
```dart
import 'package:admin_api/api.dart';
// TODO Configure HTTP Bearer authorization: bearerAuth
// Case 1. Use String Token
//defaultApiClient.getAuthentication<HttpBearerAuth>('bearerAuth').setAccessToken('YOUR_ACCESS_TOKEN');
// Case 2. Use Function which generate token.
// String yourTokenGeneratorFunction() { ... }
//defaultApiClient.getAuthentication<HttpBearerAuth>('bearerAuth').setAccessToken(yourTokenGeneratorFunction);

final api_instance = AcademicsApi();
final coursesPostRequest = CoursesPostRequest(); // CoursesPostRequest | 

try {
    api_instance.coursesPost(coursesPostRequest);
} catch (e) {
    print('Exception when calling AcademicsApi->coursesPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **coursesPostRequest** | [**CoursesPostRequest**](CoursesPostRequest.md)|  | 

### Return type

void (empty response body)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **coursesUpdate**
> CoursesUpdate200Response coursesUpdate(publicId, coursesUpdateRequest)

Update an existing course

### Example
```dart
import 'package:admin_api/api.dart';
// TODO Configure HTTP Bearer authorization: bearerAuth
// Case 1. Use String Token
//defaultApiClient.getAuthentication<HttpBearerAuth>('bearerAuth').setAccessToken('YOUR_ACCESS_TOKEN');
// Case 2. Use Function which generate token.
// String yourTokenGeneratorFunction() { ... }
//defaultApiClient.getAuthentication<HttpBearerAuth>('bearerAuth').setAccessToken(yourTokenGeneratorFunction);

final api_instance = AcademicsApi();
final publicId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final coursesUpdateRequest = CoursesUpdateRequest(); // CoursesUpdateRequest | 

try {
    final result = api_instance.coursesUpdate(publicId, coursesUpdateRequest);
    print(result);
} catch (e) {
    print('Exception when calling AcademicsApi->coursesUpdate: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **publicId** | **String**|  | 
 **coursesUpdateRequest** | [**CoursesUpdateRequest**](CoursesUpdateRequest.md)|  | 

### Return type

[**CoursesUpdate200Response**](CoursesUpdate200Response.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **departmentsDelete**
> departmentsDelete(publicId)

Delete a department

### Example
```dart
import 'package:admin_api/api.dart';
// TODO Configure HTTP Bearer authorization: bearerAuth
// Case 1. Use String Token
//defaultApiClient.getAuthentication<HttpBearerAuth>('bearerAuth').setAccessToken('YOUR_ACCESS_TOKEN');
// Case 2. Use Function which generate token.
// String yourTokenGeneratorFunction() { ... }
//defaultApiClient.getAuthentication<HttpBearerAuth>('bearerAuth').setAccessToken(yourTokenGeneratorFunction);

final api_instance = AcademicsApi();
final publicId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    api_instance.departmentsDelete(publicId);
} catch (e) {
    print('Exception when calling AcademicsApi->departmentsDelete: $e\n');
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

# **departmentsGet**
> DepartmentsGet200Response departmentsGet()



### Example
```dart
import 'package:admin_api/api.dart';
// TODO Configure HTTP Bearer authorization: bearerAuth
// Case 1. Use String Token
//defaultApiClient.getAuthentication<HttpBearerAuth>('bearerAuth').setAccessToken('YOUR_ACCESS_TOKEN');
// Case 2. Use Function which generate token.
// String yourTokenGeneratorFunction() { ... }
//defaultApiClient.getAuthentication<HttpBearerAuth>('bearerAuth').setAccessToken(yourTokenGeneratorFunction);

final api_instance = AcademicsApi();

try {
    final result = api_instance.departmentsGet();
    print(result);
} catch (e) {
    print('Exception when calling AcademicsApi->departmentsGet: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**DepartmentsGet200Response**](DepartmentsGet200Response.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **departmentsPost**
> departmentsPost(departmentsPostRequest)



### Example
```dart
import 'package:admin_api/api.dart';
// TODO Configure HTTP Bearer authorization: bearerAuth
// Case 1. Use String Token
//defaultApiClient.getAuthentication<HttpBearerAuth>('bearerAuth').setAccessToken('YOUR_ACCESS_TOKEN');
// Case 2. Use Function which generate token.
// String yourTokenGeneratorFunction() { ... }
//defaultApiClient.getAuthentication<HttpBearerAuth>('bearerAuth').setAccessToken(yourTokenGeneratorFunction);

final api_instance = AcademicsApi();
final departmentsPostRequest = DepartmentsPostRequest(); // DepartmentsPostRequest | 

try {
    api_instance.departmentsPost(departmentsPostRequest);
} catch (e) {
    print('Exception when calling AcademicsApi->departmentsPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **departmentsPostRequest** | [**DepartmentsPostRequest**](DepartmentsPostRequest.md)|  | 

### Return type

void (empty response body)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **departmentsUpdate**
> DepartmentsUpdate200Response departmentsUpdate(publicId, departmentsUpdateRequest)

Update a department

### Example
```dart
import 'package:admin_api/api.dart';
// TODO Configure HTTP Bearer authorization: bearerAuth
// Case 1. Use String Token
//defaultApiClient.getAuthentication<HttpBearerAuth>('bearerAuth').setAccessToken('YOUR_ACCESS_TOKEN');
// Case 2. Use Function which generate token.
// String yourTokenGeneratorFunction() { ... }
//defaultApiClient.getAuthentication<HttpBearerAuth>('bearerAuth').setAccessToken(yourTokenGeneratorFunction);

final api_instance = AcademicsApi();
final publicId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final departmentsUpdateRequest = DepartmentsUpdateRequest(); // DepartmentsUpdateRequest | 

try {
    final result = api_instance.departmentsUpdate(publicId, departmentsUpdateRequest);
    print(result);
} catch (e) {
    print('Exception when calling AcademicsApi->departmentsUpdate: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **publicId** | **String**|  | 
 **departmentsUpdateRequest** | [**DepartmentsUpdateRequest**](DepartmentsUpdateRequest.md)|  | 

### Return type

[**DepartmentsUpdate200Response**](DepartmentsUpdate200Response.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **programsCoursesDelete**
> programsCoursesDelete(publicId, coursePublicId)



### Example
```dart
import 'package:admin_api/api.dart';
// TODO Configure HTTP Bearer authorization: bearerAuth
// Case 1. Use String Token
//defaultApiClient.getAuthentication<HttpBearerAuth>('bearerAuth').setAccessToken('YOUR_ACCESS_TOKEN');
// Case 2. Use Function which generate token.
// String yourTokenGeneratorFunction() { ... }
//defaultApiClient.getAuthentication<HttpBearerAuth>('bearerAuth').setAccessToken(yourTokenGeneratorFunction);

final api_instance = AcademicsApi();
final publicId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final coursePublicId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    api_instance.programsCoursesDelete(publicId, coursePublicId);
} catch (e) {
    print('Exception when calling AcademicsApi->programsCoursesDelete: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **publicId** | **String**|  | 
 **coursePublicId** | **String**|  | 

### Return type

void (empty response body)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **programsCoursesGet**
> ProgramsCoursesGet200Response programsCoursesGet(publicId)



### Example
```dart
import 'package:admin_api/api.dart';
// TODO Configure HTTP Bearer authorization: bearerAuth
// Case 1. Use String Token
//defaultApiClient.getAuthentication<HttpBearerAuth>('bearerAuth').setAccessToken('YOUR_ACCESS_TOKEN');
// Case 2. Use Function which generate token.
// String yourTokenGeneratorFunction() { ... }
//defaultApiClient.getAuthentication<HttpBearerAuth>('bearerAuth').setAccessToken(yourTokenGeneratorFunction);

final api_instance = AcademicsApi();
final publicId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final result = api_instance.programsCoursesGet(publicId);
    print(result);
} catch (e) {
    print('Exception when calling AcademicsApi->programsCoursesGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **publicId** | **String**|  | 

### Return type

[**ProgramsCoursesGet200Response**](ProgramsCoursesGet200Response.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **programsCoursesPost**
> programsCoursesPost(publicId, programsCoursesPostRequest)



### Example
```dart
import 'package:admin_api/api.dart';
// TODO Configure HTTP Bearer authorization: bearerAuth
// Case 1. Use String Token
//defaultApiClient.getAuthentication<HttpBearerAuth>('bearerAuth').setAccessToken('YOUR_ACCESS_TOKEN');
// Case 2. Use Function which generate token.
// String yourTokenGeneratorFunction() { ... }
//defaultApiClient.getAuthentication<HttpBearerAuth>('bearerAuth').setAccessToken(yourTokenGeneratorFunction);

final api_instance = AcademicsApi();
final publicId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final programsCoursesPostRequest = ProgramsCoursesPostRequest(); // ProgramsCoursesPostRequest | 

try {
    api_instance.programsCoursesPost(publicId, programsCoursesPostRequest);
} catch (e) {
    print('Exception when calling AcademicsApi->programsCoursesPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **publicId** | **String**|  | 
 **programsCoursesPostRequest** | [**ProgramsCoursesPostRequest**](ProgramsCoursesPostRequest.md)|  | 

### Return type

void (empty response body)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **programsGet**
> ProgramsGet200Response programsGet(qualificationPublicId, departmentPublicId)



### Example
```dart
import 'package:admin_api/api.dart';
// TODO Configure HTTP Bearer authorization: bearerAuth
// Case 1. Use String Token
//defaultApiClient.getAuthentication<HttpBearerAuth>('bearerAuth').setAccessToken('YOUR_ACCESS_TOKEN');
// Case 2. Use Function which generate token.
// String yourTokenGeneratorFunction() { ... }
//defaultApiClient.getAuthentication<HttpBearerAuth>('bearerAuth').setAccessToken(yourTokenGeneratorFunction);

final api_instance = AcademicsApi();
final qualificationPublicId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final departmentPublicId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final result = api_instance.programsGet(qualificationPublicId, departmentPublicId);
    print(result);
} catch (e) {
    print('Exception when calling AcademicsApi->programsGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **qualificationPublicId** | **String**|  | [optional] 
 **departmentPublicId** | **String**|  | [optional] 

### Return type

[**ProgramsGet200Response**](ProgramsGet200Response.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **programsPost**
> programsPost(programsPostRequest)



### Example
```dart
import 'package:admin_api/api.dart';
// TODO Configure HTTP Bearer authorization: bearerAuth
// Case 1. Use String Token
//defaultApiClient.getAuthentication<HttpBearerAuth>('bearerAuth').setAccessToken('YOUR_ACCESS_TOKEN');
// Case 2. Use Function which generate token.
// String yourTokenGeneratorFunction() { ... }
//defaultApiClient.getAuthentication<HttpBearerAuth>('bearerAuth').setAccessToken(yourTokenGeneratorFunction);

final api_instance = AcademicsApi();
final programsPostRequest = ProgramsPostRequest(); // ProgramsPostRequest | 

try {
    api_instance.programsPost(programsPostRequest);
} catch (e) {
    print('Exception when calling AcademicsApi->programsPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **programsPostRequest** | [**ProgramsPostRequest**](ProgramsPostRequest.md)|  | 

### Return type

void (empty response body)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **qualificationsGet**
> QualificationsGet200Response qualificationsGet()



### Example
```dart
import 'package:admin_api/api.dart';
// TODO Configure HTTP Bearer authorization: bearerAuth
// Case 1. Use String Token
//defaultApiClient.getAuthentication<HttpBearerAuth>('bearerAuth').setAccessToken('YOUR_ACCESS_TOKEN');
// Case 2. Use Function which generate token.
// String yourTokenGeneratorFunction() { ... }
//defaultApiClient.getAuthentication<HttpBearerAuth>('bearerAuth').setAccessToken(yourTokenGeneratorFunction);

final api_instance = AcademicsApi();

try {
    final result = api_instance.qualificationsGet();
    print(result);
} catch (e) {
    print('Exception when calling AcademicsApi->qualificationsGet: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**QualificationsGet200Response**](QualificationsGet200Response.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **qualificationsPost**
> qualificationsPost(departmentsPostRequest)



### Example
```dart
import 'package:admin_api/api.dart';
// TODO Configure HTTP Bearer authorization: bearerAuth
// Case 1. Use String Token
//defaultApiClient.getAuthentication<HttpBearerAuth>('bearerAuth').setAccessToken('YOUR_ACCESS_TOKEN');
// Case 2. Use Function which generate token.
// String yourTokenGeneratorFunction() { ... }
//defaultApiClient.getAuthentication<HttpBearerAuth>('bearerAuth').setAccessToken(yourTokenGeneratorFunction);

final api_instance = AcademicsApi();
final departmentsPostRequest = DepartmentsPostRequest(); // DepartmentsPostRequest | 

try {
    api_instance.qualificationsPost(departmentsPostRequest);
} catch (e) {
    print('Exception when calling AcademicsApi->qualificationsPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **departmentsPostRequest** | [**DepartmentsPostRequest**](DepartmentsPostRequest.md)|  | 

### Return type

void (empty response body)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

