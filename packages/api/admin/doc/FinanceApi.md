# admin_api.api.FinanceApi

## Load the API package
```dart
import 'package:admin_api/api.dart';
```

All URIs are relative to *https://api.college.edu/api/v1/admin*

Method | HTTP request | Description
------------- | ------------- | -------------
[**financeFeesGet**](FinanceApi.md#financefeesget) | **GET** /finance/fees | 
[**financeFeesPost**](FinanceApi.md#financefeespost) | **POST** /finance/fees | 
[**financeStudentFeesGet**](FinanceApi.md#financestudentfeesget) | **GET** /finance/students/{student_id}/fees | 
[**financeTransactionsGet**](FinanceApi.md#financetransactionsget) | **GET** /finance/transactions | 
[**financeTransactionsPost**](FinanceApi.md#financetransactionspost) | **POST** /finance/transactions | 


# **financeFeesGet**
> FinanceFeesGet200Response financeFeesGet(studentPublicId, status)



### Example
```dart
import 'package:admin_api/api.dart';
// TODO Configure HTTP Bearer authorization: bearerAuth
// Case 1. Use String Token
//defaultApiClient.getAuthentication<HttpBearerAuth>('bearerAuth').setAccessToken('YOUR_ACCESS_TOKEN');
// Case 2. Use Function which generate token.
// String yourTokenGeneratorFunction() { ... }
//defaultApiClient.getAuthentication<HttpBearerAuth>('bearerAuth').setAccessToken(yourTokenGeneratorFunction);

final api_instance = FinanceApi();
final studentPublicId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final status = status_example; // String | 

try {
    final result = api_instance.financeFeesGet(studentPublicId, status);
    print(result);
} catch (e) {
    print('Exception when calling FinanceApi->financeFeesGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **studentPublicId** | **String**|  | [optional] 
 **status** | **String**|  | [optional] 

### Return type

[**FinanceFeesGet200Response**](FinanceFeesGet200Response.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **financeFeesPost**
> financeFeesPost(financeFeesPostRequest)



### Example
```dart
import 'package:admin_api/api.dart';
// TODO Configure HTTP Bearer authorization: bearerAuth
// Case 1. Use String Token
//defaultApiClient.getAuthentication<HttpBearerAuth>('bearerAuth').setAccessToken('YOUR_ACCESS_TOKEN');
// Case 2. Use Function which generate token.
// String yourTokenGeneratorFunction() { ... }
//defaultApiClient.getAuthentication<HttpBearerAuth>('bearerAuth').setAccessToken(yourTokenGeneratorFunction);

final api_instance = FinanceApi();
final financeFeesPostRequest = FinanceFeesPostRequest(); // FinanceFeesPostRequest | 

try {
    api_instance.financeFeesPost(financeFeesPostRequest);
} catch (e) {
    print('Exception when calling FinanceApi->financeFeesPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **financeFeesPostRequest** | [**FinanceFeesPostRequest**](FinanceFeesPostRequest.md)|  | 

### Return type

void (empty response body)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **financeStudentFeesGet**
> FinanceFeesGet200Response financeStudentFeesGet(studentId)



### Example
```dart
import 'package:admin_api/api.dart';
// TODO Configure HTTP Bearer authorization: bearerAuth
// Case 1. Use String Token
//defaultApiClient.getAuthentication<HttpBearerAuth>('bearerAuth').setAccessToken('YOUR_ACCESS_TOKEN');
// Case 2. Use Function which generate token.
// String yourTokenGeneratorFunction() { ... }
//defaultApiClient.getAuthentication<HttpBearerAuth>('bearerAuth').setAccessToken(yourTokenGeneratorFunction);

final api_instance = FinanceApi();
final studentId = studentId_example; // String | 

try {
    final result = api_instance.financeStudentFeesGet(studentId);
    print(result);
} catch (e) {
    print('Exception when calling FinanceApi->financeStudentFeesGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **studentId** | **String**|  | 

### Return type

[**FinanceFeesGet200Response**](FinanceFeesGet200Response.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **financeTransactionsGet**
> FinanceTransactionsGet200Response financeTransactionsGet()



### Example
```dart
import 'package:admin_api/api.dart';
// TODO Configure HTTP Bearer authorization: bearerAuth
// Case 1. Use String Token
//defaultApiClient.getAuthentication<HttpBearerAuth>('bearerAuth').setAccessToken('YOUR_ACCESS_TOKEN');
// Case 2. Use Function which generate token.
// String yourTokenGeneratorFunction() { ... }
//defaultApiClient.getAuthentication<HttpBearerAuth>('bearerAuth').setAccessToken(yourTokenGeneratorFunction);

final api_instance = FinanceApi();

try {
    final result = api_instance.financeTransactionsGet();
    print(result);
} catch (e) {
    print('Exception when calling FinanceApi->financeTransactionsGet: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**FinanceTransactionsGet200Response**](FinanceTransactionsGet200Response.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **financeTransactionsPost**
> financeTransactionsPost(financeTransactionsPostRequest)



### Example
```dart
import 'package:admin_api/api.dart';
// TODO Configure HTTP Bearer authorization: bearerAuth
// Case 1. Use String Token
//defaultApiClient.getAuthentication<HttpBearerAuth>('bearerAuth').setAccessToken('YOUR_ACCESS_TOKEN');
// Case 2. Use Function which generate token.
// String yourTokenGeneratorFunction() { ... }
//defaultApiClient.getAuthentication<HttpBearerAuth>('bearerAuth').setAccessToken(yourTokenGeneratorFunction);

final api_instance = FinanceApi();
final financeTransactionsPostRequest = FinanceTransactionsPostRequest(); // FinanceTransactionsPostRequest | 

try {
    api_instance.financeTransactionsPost(financeTransactionsPostRequest);
} catch (e) {
    print('Exception when calling FinanceApi->financeTransactionsPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **financeTransactionsPostRequest** | [**FinanceTransactionsPostRequest**](FinanceTransactionsPostRequest.md)|  | 

### Return type

void (empty response body)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

